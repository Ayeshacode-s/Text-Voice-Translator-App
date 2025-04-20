import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dioPack;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';
import 'package:translator/translator.dart' show GoogleTranslator, Translation;

import '../appview/bottombar.dart';
import '../model/usermodel.dart';
import '../routes/app_pages.dart';
import '../utilities/loader.dart';
import '../utilities/splashscreen.dart';

class CredentialController extends GetxController {
  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();

  final signUpEmailController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();

  final forgotEmailController = TextEditingController();
  final passwordForgotPassController = TextEditingController();
  final confirmPasswordForgotPassController = TextEditingController();

  TextEditingController createProfileNameController = TextEditingController();
  TextEditingController createProfileAddressController =
  TextEditingController();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => SplashScreen())
        : Get.offAllNamed(Routes.login);
  }

  Future createUserWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } catch (e) {
      print(e);
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future signinUserWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      showLoading();
      final responseData = await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        BotToast.closeAllLoading();
        Get.snackbar("Success", " Signed in Successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      });

      print(responseData);
      Get.to(() => BottomBarWidget());
    } on FirebaseException catch (e) {
      Get.snackbar("Error", "${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(e);
      BotToast.closeAllLoading();
    } catch (c) {
      print(c);
      BotToast.closeAllLoading();
    }
  }

  Future createUser(UserModel user) async {
    try {
      await _db
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .set(user.toJson())
          .whenComplete(() {
        Get.snackbar("Success", "Your account has been created.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      });
    } catch (e) {
      Get.snackbar("Error", "Something went wrong.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future registerUser(user) async {
    showLoading();
    try {
      await createUserWithEmailAndPassword(
          email: signUpEmailController.text.trim(),
          password: signUpConfirmPasswordController.text);
      await createUser(user);
      createProfileNameController.clear();
      signUpEmailController.clear();
      signUpConfirmPasswordController.clear();
      signUpPhoneController.clear();
      createProfileAddressController.clear();

      Get.offAllNamed(Routes.login);
    } catch (e) {
      BotToast.closeAllLoading();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  String userId = "";
  Future getUserDetails() async {
    final email = firebaseUser.value?.email;
    if (email != null) {
      final snapshot =
      await _db.collection("Users").doc(_auth.currentUser!.uid).get();
      print(snapshot.data());

      final userData = UserModel.fromSnapshot(snapshot);

      return userData;
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future updateUserDetails(UserModel user) async {
    try {
      showLoading();
      await _db
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .update(user.toJson())
          .whenComplete(() {})
          .catchError((error, stackTrace) {
        print("FireBaser: $error");
        Get.snackbar("Error", "Something went wrong. Try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      });
      BotToast.closeAllLoading();
      Get.to(() => BottomBarWidget());
    } on FirebaseException catch (e) {
      print("FireBaser: $e");
      BotToast.closeAllLoading();
    } catch (c) {
      BotToast.closeAllLoading();
      print(c);
    }
  }

  Future<String> apiTranslator(String text) async {
    try {
      String detectedLanguage = await detectLanguageWithGoogleAPI(text);
      print('Detected Language: $detectedLanguage');

      String translatedText = '';
      if (detectedLanguage == 'pa') {
        translatedText = await translateWithChatGPT(text);
      } else {
        GoogleTranslator translator = GoogleTranslator(); // Instantiate GoogleTranslator
        Translation translation = await translator.translate(text, to: 'pa');
        translatedText = translation.text ?? 'Translation Error';
      }
      return translatedText;
    } catch (error) {
      print('Translation error: $error');
      return 'Translation Error';
    }
  }

  Future<String> detectLanguageWithGoogleAPI(String text) async {
    try {
      dioPack.Dio dio = dioPack.Dio();

      var options = dioPack.Options(
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'X-RapidAPI-Key': '10b1b38e9emsh30892ae316ac916p157a32jsn04973525bcd7',
          'X-RapidAPI-Host': 'google-translation-unlimited.p.rapidapi.com',
        },
      );

      var body = {
        'q': text,
      };

      dioPack.Response response = await dio.post(
        'https://google-translation-unlimited.p.rapidapi.com/language/translate/v2/detect',
        data: body,
        options: options,
      );

      Map<String, dynamic> responseData = response.data;
      if (responseData.containsKey('data')) {
        List<dynamic> detections = responseData['data']['detections'];
        if (detections.isNotEmpty) {
          List<dynamic> detection = detections[0];
          if (detection.isNotEmpty) {
            String languageCode = detection[0]['language'];
            return languageCode;
          }
        }
      }
    } catch (error) {
      print('Language detection error: $error');
    }

    return '';
  }
  Future<String> translateWithChatGPT(String text) async {
    dioPack.Dio dio = dioPack.Dio();

    var options = dioPack.Options(
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': '10b1b38e9emsh30892ae316ac916p157a32jsn04973525bcd7',
        'X-RapidAPI-Host': 'chatgpt-best-price.p.rapidapi.com',
      },
    );

    var data = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content': 'Convert the following into pakistani pure punjabi Nastaliq transcript, just respond result. \'$text\''
        }
      ]
    };

    dioPack.Response response = await dio.post(
      'https://chatgpt-best-price.p.rapidapi.com/v1/chat/completions',
      data: data,
      options: options,
    );

    print(response.data);
    return "${response.data['choices'][0]['message']['content']}";
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    createProfileNameController.clear();
    signUpEmailController.clear();
    signUpConfirmPasswordController.clear();
    signUpPhoneController.clear();
    createProfileAddressController.clear();
    Get.offAllNamed(Routes.login);
  }
}

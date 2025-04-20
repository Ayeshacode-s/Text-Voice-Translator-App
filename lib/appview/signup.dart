import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicetext/routes/app_pages.dart';
import 'package:voicetext/utilities/custombutton.dart';
import '../constant/color.dart';
import '../controller/credentialcontroller.dart';
import '../model/usermodel.dart';
import '../utilities/TextStyle.dart';
import '../utilities/textfield.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  CredentialController controller = Get.find();

  final formKeySignIn = GlobalKey<FormState>();

  RxBool isPassword = true.obs;

  RxBool isConfirmPassword = true.obs;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    children: [

                      Text("SIGN UP",
                          style: montserratBold(
                              color: AppColors.primaryColor,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: h * .02,
                      ),
                      CustomTextField(
                        controller: controller.createProfileNameController,
                        mainPadding: EdgeInsets.zero,
                        borderColor: AppColors.primaryColor,
                        hint: "Name",
                        isEmail: true,
                        validationError: "Name",
                        isBorder: true,
                        isUnderLineBorder: false,
                        radius: 28,
                        fillColor: AppColors.textColor,
                        filled: true,
                        isTransparentBorder: false,
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        prefixIcon:
                        Icon(Icons.person, color: AppColors.primaryColor),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: controller.signUpEmailController,
                        mainPadding: EdgeInsets.zero,
                        borderColor: AppColors.primaryColor,
                        hint: "Email",
                        isEmail: true,
                        validationError: "Email",
                        isBorder: true,
                        isUnderLineBorder: false,
                        radius: 28,
                        fillColor: AppColors.textColor,
                        filled: true,
                        isTransparentBorder: false,
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        prefixIcon:
                        Icon(Icons.email, color: AppColors.primaryColor),
                      ),
                      SizedBox(
                        height: h * .015,
                      ),
                      CustomTextField(
                        controller: controller.signUpPhoneController,
                        mainPadding: EdgeInsets.zero,
                        hint: "Phone",
                        validationError: "Phone Number",
                        borderColor: AppColors.primaryColor,
                        isBorder: true,
                        isUnderLineBorder: false,
                        radius: 28,
                        fillColor: AppColors.textColor,
                        filled: true,
                        isTransparentBorder: false,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: h * .015,
                      ),
                      Obx(() {
                        return CustomTextField(
                          controller: controller.signUpPasswordController,
                          obscureText: isPassword.value,
                          mainPadding: EdgeInsets.zero,
                          hint: "Password",
                          validationError: "Password",
                          borderColor: AppColors.primaryColor,
                          isBorder: true,
                          isUnderLineBorder: false,
                          radius: 28,
                          fillColor: AppColors.textColor,
                          filled: true,
                          isTransparentBorder: false,
                          padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              isPassword.value = !isPassword.value;
                            },
                            child: Icon(
                              isPassword.value == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: h * .015,
                      ),
                      Obx(() {
                        return CustomTextField(
                          controller: controller
                              .signUpConfirmPasswordController,
                          obscureText: isConfirmPassword.value,
                          mainPadding: EdgeInsets.zero,
                          hint: "Confirm Password",
                          validationError: "Confirm Password",
                          isConfirmPassword: true,
                          borderColor: AppColors.primaryColor,
                          isBorder: true,
                          isUnderLineBorder: false,
                          radius: 28,
                          fillColor: AppColors.textColor,
                          filled: true,
                          isTransparentBorder: false,
                          padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              isConfirmPassword.value =
                              !isConfirmPassword.value;
                            },
                            child: Icon(
                              isConfirmPassword.value == true
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: h * .015,
                      ),
                      CustomTextField(
                        controller: controller.createProfileAddressController,
                        mainPadding: EdgeInsets.zero,
                        borderColor: AppColors.primaryColor,
                        hint: "Address",
                        isEmail: true,
                        validationError: "Address",
                        isBorder: true,
                        isUnderLineBorder: false,
                        radius: 28,
                        fillColor: AppColors.textColor,
                        filled: true,
                        isTransparentBorder: false,
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        prefixIcon: Icon(Icons.location_city,
                            color: AppColors.primaryColor),
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      Center(
                        child: SizedBox(
                          height: 60,
                          width: w * 1,
                          child: CustomButton(
                            onTap: () {
                              // if(formKeySignIn.currentState!.validate()){
                              final user = UserModel(
                                  fullName: controller
                                      .createProfileNameController.text.trim(),
                                  email: controller.signUpEmailController.text
                                      .trim(),
                                  password: controller
                                      .signUpConfirmPasswordController.text,
                                  phone: controller.signUpPhoneController.text
                                      .trim(),
                                  address: controller
                                      .createProfileAddressController.text
                                      .trim()
                              );
                              // controller.createUserWithEmailAndPassword(email:controller.signUpEmailController.text.trim(),password:  controller.signUpConfirmPasswordController.text );
                              controller.registerUser(user);
                              // }
                            },
                            borderColor: AppColors.transparantColor,
                            child: Center(
                              child: Text("SIGN UP",
                                  style: montserratRegular(
                                      color: AppColors.textColor,
                                      fontSize: h * .022,
                                      fontWeight: FontWeight.w400)),
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * .03,
                      ),
                      SizedBox(
                        width: w * 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?  ",
                                  style: montserratRegular(
                                    color: AppColors.hintColor,
                                    fontSize: h * .02,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamedUntil(
                                      Routes.login,
                                      ModalRoute.withName(Routes.login),
                                    );
                                  },
                                  child: Text(
                                    "SIGN IN!",
                                    style: montserratBold(
                                      color: Colors.black,
                                      fontSize: h * .021,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Column(
                              children: [
                                SizedBox(height: 8.0),
                                Image.asset(
                                  'assets/images/Sign up-rafiki.png',
                                  width: 200,
                                  height: 200,
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
                ]
              ),
        )

          ]
        ),
      ),
      )
    );
  }
}
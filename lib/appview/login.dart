import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../controller/credentialcontroller.dart';
import 'package:voicetext/routes/app_pages.dart';
import '../utilities/TextStyle.dart';
import '../utilities/custombutton.dart';
import '../utilities/textfield.dart';


class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  CredentialController controller = Get.find();

  final formKeySignIn = GlobalKey<FormState>();

  RxBool isPassword = true.obs;

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
        canPop: false,
        child: GetBuilder<CredentialController>(
            initState: (x) {
              print("Builder data");
            },
            // no need to initialize Controller ever again, just mention the type
            builder: (credentialController) => Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child : Form(
                  key : formKeySignIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset(
                      'assets/images/Tablet login-rafiki.png',
                      width: 250, // Adjust the width of the image to fit the screen
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Text("LOGIN",
                          style: montserratBold(
                              color: AppColors.primaryColor,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),


                      SizedBox(height: 20),
                      CustomTextField(
                        controller: controller.signInEmailController,
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
                        prefixIcon: Icon(Icons.email,
                            color: AppColors.primaryColor),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Obx(() {
                        return CustomTextField(
                          controller: controller.signInPasswordController,
                          obscureText: isPassword.value,
                          mainPadding: EdgeInsets.zero,
                          hint: "Password",
                          borderColor: AppColors.primaryColor,
                          validationError: "Password",
                          isBorder: true,
                          isUnderLineBorder: false,
                          fillColor: AppColors.textColor,
                          filled: true,
                          isTransparentBorder: false,
                          radius: 28,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          prefixIcon: Icon(Icons.lock,
                              color: AppColors.primaryColor),
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
                        height: 20,
                      ),
                      SizedBox(
                        height: h * .05,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: w * 1,
                          child: CustomButton(
                            onTap: () {
                              controller.signinUserWithEmailAndPassword(email: controller.signInEmailController.text.trim(),password: controller.signInPasswordController.text);
                            },
                            borderColor: AppColors.transparantColor,
                            child: Center(
                              child: Text("SIGN IN",
                                  style: montserratRegular(
                                      color: AppColors.textColor,
                                      fontSize: h * .022,
                                      fontWeight: FontWeight.w400)),
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: h * .03,
                      // ),
                      SizedBox(
                        width: w * 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(
                              height: h * .03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?  ",
                                    style: montserratRegular(
                                        color: AppColors.hintColor,
                                        fontSize: h * .02,
                                        fontWeight: FontWeight.w400)),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamedUntil(Routes.signUp,
                                        ModalRoute.withName(Routes.signUp));
                                  },
                                  child: Text("SIGN UP!",
                                      style: montserratBold(
                                          color: Colors.black,
                                          fontSize: h * .021,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))));
  }
}

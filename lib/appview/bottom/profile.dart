import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voicetext/utilities/textfield.dart';
import '../../constant/color.dart';
import '../../controller/credentialcontroller.dart';
import '../../model/usermodel.dart';
import '../../utilities/TextStyle.dart';
import '../../utilities/custombutton.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _SignupState();
}

class _SignupState extends State<Profile> {
  CredentialController controller = Get.find();

  final formKeySignIn = GlobalKey<FormState>();

  RxBool isPassword = true.obs;

  RxBool isConfirmPassword = true.obs;

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    // double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 700,
              width: 500,
              child: FutureBuilder(
                  future: controller.getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserModel userData = snapshot.data;
                        controller.createProfileNameController.text =
                            userData.fullName!;
                        controller.signUpEmailController.text = userData.email!;
                        controller.signUpPhoneController.text = userData.phone!;
                        controller.signUpPasswordController.text =
                            userData.password!;
                        controller.createProfileAddressController.text =
                            userData.address!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Profile",
                                style: montserratBold(
                                    color: AppColors.primaryColor,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomTextField(
                              controller:
                                  controller.createProfileNameController,
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              prefixIcon: const Icon(Icons.person,
                                  color: AppColors.primaryColor),
                            ),
                            const SizedBox(height: 10),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              prefixIcon: const Icon(Icons.email,
                                  color: AppColors.primaryColor),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: controller.signUpPhoneController,
                              mainPadding: EdgeInsets.zero,
                              textInputType: TextInputType.phone,
                              hint: "Phone",
                              isEmail: false,
                              validationError: "",
                              borderColor: AppColors.primaryColor,
                              isBorder: true,
                              isUnderLineBorder: false,
                              radius: 28,
                              fillColor: AppColors.textColor,
                              filled: true,
                              isTransparentBorder: false,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              prefixIcon: const Icon(
                                Icons.phone_android,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                prefixIcon: const Icon(Icons.lock),
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
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller:
                                  controller.createProfileAddressController,
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              prefixIcon: const Icon(Icons.location_city,
                                  color: AppColors.primaryColor),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: SizedBox(
                                height: 60,
                                width: 500,
                                child: CustomButton(
                                  onTap: () async{
                                    final userData = UserModel(
                                      fullName: controller.createProfileNameController.text.trim(),
                                      email: controller.signUpEmailController.text.trim(),
                                      password: controller.signUpPasswordController.text,
                                      phone: controller.signUpPhoneController.text.trim(),
                                      address: controller.createProfileAddressController.text.trim(),

                                    );
                                    await  controller.updateUserDetails(userData);
                                  },
                                  borderColor: AppColors.transparantColor,
                                  borderRadius: BorderRadius.circular(40),
                                  child: Center(
                                    child: Text("Edit",
                                        style: montserratRegular(
                                            color: AppColors.textColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString(),
                              style: montserratBold(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

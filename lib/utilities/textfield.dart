// ignore_for_file: file_names

// import 'package:divvi/modules/auth/controllers/credendialController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../constant/color.dart';
import '../controller/credentialcontroller.dart';
import 'TextStyle.dart';


// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  bool? isEmail = false;
  bool? obscureText = false;
  bool? isTransparentBorder = false;
  VoidCallback? onTap;
  bool? isPhone = false;
  bool? isBorder = true;
  bool? isUnderLineBorder = true;
  bool? isConfirmPassword = false;
  bool? readOnly = false;
  bool? isFromSignup = false;
  bool? isFromSetting = false;
  String? validationError;
  String? initialText;
  int? maxLines = 1;
  int? minLines;
  int? maxLength;
  String? hint;
  String? label;
  double? radius;
  Color? color;
  EdgeInsets mainPadding;
  Color? cursorColor;
  Color fillColor;
  bool filled;
  bool expands;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? onFieldSubmitted;
  dynamic formatter;
  Widget? suffixIcon;
  Widget? prefixIcon;
  final EdgeInsets? padding;
  final TextInputType? textInputType;
  final TextAlignVertical textAlignVertical;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final Color? borderColor;
  final FocusNode? focusNode;
  CustomTextField(
      {Key? key,this.initialText,
        this.borderColor,
        this.hintStyle,
        this.label,
        this.textAlignVertical = TextAlignVertical.top,
        this.textInputType = TextInputType.text,
        this.filled = false,
        this.expands = false,
        this.fillColor = Colors.transparent,
        this.textAlign = TextAlign.start,
        this.controller,
        this.isEmail = false,
        this.isUnderLineBorder = true,
        this.obscureText = false,
        this.isFromSignup = false,
        this.validationError = "",
        this.padding,
        this.onChanged,
        this.suffixIcon,
        this.onFieldSubmitted,
        this.onTap,
        this.prefixIcon,
        this.style,
        this.formatter,
        this.cursorColor,
        this.contentPadding,
        this.readOnly = false,
        this.isFromSetting = false,
        this.isTransparentBorder = false,
        this.hint,
        this.mainPadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        this.color,
        this.radius = 10,
        this.minLines,
        this.maxLength,
        this.labelStyle,
        this.maxLines = 1,
        this.isPhone = false,
        this.isBorder = true,
        this.isConfirmPassword = false,
        this.focusNode})
      : super(key: key);

  // final CreateJobController jobController = Get.put(CreateJobController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mainPadding,
      child: TextFormField(
        initialValue: initialText,
        textAlignVertical: textAlignVertical,
        onTap: onTap,
        expands: expands,
        textAlign: textAlign,
        inputFormatters: formatter == null ? null : [formatter],
        cursorColor: cursorColor ?? AppColors.primaryColor,
        readOnly: readOnly!,
        enabled: true,
        minLines: minLines,
        onFieldSubmitted: onFieldSubmitted, //
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        style: style ??
       montserratRegular(
              fontSize: 15,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w300,
            ),
        obscureText: obscureText!,
        keyboardType: isPhone == true
            ? TextInputType.phone
            : isEmail == true
            ? TextInputType.emailAddress
            : textInputType ?? TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter ${validationError!.toLowerCase()}';
          } else {
            if (isEmail == true) {
              return validateEmail(value);
            } else if (validationError == "Password") {
              return validatePassword(value);
            } else if (validationError == "Confirm Password") {
              CredentialController controller = Get.find();
              if (controller.signUpPasswordController.text ==
                  controller.signUpConfirmPasswordController.text) {
                return validatePassword(value);
              } else {
                return "Password doesn't match";
              }
            } else if (validationError == "Phone") {
              return "Phone Number is empty";
            } else if (validationError == "Your Birthday") {
              int thirteenYears = 6570;
              int difference =
                  DateTime.now().difference(DateTime.parse(value)).inDays;
              if (difference >= thirteenYears) {
                return null;
              } else {
                return "Age must be greater than 18";
              }
            } else if (validationError == "First Name" ||
                validationError == "Last Name" ||
                validationError == "card name") {
              return fullNameValidate(value);
            } else if (validationError == "expiration month") {
              if (int.parse(value) > 12 || int.parse(value) < 1) {
                return "Invalid Month";
              } else {
                return null;
              }
            } else if (validationError == "expiration year") {
              if (int.parse(value) - DateTime.now().year > 5) {
                return "Expiry is too greater";
              } else if (int.parse(value) < DateTime.now().year) {
                return "Year must be greater";
              } else {
                return null;
              }
            } else {
              return null;
            }
          }
        },

        decoration: InputDecoration(
          fillColor: fillColor,
          filled: filled,
          contentPadding: padding ??
              EdgeInsets.only(left: 15, top: suffixIcon == null ? 0 : 15),
          border: isBorder == true
              ? isUnderLineBorder == false
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 1),
            borderSide: BorderSide(
                color: isTransparentBorder == false
                    ? AppColors.primaryColor
                    : Colors.transparent),
          )
              : UnderlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: isTransparentBorder == false
                    ? AppColors.textColor
                    : Colors.transparent),
          )
              : InputBorder.none,
          enabledBorder: isBorder == true
              ? isUnderLineBorder == false
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 1),
            borderSide: BorderSide(
                color: isTransparentBorder == false
                    ? borderColor!
                    : Colors.transparent),
          )
              : UnderlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: isTransparentBorder == false
                    ? AppColors.textColor
                    : Colors.transparent),
          )
              : InputBorder.none,
          focusedBorder: isBorder == true
              ? isUnderLineBorder == false
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 1),
            borderSide: BorderSide(
                color: isTransparentBorder == false
                    ? AppColors.primaryColor
                    : Colors.transparent),
          )
              : UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: isTransparentBorder == false
                      ? AppColors.textColor
                      : Colors.transparent))
              : InputBorder.none,
          hintText: hint ?? "",
          label: label == null
              ? null
              : Text(
            label!,
            style: labelStyle ??
             montserratRegular(
                  fontSize: 14,
                ),
          ),
          // suffix: suffix,
          // prefix: prefix,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: hintStyle ??
              montserratRegular(
                fontSize: 16,
                color: AppColors.hintColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        maxLength: maxLength,
        maxLines: maxLines,
      ),
    );
  }

  validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "must have uppercase and lowercase alphabets.\nalphanumeric & should must contain a special character";
    } else {
      return null;
    }
  }

  validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  nameWithNum(String fullName) {
    String pattern = r'(?!^\d+$)([!@#$%_\^\&amp;\*\-\.\?]{5,49})*[a-zA-Z]+$';
    RegExp regExp = RegExp(pattern);
    RegExp regExps = RegExp(r'^[0-9. !@#$%^&*()-_=+]+$', caseSensitive: true);
    RegExp special = RegExp(r'^[!@#$%^&*()-_=+]+$');
    if (fullName.isEmpty) {
      return 'Please enter $validationError';
    } else {
      if (!regExp.hasMatch(fullName)) {
        return '$validationError is invalid';
      } else if (regExp.hasMatch(fullName)) {
        return null;
      } else if (regExps.hasMatch(fullName)) {
        return '$validationError is invalid';
      } else if (fullName.length <= 2) {
        return '$validationError is too short';
      }
      return null;
    }
    return null;
  }

  fullNameValidate(String fullName) {
    String pattern = r'^[a-z A-Z]+$';
    RegExp regExp = RegExp(pattern);
    if (fullName.isEmpty) {
      return 'Please enter $validationError';
    } else if (!regExp.hasMatch(fullName)) {
      return '$validationError is invalid';
    } else if (fullName.length <= 2) {
      return '$validationError is too short';
    }
    return null;
  }
}

class EditProfileTextFields extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  dynamic getController;
  EditProfileTextFields({
    Key? key,
    this.hintText,
    this.obscureText = false,
    this.suffix,
    required this.controller,
    this.borderColor = true,
    this.focus = false,
    this.maxLines = 1,
    this.prefixIcons,
    this.onlyRead = true,
    this.validationError,
    this.isConfirmPassword = false,
    this.isEmail = false,
    this.align = TextAlign.start,
    this.radiusCircle = 3,
    this.fillColor,
    this.textInputType = TextInputType.text,
    this.borderAssignColor,
    this.hintStyle,
    this.borderWidth,
    this.decoration,
    this.suffixContentPadding,
    this.onFieldSubmitted,
    this.onChanged,
    this.cursorColor,
    this.contentPad = true,
    this.textCustomStyle,
    this.getController,
    this.enable = true,
    this.borderCheck = true,
    this.onDone,
    this.containerHeight,
    this.radius,
    this.outlineBorderType = false,
    this.minLimit = 0,
    this.maxLength,
    this.isName = false,
    this.isNumber = false,this.minLines
  }) : super(key: key);

  String? hintText;
  Widget? suffix;
  int minLimit = 0;
  bool? obscureText = false;
  bool? focus = false;
  ValueChanged<String>? onFieldSubmitted;
  /*ValueChanged<String>?*/ Function(String)? onChanged;
  bool? borderColor = true;
  int? maxLines;
  Widget? prefixIcons;
  BoxDecoration? decoration;
  bool? onlyRead;
  TextInputType? textInputType;
  String? validationError;
  bool? isConfirmPassword = false;
  bool? isEmail = false;
  bool? enable = true;
  double? radiusCircle = 3;
  Color? fillColor;
  EdgeInsets? suffixContentPadding;
  Color? borderAssignColor;
  Color? cursorColor;
  TextStyle? hintStyle;
  TextStyle? textCustomStyle;
  TextAlign align = TextAlign.start;
  bool contentPad = true;
  VoidCallback? onDone;
  bool borderCheck = true;
  double? containerHeight;
  double? radius = 12;
  bool outlineBorderType = false;
  bool isName = false;
  bool isNumber = false;
  // ignore: prefer_typing_uninitialized_variables
  double? borderWidth;
  int? maxLength;
  int? minLines;
  @override
  Widget build(BuildContext context) {
    double heights = MediaQuery.of(context).size.height;
    return /*Container(
        height: containerHeight ?? 40,
        decoration: borderColor!
            ? decoration ??
                BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white)),
                )
            : decoration ??
                BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(width: 2, color: AppColors.textColor),
                  ),
                ),
        child: */
      TextFormField(
        textInputAction: TextInputAction.none,
        onChanged: onChanged ?? (x) {},
        onSaved: (c) {},
        onEditingComplete: onDone ??
                () {
              FocusScope.of(context).unfocus();
            },
        enabled: enable,
        textAlign: align,
        cursorColor: cursorColor ?? AppColors.textColor,
        autofocus: focus!,
        style: textCustomStyle ??
            montserratRegular(
              fontSize: 15,
              color: AppColors.textColor,
            ),
        controller: controller,
        keyboardType: textInputType,
        onFieldSubmitted: onFieldSubmitted,
        maxLength: maxLength,
        maxLengthEnforcement:
        maxLength != null ? MaxLengthEnforcement.enforced : null,
        decoration: outlineBorderType
            ? InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.textColor),
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.textColor),
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.textColor),
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.textColor),
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.textColor),
            borderRadius: BorderRadius.circular(radius ?? 0),

            /* borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.containersColor)*/
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: borderColor == true
                    ? AppColors.primaryColor
                    : AppColors.textColor),
            borderRadius: BorderRadius.circular(radius ?? 0),
          ),
          contentPadding: suffixContentPadding ??
              (suffix == null
                  ? EdgeInsets.only(
                  left: contentPad ? 08 : 08, top: 08, bottom: 08)
                  : EdgeInsets.only(
                left: 12,
                top: 12,
              )),
          /*border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.containersColor)),*/

          hintText: hintText,
          hintStyle: hintStyle ??
              montserratBold(
                  fontSize: 14.0,
                  latterSpacing: 0.0,
                  color: AppColors.frostedColor),
          helperStyle: montserratBold(),
          suffixIcon: suffix,
          prefixIcon: prefixIcons,
        )
            : InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          disabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          border: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          errorBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          contentPadding: suffixContentPadding ??
              (suffix == null
                  ? EdgeInsets.only(
                left: contentPad ? 0 : 08,
              )
                  : EdgeInsets.only(
                left: 12,
                top: 12,
              )),
          /*border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.containersColor)),*/

          hintText: hintText,
          hintStyle: hintStyle ??
              montserratRegular(
                  fontSize: 14.0,
                  latterSpacing: 0.0,
                  color: AppColors.textColor),
          helperStyle: montserratBold(),
          suffixIcon: suffix,
          prefixIcon: prefixIcons,
        ),
        readOnly: !onlyRead!,
        maxLines: maxLines,
        minLines: minLines,
        obscureText: obscureText!,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $validationError';
          } else if (value.length < minLimit) {
            return 'Please enter atleast $minLimit characters';
          } else if (isConfirmPassword == true) {
            if (getController.passwordController.text ==
                getController.retypePasswordController.text) {
              return null;
            } else {
              return "Password doesn't match";
            }
          } else if (isName == true) {
            return validateName(value);
          } else if (isNumber == true) {
            return validateNumber(value);
          } else {
            if (isEmail == true) {
              return validateEmail(value);
            } else {
              return null;
            }
          }
        },
      ) /*)*/;
  }

  validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  validateNumber(String value) {
    String pattern = "^[0-9]";

    RegExp rex = RegExp(pattern);
    if (!rex.hasMatch(value)) {
      return "Enter digits only";
    } else {
      return null;
    }
  }

  validateName(String value) {
    String pattern = "[a-zA-Z]";
    RegExp rex = RegExp(pattern);
    if (!rex.hasMatch(value)) {
      return "Enter a valid name";
    } else {
      return null;
    }
  }
}

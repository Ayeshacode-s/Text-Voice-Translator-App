import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:voicetext/constant/color.dart';
import 'package:voicetext/utilities/autosizetext.dart';




montserratRegular(
    {double? fontSize,
      color,
      fontWeight,
      double? latterSpacing,
      TextOverflow? textOverflow}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    color: color ?? AppColors.textColor,
    fontWeight: fontWeight ?? FontWeight.w100,
    fontFamily: 'montserrat-Medium',
    letterSpacing: latterSpacing ?? 0,
    overflow: textOverflow,
  );
}

montserratBold(
    {double? fontSize,
      color,
      fontWeight,
      double? latterSpacing,
      fontStyle,
      TextOverflow? textOverflow}) {
  return TextStyle(
      fontSize: fontSize ?? 18,
      fontStyle: fontStyle ?? FontStyle.normal,
      color: color ?? AppColors.textColor,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontFamily: 'montserrat-Bold',
      letterSpacing: latterSpacing ?? 0,
      overflow: textOverflow);
}

montserratSemiBold(
    {double? fontSize,
      color,
      fontWeight,
      double? latterSpacing,
      fontStyle,
      TextOverflow? textOverflow}) {
  return TextStyle(
      fontSize: fontSize ?? 18,
      fontStyle: fontStyle ?? FontStyle.normal,
      color: color ?? AppColors.textColor,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontFamily: 'montserrat-SemiBold',
      letterSpacing: latterSpacing ?? 0,
      overflow: textOverflow);
}

montserratLight(
    {double? fontSize,
      color,
      fontWeight,
      double? latterSpacing,
      bool shadow = false,
      TextOverflow? textOverflow}) {
  return TextStyle(
      fontSize: fontSize ?? 18,
      color: color ?? AppColors.textColor,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontFamily: 'montserrat-Light',
      letterSpacing: latterSpacing ?? 0,
      overflow: textOverflow);
}

autoSizeTextWidget(
    {String? text, double? fontSize, double? maxFontSize, otherStyling}) {
  return AutoSizeText(
    text!,
    minFontSize: fontSize ?? 25,
    maxFontSize: maxFontSize ?? 15,
    style: otherStyling ?? montserratRegular(),
  );
}

// String testImage =
//     'https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg';
String formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return "$minutesStr:$secondsStr";
  }

  return "$hoursStr:$minutesStr:$secondsStr";
}

String getNames(data) {
  return "${data.firstName} ${data.lastName}".capitalizeFirst!;
}

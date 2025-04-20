import 'package:flutter/material.dart';
import 'package:voicetext/constant/color.dart';

import 'TextStyle.dart';


class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.onTap,
    this.decoration,
    this.borderRadius,
    this.border,
    this.color,
    this.isLong = true,
    this.borderColor,
    this.text = "",
    this.style,
    this.child,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);
  final VoidCallback? onTap;
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? color;
  final Color? borderColor;
  final String? text;
  final bool isLong;
  final TextStyle? style;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            child: Container(
              padding: padding,
              margin: margin,
              decoration: decoration ??
                  BoxDecoration(
                      borderRadius: borderRadius ?? BorderRadius.circular(10),
                      // color: color ?? AppColors.primaryColor,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: color != null
                            ? <Color>[
                          color!,
                          color!,
                        ]
                            : <Color>[
                          AppColors.btnG1,
                          AppColors.btnG2,
                        ],
                      ),
                      border: border ??
                          Border.all(
                              color: borderColor ?? AppColors.textColor)),
              child: isLong == true
                  ? child ??
                  Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text!,
                          style: style ?? montserratLight(),
                        ),
                      ))
                  : child ??
                  Text(
                    text!,
                    style: style ?? montserratLight(),
                  ),
            )));
  }
}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voicetext/constant/color.dart';

class LoaderClass extends StatelessWidget {
  LoaderClass({this.colorOne, this.colorTwo});

  final Color? colorOne;
  final Color? colorTwo;

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: colorOne ?? AppColors.primaryColor,
      size: 50.0,
    );
  }
}

void showLoading() {
  BotToast.showCustomLoading(
    toastBuilder: (_) => Center(
      child: LoaderClass(
        colorOne: AppColors.primaryColor,
        colorTwo: AppColors.primaryColor.withOpacity(0.5),
      ),
    ),
    animationDuration: Duration(milliseconds: 300),
  );
}
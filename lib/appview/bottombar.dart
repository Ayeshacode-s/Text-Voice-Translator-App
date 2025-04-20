import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../constant/color.dart';
import '../controller/credentialcontroller.dart';
import '../utilities/TextStyle.dart';
import '../utilities/custombutton.dart';
import 'bottom/SpeechToTextTranslation.dart';
import 'bottom/TextToTextTranslation.dart';
import 'bottom/profile.dart';



class BottomBarWidget extends StatefulWidget {
  BottomBarWidget({this.getIndex = 0});

  int getIndex;

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  RxInt _selectedPagesIndex = 0.obs;
  bool? hasInternet;

  @override
  void initState() {
    print("object ${widget.getIndex}");
    _selectedPagesIndex.value = widget.getIndex;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _pageOptions = [
    TextToTextPage(),
    VoiceToTextPage(),
    Profile(),
    VoiceToTextPage(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
          height: h * 1,
          width: w * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xff0e0010),
                AppColors.btnG2,
              ],
            ),
          ),
          child: SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                extendBody: true,
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,

                body:  Obx(() => _pageOptions[_selectedPagesIndex.value])     ,
                bottomNavigationBar: bottomAppBar()
            ),
          )),
    );
  }
  Widget bottomAppBar() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(() {
      return Container(
        padding: EdgeInsets.only(top: 8),
        height: height * .08,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.frostedColor, width: 2),
            color: AppColors.Secondary_COLOR,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        // height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LikeButton(
              bubblesSize: 0,
              onTap: (a) {
                _selectedPagesIndex.value = 0;

                return Future.value(true);
              },
              circleColor: CircleColor(
                  start: Colors.transparent, end: Colors.transparent),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.transparent,
                dotSecondaryColor: Colors.transparent,
                dotLastColor: Colors.transparent,
                dotThirdColor: Colors.transparent,
              ),
              size: width * .15,
              likeBuilder: (bool isLiked) {
                return navigationIcon(
                    iconPath: Icons.translate,
                    indexOfItem: 0,
                    text: "Text",
                    selectedPagesIndex: _selectedPagesIndex.value);
              },
              isLiked: _selectedPagesIndex.value == 0 ? true : false,
              // likeCount: likeCount,
            ),
            LikeButton(
              bubblesSize: 0,
              onTap: (a) {
                _selectedPagesIndex.value = 1;
                return Future.value(true);
              },
              size: width * .15,
              circleColor: CircleColor(
                  start: Colors.transparent, end: Colors.transparent),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.transparent,
                dotSecondaryColor: Colors.transparent,
                dotLastColor: Colors.transparent,
                dotThirdColor: Colors.transparent,
              ),
              likeBuilder: (bool isLiked) {
                return navigationIcon(
                    text: "Voice",
                    iconPath: Icons.record_voice_over,
                    indexOfItem: 1,
                    selectedPagesIndex: _selectedPagesIndex.value);
              },
              isLiked: _selectedPagesIndex.value == 1 ? true : false,
              // likeCount: likeCount,
            ),
            LikeButton(
              bubblesSize: 0,
              onTap: (a) {
                _selectedPagesIndex.value = 2;
                return Future.value(true);
              },
              circleColor: CircleColor(
                  start: Colors.transparent, end: Colors.transparent),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.transparent,
                dotSecondaryColor: Colors.transparent,
                dotLastColor: Colors.transparent,
                dotThirdColor: Colors.transparent,
              ),
              size: width * .15,
              likeBuilder: (bool isLiked) {
                return navigationIcon(
                    text: "Profile",
                    iconPath: Icons.person,
                    indexOfItem: 2,
                    selectedPagesIndex: _selectedPagesIndex.value);
              },
              isLiked: _selectedPagesIndex.value == 2 ? true : false,
              // likeCount: likeCount,
            ),
            LikeButton(
              bubblesSize: 0,
              onTap: (a) {

                showDialog(
                    context: context,
                    builder: (BuildContext builderContext) {
                      return AlertDialog(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 5),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        backgroundColor: AppColors.btnG1,
                        title: Center(
                          child: Text(
                            "Logout",
                            style:
                            montserratBold(fontSize: 26, color: AppColors.textColor),
                          ),
                        ),
                        content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Are you sure you want to Logout?",
                                style: montserratRegular(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: CustomButton(
                                      onTap: (){
                                        Get.back();
                                      },
                                      color: AppColors.transparantColor,
                                      borderColor: AppColors.textColor,
                                      text: "Not Now",
                                      style: montserratLight(
                                          color: AppColors.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                    ),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child:  CustomButton(
                                      onTap: (){
                                        CredentialController().signOut();
                                      },
                                      color: AppColors.transparantColor,
                                      borderColor: AppColors.textColor,
                                      text: "Logout",
                                      style: montserratLight(
                                          color: AppColors.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      );
                    });
return Future.value(true);
              },
              size: width * .15,
              circleColor: CircleColor(
                  start: Colors.transparent, end: Colors.transparent),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.transparent,
                dotSecondaryColor: Colors.transparent,
                dotLastColor: Colors.transparent,
                dotThirdColor: Colors.transparent,
              ),
              likeBuilder: (bool isLiked) {
                return navigationIcon(
                    text: "Log Out",
                    iconPath: Icons.logout,
                    indexOfItem: 3,
                    selectedPagesIndex: _selectedPagesIndex.value);
              },
              isLiked: _selectedPagesIndex.value == 3 ? true : false,
              // likeCount: likeCount,
            )
          ],
        ),
      );
    });
  }

  Widget navigationIcon({selectedPagesIndex, indexOfItem, iconPath, text}) {
    return Container(
      // color: Colors.white54,
      child: Column(
        children: [
          Container(
            height: 32,
            child: Icon(iconPath,
              color: selectedPagesIndex == indexOfItem
                  ? AppColors.textColor
                  : Colors.white70,),
          ),
          Text("$text",
              style: montserratRegular(
                  color: selectedPagesIndex == indexOfItem
                      ? AppColors.textColor
                      : Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }


}



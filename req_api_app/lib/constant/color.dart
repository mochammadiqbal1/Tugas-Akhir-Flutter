import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//colors
const kpink = Color(0xFFff6374);
const kblue = Color(0xFF71b8ff);
const kpurple = Color(0xFF9ba0fc);
const korange = Color(0xFFffaa5b);
mixin AppColor {
  static Color primary = Color(0xFF2855AE);
  static Color primaryLight = Color(0xFF7292CF);
  static Color darkText = Color(0xFF777777);
}

//default value
const kDefaultPadding = 20.0;

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  topRight:
      Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

// profile screen
const String tProfile = "profile";
const String tEditProfile = "Edit Profile";
const String tLogoutDialogHeading = "Logout";
const String tProfileHeading = "iqbal";
const String tProfileSubHeading = "iqbal@gmail.com ";

// menu
// const String tMenu5 = tLogout;
const String tMenu1 = "Settings";
const String tMenu2 = "Information";
// const String tMenu3 = "Settings";
// const String tMenu4 = "Settings";

// update profile screen
const String tDelete = "Delete";
const String tJoined = "Joined";
// const String tJoinedAt = "profile";

// App default sizing
const tDefaultSize = 30.0;
const tButtonHeight = 30.0;
const tFormHeight = 30.0;

const kPrimaryColor = Color(0xff6849ef);
const kPrimaryLight = Color(0xff8a72f1);


import 'package:flutter/material.dart';

/// Primitive colors should only be used to store values so other variables can reference them.
sealed class AppColor {
  // Gray
  static const Color grayWhite = Color(0xffFFFFFF);
  static const Color gray50 = Color(0xffF1F2F4);
  static const Color gray100 = Color(0xffE9EAED);
  static const Color gray200 = Color(0xffDBDDE2);
  static const Color gray300 = Color(0xffC2C6CE);
  static const Color gray400 = Color(0xffA5A9B5);
  static const Color gray500 = Color(0xff8F93A2);
  static const Color gray600 = Color(0xff7E8092);
  static const Color gray700 = Color(0xff717384);
  static const Color gray800 = Color(0xff5F5F6E);
  static const Color gray900 = Color(0xff4E4F5A);
  static const Color gray950 = Color(0xff323339);
  static const Color grayBlack = Color(0xff232428);

  // Blue
  static const Color blue50 = Color(0xffEEF3FF);
  static const Color blue100 = Color(0xffDFE9FF);
  static const Color blue200 = Color(0xffCEDBFF);
  static const Color blue300 = Color(0xffA3B9FE);
  static const Color blue400 = Color(0xff7F92FA);
  static const Color blue500 = Color(0xff606EF4);
  static const Color blue600 = Color(0xff4345E8);
  static const Color blue700 = Color(0xff3735CD);
  static const Color blue800 = Color(0xff2E2FA5);
  static const Color blue900 = Color(0xff2C2E83);
  static const Color blue950 = Color(0xff1A1A4C);

  //Indigo
  static const Color indigo50 = Color(0xffF3F3FF);
  static const Color indigo100 = Color(0xffECEAFD);
  static const Color indigo200 = Color(0xffD3D1FC);
  static const Color indigo300 = Color(0xffBEB8FA);
  static const Color indigo400 = Color(0xff9C8FF6);
  static const Color indigo500 = Color(0xff7B62F0);
  static const Color indigo600 = Color(0xff6941E6);
  static const Color indigo700 = Color(0xff5A2FD2);
  static const Color indigo800 = Color(0xff4A27B0);
  static const Color indigo900 = Color(0xff3F2290);
  static const Color indigo950 = Color(0xff251362);

  //Purple
  static const Color purple50 = Color(0xffF8F6FC);
  static const Color purple100 = Color(0xffF1EEF9);
  static const Color purple200 = Color(0xffE5E0F4);
  static const Color purple300 = Color(0xffD2C7EB);
  static const Color purple400 = Color(0xffC5B3E3);
  static const Color purple500 = Color(0xffA482D0);
  static const Color purple600 = Color(0xff9366C1);
  static const Color purple700 = Color(0xff8254AD);
  static const Color purple800 = Color(0xff6C4691);
  static const Color purple900 = Color(0xff593B77);
  static const Color purple950 = Color(0xff392550);

  //Pink
  static const Color pink50 = Color(0xffFFF0F9);
  static const Color pink100 = Color(0xffFFE4F6);
  static const Color pink200 = Color(0xffFFC9EE);
  static const Color pink300 = Color(0xffFF9CDE);
  static const Color pink400 = Color(0xffFF5FC6);
  static const Color pink500 = Color(0xffFF31AD);
  static const Color pink600 = Color(0xffF50D8A);
  static const Color pink700 = Color(0xffD6006D);
  static const Color pink800 = Color(0xffB00459);
  static const Color pink900 = Color(0xff92094D);
  static const Color pink950 = Color(0xff5A002B);

  //Red
  static const Color red50 = Color(0xffFDF3F4);
  static const Color red100 = Color(0xffFBE8E8);
  static const Color red200 = Color(0xffF7D4D6);
  static const Color red300 = Color(0xffF1B0B5);
  static const Color red400 = Color(0xffE8858F);
  static const Color red500 = Color(0xffDB5869);
  static const Color red600 = Color(0xffC63851);
  static const Color red700 = Color(0xffA62A43);
  static const Color red800 = Color(0xff8B263E);
  static const Color red900 = Color(0xff782339);
  static const Color red950 = Color(0xff420F1B);

  //orange
  static const Color orange50 = Color(0xffFFF7ED);
  static const Color orange100 = Color(0xffFFEDD4);
  static const Color orange200 = Color(0xffFFD6A9);
  static const Color orange300 = Color(0xffFFB56B);
  static const Color orange400 = Color(0xffFE9039);
  static const Color orange500 = Color(0xffFC6F13);
  static const Color orange600 = Color(0xffED5509);
  static const Color orange700 = Color(0xffC53E09);
  static const Color orange800 = Color(0xff9C3110);
  static const Color orange900 = Color(0xff7E2B10);
  static const Color orange950 = Color(0xff441306);

  //yellow
  static const Color yellow50 = Color(0xffFFFBEB);
  static const Color yellow100 = Color(0xffFFF3C6);
  static const Color yellow200 = Color(0xffFFE688);
  static const Color yellow300 = Color(0xffFFDA69);
  static const Color yellow400 = Color(0xffFFBE20);
  static const Color yellow500 = Color(0xffF99C07);
  static const Color yellow600 = Color(0xffDD7402);
  static const Color yellow700 = Color(0xffB75106);
  static const Color yellow800 = Color(0xff943D0C);
  static const Color yellow900 = Color(0xff7A340D);
  static const Color yellow950 = Color(0xff461902);

  //green
  static const Color green50 = Color(0xffEDFCF3);
  static const Color green100 = Color(0xffD4F7E1);
  static const Color green200 = Color(0xffACEEC8);
  static const Color green300 = Color(0xff76DFA8);
  static const Color green400 = Color(0xff4ACC8D);
  static const Color green500 = Color(0xff1BAE6B);
  static const Color green600 = Color(0xff0E8D56);
  static const Color green700 = Color(0xff0C7048);
  static const Color green800 = Color(0xff0C593A);
  static const Color green900 = Color(0xff0B4932);
  static const Color green950 = Color(0xff05291D);

  //teal
  static const Color teal50 = Color(0xffE9EAED);
  static const Color teal100 = Color(0xffD1F6EA);
  static const Color teal200 = Color(0xffA3ECD5);
  static const Color teal300 = Color(0xff7CDEC3);
  static const Color teal400 = Color(0xff40C1A2);
  static const Color teal500 = Color(0xff26A689);
  static const Color teal600 = Color(0xff1C8570);
  static const Color teal700 = Color(0xff1A6B5A);
  static const Color teal800 = Color(0xff1A554B);
  static const Color teal900 = Color(0xff1A473F);
  static const Color teal950 = Color(0xff092A25);

  //cyan
  static const Color cyan50 = Color(0xffEFFBFF);
  static const Color cyan100 = Color(0xffCCF1FF);
  static const Color cyan200 = Color(0xffB8F0FF);
  static const Color cyan300 = Color(0xff79E5FF);
  static const Color cyan400 = Color(0xff32D9FE);
  static const Color cyan500 = Color(0xff07C5F0);
  static const Color cyan600 = Color(0xff00A0CE);
  static const Color cyan700 = Color(0xff0080A6);
  static const Color cyan800 = Color(0xff036B89);
  static const Color cyan900 = Color(0xff095871);
  static const Color cyan950 = Color(0xff06384B);
}
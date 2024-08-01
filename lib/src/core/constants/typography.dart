import 'package:flutter/material.dart';

sealed class AppTypoGraPhy {
  static const String interFontFamily = 'Inter';
  static const String mulish = 'Mulish';

  static const FontWeight _w400 =  FontWeight.w400;
  static const FontWeight _w500 =  FontWeight.w500;
  static const FontWeight _w600 =  FontWeight.w600;
  static const FontWeight _w700 =  FontWeight.w700;

  // ignore: constant_identifier_names
  static const double _2xs = 10;
  static const double _xs = 12;
  static const double _sm = 14;
  static const double _md = 16;
  static const double _lg = 18;
  static const double _xl = 20;
  static const double _dxs = 24;
  static const double _dsm = 30;
  static const double _dmd = 36;
  static const double _dlg = 48;
  static const double _dxl = 60;
  static const double _d2xl = 72;

  // Display style
  static const TextStyle display2xlRegular = TextStyle(
    fontSize: _d2xl,
    fontWeight: _w400,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle display2xlMedium = TextStyle(
      fontSize: _d2xl,
      fontWeight: _w500,
      height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle display2xlSemiBold = TextStyle(
    fontSize: _d2xl,
    fontWeight: _w600,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle display2xlBold = TextStyle(
    fontSize: _d2xl,
    fontWeight: _w700,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXlRegular = TextStyle(
    fontSize: _dxl,
    fontWeight: _w400,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXlMedium = TextStyle(
    fontSize: _dxl,
    fontWeight: _w500,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXlSemiBold = TextStyle(
    fontSize: _dxl,
    fontWeight: _w600,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXlBold = TextStyle(
    fontSize: _dxl,
    fontWeight: _w700,
    height: 1.2,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayLgRegular = TextStyle(
    fontSize: _dlg,
    fontWeight: _w400,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayLgMedium = TextStyle(
    fontSize: _dlg,
    fontWeight: _w500,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayLgSemiBold = TextStyle(
    fontSize: _dlg,
    fontWeight: _w600,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayLgBold = TextStyle(
    fontSize: _dlg,
    fontWeight: _w700,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayMdRegular = TextStyle(
    fontSize: _dmd,
    fontWeight: _w400,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayMdMedium = TextStyle(
    fontSize: _dmd,
    fontWeight: _w500,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayMdSemiBold = TextStyle(
    fontSize: _dmd,
    fontWeight: _w600,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayMdBold = TextStyle(
    fontSize: _dmd,
    fontWeight: _w700,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displaySmRegular = TextStyle(
    fontSize: _dsm,
    fontWeight: _w400,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displaySmMedium = TextStyle(
    fontSize: _dsm,
    fontWeight: _w500,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displaySmSemiBold = TextStyle(
    fontSize: _dsm,
    fontWeight: _w600,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displaySmBold = TextStyle(
    fontSize: _dsm,
    fontWeight: _w700,
    height: 1.25,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXsRegular = TextStyle(
    fontSize: _dxs,
    fontWeight: _w400,
    height: 1.3,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXsMedium = TextStyle(
    fontSize: _dxs,
    fontWeight: _w500,
    height: 1.3,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXsSemiBold = TextStyle(
    fontSize: _dxs,
    fontWeight: _w600,
    height: 1.3,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXsBold = TextStyle(
    fontSize: _dxs,
    fontWeight: _w700,
    height: 1.3,
    fontFamily: interFontFamily,
  );

  static const TextStyle displayXsSemiBoldUnderline = TextStyle(
    fontSize: _dxs,
    fontWeight: _w600,
    height: 1.3,
    decoration: TextDecoration.underline,
    fontFamily: interFontFamily,
  );

  // text
  static const TextStyle textXlRegular = TextStyle(
    fontSize: _xl,
    fontWeight: _w400,
    height: 1.4,
    fontFamily: mulish,
  );

  static const TextStyle textXlMedium = TextStyle(
    fontSize: _xl,
    fontWeight: _w500,
    height: 1.4,
    fontFamily: mulish,
  );

  static const TextStyle textXlSemiBold = TextStyle(
    fontSize: _xl,
    fontWeight: _w600,
    height: 1.4,
    fontFamily: mulish,
  );

  static const TextStyle textXlBold = TextStyle(
    fontSize: _xl,
    fontWeight: _w700,
    height: 1.4,
    fontFamily: mulish,
  );

  static const TextStyle textLgRegular = TextStyle(
    fontSize: _lg,
    fontWeight: _w400,
    height: 1.45,
    fontFamily: mulish,
  );

  static const TextStyle textLgMedium = TextStyle(
    fontSize: _lg,
    fontWeight: _w500,
    height: 1.45,
    fontFamily: mulish,
  );

  static const TextStyle textLgSemiBold = TextStyle(
    fontSize: _lg,
    fontWeight: _w600,
    height: 1.45,
    fontFamily: mulish,
  );

  static const TextStyle textLgBold = TextStyle(
    fontSize: _lg,
    fontWeight: _w700,
    height: 1.45,
    fontFamily: mulish,
  );

  static const TextStyle textLgSemiBoldUnderline = TextStyle(
    fontSize: _lg,
    fontWeight: _w600,
    height: 1.45,
    decoration: TextDecoration.underline,
    fontFamily: mulish,
  );

  static const TextStyle textMdRegular = TextStyle(
    fontSize: _md,
    fontWeight: _w400,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textMdMedium = TextStyle(
    fontSize: _md,
    fontWeight: _w500,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textMdSemiBold = TextStyle(
    fontSize: _md,
    fontWeight: _w600,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textMdBold = TextStyle(
    fontSize: _md,
    fontWeight: _w700,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textSmRegular = TextStyle(
    fontSize: _sm,
    fontWeight: _w400,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textSmMedium = TextStyle(
    fontSize: _sm,
    fontWeight: _w500,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textSmSemiBold = TextStyle(
    fontSize: _sm,
    fontWeight: _w600,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textSmBold = TextStyle(
    fontSize: _sm,
    fontWeight: _w700,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textXsRegular = TextStyle(
    fontSize: _xs,
    fontWeight: _w400,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textXsMedium = TextStyle(
    fontSize: _xs,
    fontWeight: _w500,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textXsSemiBold = TextStyle(
    fontSize: _xs,
    fontWeight: _w600,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle textXsBold = TextStyle(
    fontSize: _xs,
    fontWeight: _w700,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle text2xsRegular = TextStyle(
    fontSize: _2xs,
    fontWeight: _w400,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle text2xsMedium = TextStyle(
    fontSize: _2xs,
    fontWeight: _w500,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle text2xsSemiBold = TextStyle(
    fontSize: _2xs,
    fontWeight: _w600,
    height: 1.5,
    fontFamily: mulish,
  );

  static const TextStyle text2xsBold = TextStyle(
    fontSize: _2xs,
    fontWeight: _w700,
    height: 1.5,
    fontFamily: mulish,
  );


  /// Special text style
  static const TextStyle keyboardStyle = TextStyle(
    fontSize: 26,
    fontFamily: interFontFamily,
    fontWeight: FontWeight.w400,
  );
}

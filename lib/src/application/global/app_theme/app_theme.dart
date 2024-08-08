import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/app_color.dart';

/// [AppTheme] defines pyxis mobile application's design system.
interface class AppTheme {
  // Text color
  late Color textPrimary;
  late Color textPrimaryOnBrand;
  late Color textSecondary;
  late Color textSecondaryHover;
  late Color textSecondaryOnBrand;
  late Color textTertiary;
  late Color textTertiaryHover;
  late Color textTertiaryOnBrand;
  late Color textQuaternary;
  late Color textQuaternaryOnBrand;
  late Color textWhite;
  late Color textDisabled;
  late Color textPlaceholder;
  late Color textPlaceholderAlt;
  late Color textBrandPrimary;
  late Color textBrandSecondary;
  late Color textBrandTertiary;
  late Color textBrandTertiaryAlt;
  late Color textInfoPrimary;
  late Color textSuccessPrimary;
  late Color textWarningPrimary;
  late Color textErrorPrimary;
  late Color textUnknownPrimary;

  // Border color
  late Color borderPrimary;
  late Color borderSecondary;
  late Color borderTertiary;
  late Color borderDisabled;
  late Color borderDisabledSubtle;
  late Color borderBrand;
  late Color borderBrandSolid;
  late Color borderBrandSolidAlt;
  late Color borderInfo;
  late Color borderInfoSolid;
  late Color borderSuccess;
  late Color borderSuccessSolid;
  late Color borderWarning;
  late Color borderWarningSolid;
  late Color borderError;
  late Color borderErrorSolid;
  late Color borderErrorUnknown;
  late Color borderErrorUnknownSolid;

  // Foreground color
  late Color fgPrimary;
  late Color fgSecondary;
  late Color fgSecondaryHover;
  late Color fgTertiary;
  late Color fgTertiaryHover;
  late Color fgQuaternary;
  late Color fgQuaternaryHover;
  late Color fgQuinary;
  late Color fgQuinaryHover;
  late Color fgSenary;
  late Color fgWhite;
  late Color fgDisabled;
  late Color fgDisabledSubtle;
  late Color fgBrandPrimary;
  late Color fgBrandPrimaryAlt;
  late Color fgBrandSecondary;
  late Color fgInfoPrimary;
  late Color fgInfoSecondary;
  late Color fgSuccessPrimary;
  late Color fgSuccessSecondary;
  late Color fgWarningPrimary;
  late Color fgWarningSecondary;
  late Color fgErrorPrimary;
  late Color fgErrorSecondary;
  late Color fgUnknownPrimary;
  late Color fgUnknownSecondary;

  // Background color
  late Color bgPrimary;
  late Color bgPrimaryHover;
  late Color bgPrimaryAlt;
  late Color bgPrimarySolid;
  late Color bgSecondary;
  late Color bgSecondaryHover;
  late Color bgSecondaryAlt;
  late Color bgSecondarySubtle;
  late Color bgSecondarySolid;
  late Color bgTertiary;
  late Color bgQuaternary;
  late Color bgActive;
  late Color bgDisabled;
  late Color bgDisabledSubtle;
  late Color bgOverlay;
  late Color bgBrandPrimary;
  late Color bgBrandPrimaryAlt;
  late Color bgBrandSecondary;
  late Color bgBrandSolid;
  late Color bgBrandSolidHover;
  late Color bgBrandSection;
  late Color bgBrandSectionSubtle;
  late Color bgInfoPrimary;
  late Color bgInfoSecondary;
  late Color bgInfoSolid;
  late Color bgSuccessPrimary;
  late Color bgSuccessSecondary;
  late Color bgSuccessSolid;
  late Color bgWarningPrimary;
  late Color bgWarningSecondary;
  late Color bgWarningSolid;
  late Color bgErrorPrimary;
  late Color bgErrorSecondary;
  late Color bgErrorSolid;
  late Color bgUnknownPrimary;
  late Color bgUnknownSecondary;
  late Color bgUnknownSolid;

  // Alpha color
  late Color alphaWhite4;
  late Color alphaWhite8;
  late Color alphaWhite10;
  late Color alphaWhite20;
  late Color alphaWhite30;
  late Color alphaWhite40;
  late Color alphaWhite50;
  late Color alphaWhite60;
  late Color alphaWhite70;
  late Color alphaWhite80;
  late Color alphaWhite90;
  late Color alphaBlack4;
  late Color alphaBlack8;
  late Color alphaBlack10;
  late Color alphaBlack20;
  late Color alphaBlack30;
  late Color alphaBlack40;
  late Color alphaBlack50;
  late Color alphaBlack60;
  late Color alphaBlack70;
  late Color alphaBlack80;
  late Color alphaBlack90;

  // Utility color
  late Color utilityGray50;

  late Color utilityGray100;

  late Color utilityGray200;

  late Color utilityGray300;

  late Color utilityGray400;

  late Color utilityGray500;

  late Color utilityGray600;

  late Color utilityGray700;

  late Color utilityBrand50;

  late Color utilityBrand50Alt;

  late Color utilityBrand100;

  late Color utilityBrandAlt100;

  late Color utilityBrand200;

  late Color utilityBrandAlt200;

  late Color utilityBrand300;

  late Color utilityBrandAlt300;

  late Color utilityBrand400;

  late Color utilityBrandAlt400;

  late Color utilityBrand500;

  late Color utilityBrandAlt500;

  late Color utilityBrand600;

  late Color utilityBrandAlt600;

  late Color utilityBrand700;

  late Color utilityBrandAlt700;

  late Color utilitySuccess50;

  late Color utilitySuccess100;

  late Color utilitySuccess200;

  late Color utilitySuccess300;

  late Color utilitySuccess400;

  late Color utilitySuccess500;

  late Color utilitySuccess600;

  late Color utilitySuccess700;

  late Color utilityWarning50;

  late Color utilityWarning100;

  late Color utilityWarning200;

  late Color utilityWarning300;

  late Color utilityWarning400;

  late Color utilityWarning500;

  late Color utilityWarning600;

  late Color utilityWarning700;

  late Color utilityError50;

  late Color utilityError100;

  late Color utilityError200;

  late Color utilityError300;

  late Color utilityError400;

  late Color utilityError500;

  late Color utilityError600;

  late Color utilityError700;

  late Color utilityBlue50;

  late Color utilityBlue100;

  late Color utilityBlue200;

  late Color utilityBlue300;

  late Color utilityBlue400;

  late Color utilityBlue500;

  late Color utilityBlue600;

  late Color utilityBlue700;

  late Color utilityIndigo50;

  late Color utilityIndigo100;

  late Color utilityIndigo200;

  late Color utilityIndigo300;

  late Color utilityIndigo400;

  late Color utilityIndigo500;

  late Color utilityIndigo600;

  late Color utilityIndigo700;

  late Color utilityPurple50;

  late Color utilityPurple100;

  late Color utilityPurple200;

  late Color utilityPurple300;

  late Color utilityPurple400;

  late Color utilityPurple500;

  late Color utilityPurple600;

  late Color utilityPurple700;

  late Color utilityPink50;

  late Color utilityPink100;

  late Color utilityPink200;

  late Color utilityPink300;

  late Color utilityPink400;

  late Color utilityPink500;

  late Color utilityPink600;

  late Color utilityPink700;

  late Color utilityRed50;

  late Color utilityRed100;

  late Color utilityRed200;

  late Color utilityRed300;

  late Color utilityRed400;

  late Color utilityRed500;

  late Color utilityRed600;

  late Color utilityRed700;

  late Color utilityOrange50;

  late Color utilityOrange100;

  late Color utilityOrange200;

  late Color utilityOrange300;

  late Color utilityOrange400;

  late Color utilityOrange500;

  late Color utilityOrange600;

  late Color utilityOrange700;

  late Color utilityYellow50;

  late Color utilityYellow100;

  late Color utilityYellow200;

  late Color utilityYellow300;

  late Color utilityYellow400;

  late Color utilityYellow500;

  late Color utilityYellow600;

  late Color utilityYellow700;

  late Color utilityGreen50;

  late Color utilityGreen100;

  late Color utilityGreen200;

  late Color utilityGreen300;

  late Color utilityGreen400;

  late Color utilityGreen500;

  late Color utilityGreen600;

  late Color utilityGreen700;

  late Color utilityTeal50;

  late Color utilityTeal100;

  late Color utilityTeal200;

  late Color utilityTeal300;

  late Color utilityTeal400;

  late Color utilityTeal500;

  late Color utilityTeal600;

  late Color utilityTeal700;

  late Color utilityCyan50;

  late Color utilityCyan100;

  late Color utilityCyan200;

  late Color utilityCyan300;

  late Color utilityCyan400;

  late Color utilityCyan500;

  late Color utilityCyan600;

  late Color utilityCyan700;
}

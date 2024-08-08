// import 'package:flutter/material.dart';
// import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
// import 'package:a_wallet/src/core/constants/size_constant.dart';
// import 'package:a_wallet/src/core/constants/typography.dart';
//
// class PhraseWidget extends StatelessWidget {
//   final String word;
//   final int position;
//   final AppTheme appTheme;
//
//   const PhraseWidget({
//     required this.position,
//     required this.word,
//     required this.appTheme,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           '${position.toString()}.',
//           style: AppTypoGraPhy.textSmSemiBold.copyWith(
//             color: appTheme.textTertiary,
//           ),
//         ),
//         const SizedBox(
//           width: BoxSize.boxSize01,
//         ),
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(
//               Spacing.spacing03,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 BorderRadiusSize.borderRadius03,
//               ),
//               color: appTheme.bgPrimary,
//             ),
//             child: Text(
//               word,
//               style: AppTypoGraPhy.textSmRegular.copyWith(
//                 color: appTheme.textPlaceholder,
//               ),
//               textAlign: TextAlign.start,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

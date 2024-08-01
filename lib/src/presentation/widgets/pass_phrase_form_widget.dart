// import 'package:flutter/material.dart';
// import 'package:pyxis_mobile/src/application/global/app_theme/app_theme.dart';
// import 'package:pyxis_mobile/src/core/constants/size_constant.dart';
// import 'package:pyxis_mobile/src/presentation/widgets/phrase_widget.dart';
//
// class PassPhraseWidget extends StatelessWidget {
//   final String phrase;
//   final void Function(String) onCopy;
//   final AppTheme appTheme;
//   final int wordCount;
//   final int crossCount;
//
//   const PassPhraseWidget({
//     required this.phrase,
//     required this.onCopy,
//     required this.appTheme,
//     this.wordCount = 12,
//     this.crossCount = 3,
//     super.key,
//   }) : assert(wordCount % crossCount == 0);
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> words = phrase.split(' ');
//     return Column(
//       children: List.generate(
//         wordCount ~/ crossCount,
//             (cIndex) {
//           return Row(
//             children: List.generate(
//               crossCount,
//                   (rIndex) {
//                 final index = cIndex * crossCount + rIndex;
//                 final String word = words[index];
//                 return Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: Spacing.spacing02,
//                       vertical: Spacing.spacing03,
//                     ),
//                     child: PhraseWidget(
//                       position: index + 1,
//                       word: word,
//                       appTheme: appTheme,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

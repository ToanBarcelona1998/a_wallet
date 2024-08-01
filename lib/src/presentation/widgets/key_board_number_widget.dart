import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme_builder.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

typedef KeyboardTapCallback = void Function(String text);

class KeyboardNumberWidget extends StatefulWidget {
  final Widget? rightIcon;
  final VoidCallback? rightButtonFn;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;

  const KeyboardNumberWidget({
    super.key,
    required this.onKeyboardTap,
    this.rightButtonFn,
    this.rightIcon,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  State<StatefulWidget> createState() {
    return _KeyboardNumberWidgetState();
  }
}

class _KeyboardNumberWidgetState extends State<KeyboardNumberWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing08,
        vertical: Spacing.spacing07,
      ),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: Spacing.spacing10,
                height: Spacing.spacing10,
              ),
              _calcButton('0'),
              InkWell(
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.borderRadius06,
                ),
                onTap: widget.rightButtonFn,
                child: Container(
                  alignment: Alignment.center,
                  width: BoxSize.boxSize10,
                  height: BoxSize.boxSize10,
                  child: widget.rightIcon ??
                      SvgPicture.asset(
                        AssetIconPath.icCommonClear,
                      ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        BorderRadiusSize.borderRadius06,
      ),
      onTap: () {
        widget.onKeyboardTap(value);
      },
      child: Container(
        alignment: Alignment.center,
        width: BoxSize.boxSize10,
        height: BoxSize.boxSize11,
        child: AppThemeBuilder(
          builder: (theme) {
            return Text(
              value,
              style: AppTypoGraPhy.keyboardStyle.copyWith(
                color: theme.textPrimary,
              ),
            );
          },
        ),
      ),
    );
  }
}

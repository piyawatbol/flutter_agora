import 'package:flutter/material.dart';
import 'package:flutter_agora_app/widgets/colors/color.dart';

import '../text/auto_text.dart';

class ButtonCustom extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? fontSize;
  final VoidCallback? onTap;
  final Color? colorButton;
  final Color? colorText;
  final double? borderRadius;
  final BorderSide? borderSide;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  const ButtonCustom(this.text,
      {this.colorButton = primaryColor,
      this.colorText = Colors.white,
      this.foregroundColor = Colors.white,
      this.width,
      this.height,
      required this.onTap,
      this.borderRadius = 0,
      this.fontSize = 14,
      this.borderSide,
      this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor,
            side: borderSide,
            backgroundColor: colorButton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
          onPressed: onTap,
          child: AutoText(
            '$text',
            fontSize: fontSize,
            color: colorText,
          ),
        ),
      ),
    );
  }
}

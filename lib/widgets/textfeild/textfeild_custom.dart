import 'package:flutter/material.dart';
import 'package:flutter_agora_app/widgets/text/auto_text.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCustom extends StatelessWidget {
  final String title;
  final EdgeInsets? padding;
  final TextEditingController controller;
  final BorderRadius? borderRadius;
  final bool? hidePass;
  final Widget? suffixIcon;
  const TextFieldCustom(
      {required this.controller,
      this.title = "",
      this.padding = EdgeInsets.zero,
      this.borderRadius = BorderRadius.zero,
      this.hidePass = false,
      this.suffixIcon = null});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoText(title, fontSize: 14),
          SizedBox(height: 5),
          TextField(
            obscureText: hidePass!,
            controller: controller,
            style: GoogleFonts.kanit(),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.only(left: 14),
              border: OutlineInputBorder(
                borderRadius: borderRadius!,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius!,
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:contact_management/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KTextField extends StatelessWidget {
  final String? hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool isTitleNeed;
  final String? titleText;
  final TextStyle? titleTextStyle;
  const KTextField({
    super.key,
    this.hintText,
    this.controller,
    this.onTap,
    this.onChanged,
    this.isTitleNeed = false,
    this.titleText,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitleNeed
            ? Text(
                titleText ?? "",
                style: titleTextStyle ??
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            : Container(),
        TextField(
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            isDense: true,
            hintText: hintText ?? "",
            hintStyle: GoogleFonts.poppins(color: kGrey, fontSize: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: kGrey.withOpacity(0.2),
                width: 1.7,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: kGrey.withOpacity(0.2),
                width: 1.7,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: kGrey.withOpacity(0.2),
                width: 1.7,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

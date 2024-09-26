import 'package:contact_management/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KPrimaryButton extends StatelessWidget {
  final String buttonText;
  final IconData? icon;
  final bool? isNeedIcon;
  final VoidCallback onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  const KPrimaryButton({
    super.key,
    required this.buttonText,
     this.icon,
    this.isNeedIcon=false,
    required this.onTap,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kPrimaryColor,
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           isNeedIcon==true?Icon(icon):Container(),
            Text(
             buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize:fontSize?? 16,
                fontWeight: fontWeight??FontWeight.w600
              ),
            ),
          ],
        ),
      ),
    );
  }
}

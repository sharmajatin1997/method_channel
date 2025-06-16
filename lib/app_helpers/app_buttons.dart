
import 'package:esferasoft_task/app_helpers/app_strings.dart';
import 'package:esferasoft_task/app_helpers/app_text.dart';
import 'package:esferasoft_task/colors/app_colors.dart';
import 'package:flutter/material.dart';


class AppButtons extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final double? borderRadius;
  final Color? color;
  final VoidCallback? onTap;
  final String text;
  final double? textSize;
  final double? borderWidth;
  final Color? textColor;
  final Color? borderColor;
  final IconData? icon;
  final FontWeight? fontWeight;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final String? fontFamily;
  final bool isGradient;

  const AppButtons(
      {super.key,
      this.height,
      this.width,
      this.icon,
      this.margin,
      this.padding,
      this.borderRadius,
      this.border,
      this.color,
      this.onTap,
      this.alignment = Alignment.center,
      required this.text,
      this.textSize,
      this.textColor,
      this.fontWeight,
      this.boxShadow,
      this.child,
      this.gradient,
      this.borderWidth,
      this.borderColor,
      this.fontFamily,this.isGradient = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        alignment: alignment??Alignment.center,
        decoration: BoxDecoration(
            border: border ?? Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 0.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            color: color ?? AppColors.appColor,
            gradient: isGradient==true?gradient??const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomLeft,
              colors: [Color(0xff00D7E3), Color(0xffFF00FF)],
                ):null,
            boxShadow: boxShadow),
        child: child ??
            AppText(
              text: text,
              textSize: textSize ?? 17.0,
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontFamily: fontFamily ?? AppStrings.poppins,
            ),
      ),
    );
  }
}

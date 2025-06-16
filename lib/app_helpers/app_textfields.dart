import 'package:esferasoft_task/app_helpers/app_strings.dart';
import 'package:esferasoft_task/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppTextFields extends StatelessWidget {
  const AppTextFields({
    super.key,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.margin,
    this.padding,
    this.contentPadding,
    this.hintTextStyle,
    this.maxLines,
    this.textColor,
    this.textSize,
    this.controller,
    this.onChanged,
    this.readOnly,
    this.textFieldColor,
    this.obscureText,
    this.enabled,
    this.focusNode,
    this.borderColor,
    this.borderWidth,
    this.textLimit,
    this.textInputType,
    this.fontWeight,
    this.alignment,
    this.child,
    this.prefixIconConstraints,
    this.hintTextSize,
    this.style,
    this.onTap,
    this.enableFocus,
    this.minLines,
    this.hintTextColor,
    this.isExpanded,
    this.validator,
    this.onEditingComplete,
    this.onTapOutside,
    this.autofocus,
    this.scrollPhysics,
    this.obscuringCharacter,
    this.textInputAction,
    this.textAlign,
  });

  final Color? textColor;
  final Color? hintTextColor;
  final double? textSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final bool? readOnly;
  final bool? enabled;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final double? hintTextSize;
  final int? maxLines;
  final Color? textFieldColor;
  final Color? borderColor;
  final double? borderWidth;
  final int? textLimit;
  final int? minLines;
  final FontWeight? fontWeight;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final Widget? child;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? enableFocus;
  final bool? isExpanded;
  final bool? autofocus;
  final AlignmentGeometry? alignment;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle? style;
  final GestureTapCallback? onTap;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final Function(PointerDownEvent)? onTapOutside;
  final ScrollPhysics? scrollPhysics;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      minLines: minLines,
      focusNode: focusNode,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      inputFormatters: [LengthLimitingTextInputFormatter(textLimit)],
      obscuringCharacter: obscuringCharacter ?? "•",
      scrollPhysics: scrollPhysics,
      textInputAction: textInputAction ?? TextInputAction.done,
      onTap: onTap,
      onTapOutside: onTapOutside,
      obscureText: obscureText ?? false,
      enabled: enabled,
      cursorErrorColor: AppColors.red,
      textAlign: textAlign ?? TextAlign.start,
      style: style ??
          TextStyle(
              color: textColor,
              fontSize: textSize ?? 14.0,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontFamily: AppStrings.poppins),
      maxLines: maxLines ?? 1,
      keyboardType: textInputType,
      decoration: InputDecoration(
        errorMaxLines: 5,
        fillColor: textFieldColor ?? AppColors.white,
        filled: true,
        prefixIconConstraints: prefixIconConstraints,
        errorStyle: const TextStyle(
            color: AppColors.red, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: AppStrings.poppins),
        hintText: hintText,
        suffixIconColor: Colors.black.withValues(alpha: 0.6),
        // isDense: true,
        hintStyle: hintTextStyle ??
            TextStyle(
                fontFamily: AppStrings.poppins,
                fontWeight: FontWeight.w400,
                fontSize: hintTextSize ?? 14.0,
                color: hintTextColor ?? AppColors.hintColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColors.textFieldBorder, width: borderWidth ?? 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.transparent, width: borderWidth ?? 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red, width: borderWidth ?? 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColors.red, width: borderWidth ?? 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        focusedBorder: enableFocus ?? true
            ? OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.appColor, width: borderWidth ?? 1),
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.textFieldBorder, width: borderWidth ?? 1),
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
              ),
        prefixIcon: prefixIcon,
        // prefixIconConstraints: const BoxConstraints(maxWidth: 50),
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final String fontFamily;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;

  const CommonText(
    this.text, {
    super.key,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    required this.fontFamily,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color:themeColor, // 👈 falls back to theme
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}

/// A reusable TextField with common properties (label, hint, validation, etc.)
class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;

  // 🔒 Mandatory styling — must be passed every time
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final String fontFamily;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final FocusNode? focusNode;
  final bool? focus;
  final TextAlign? textAlign;

  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;

  const CommonTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    required this.fontFamily,
    this.hintStyle,
    this.labelStyle,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.contentPadding,
    this.border,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
    this.decoration,
    this.focus=true,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = color ?? colorScheme.onSurface;
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: focus??false,
      textAlign: textAlign??TextAlign.center,
      focusNode: focusNode,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: textColor,
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      decoration:
          decoration ??
          InputDecoration(
            labelText: label,
            hintText: hint,
            hintStyle:
                hintStyle ??
                TextStyle(
                  fontFamily: fontFamily,
                  color: Colors.grey,
                  fontSize: fontSize,
                ),
            labelStyle: labelStyle,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
    );
  }
}

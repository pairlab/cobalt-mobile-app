import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.gradient,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.backgroundColor,
    this.shadowColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.shape,
    this.padding,
  }) : super(key: key);

  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final OutlinedBorder? shape;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape,
          padding: padding,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          shadowColor: shadowColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}

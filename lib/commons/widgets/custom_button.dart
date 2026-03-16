import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Color? color;
  final bool isOutlined;
  final TextStyle textStyle;
  final String text;
  const CustomButton({
    super.key,
    this.color,
    required this.isOutlined,
    required this.textStyle,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: isOutlined
                ? Colors.white.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}

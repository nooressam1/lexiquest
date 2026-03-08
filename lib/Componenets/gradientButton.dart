import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final double buttonHeight;
  final VoidCallback actionFunction;

  // NEW (customizable gradient)
  final List<Color>? gradientColors;

  // NEW (border-only mode)
  final bool borderOnly;
  final Color borderColor;

  const GradientButton({
    super.key,
    required this.actionFunction,
    required this.buttonText,
    this.buttonHeight = 50,

    this.gradientColors, // optional gradient
    this.borderOnly = false, // if true → no fill
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: buttonHeight,
      child: TextButton(
        onPressed: actionFunction,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: borderOnly || gradientColors == null
                ? null
                : LinearGradient(
                    colors: gradientColors!,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

            color: borderOnly ? Colors.transparent : null,

            borderRadius: BorderRadius.circular(8),

            border: borderOnly
                ? Border.all(color: borderColor, width: 2)
                : null,
          ),
          child: Container(
            height: buttonHeight,
            alignment: Alignment.center,
            child: Text(
              buttonText,
              style: TextStyle(
                color: borderOnly ? borderColor : Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'Golos',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

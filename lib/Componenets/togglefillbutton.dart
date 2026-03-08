import 'package:flutter/material.dart';

class ToggleFillButton extends StatefulWidget {
  final String text;
  final Color color;
  final double borderRadius;
  final Function(bool isActive)? onChanged;

  const ToggleFillButton({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.borderRadius = 5,
    this.onChanged,
  });

  @override
  State<ToggleFillButton> createState() => _ToggleFillButtonState();
}

class _ToggleFillButtonState extends State<ToggleFillButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isActive = !isActive);

        if (widget.onChanged != null) {
          widget.onChanged!(isActive);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45),
        decoration: BoxDecoration(
          color: isActive ? widget.color : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: widget.color, width: 1),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: isActive ? Colors.white : widget.color,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

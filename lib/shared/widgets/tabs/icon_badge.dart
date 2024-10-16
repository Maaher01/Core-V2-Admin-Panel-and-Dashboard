import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.child,
    required this.value,
    required this.color,
    required this.textColor,
  });

  final Widget child;
  final int value;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (value > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              constraints: const BoxConstraints(minWidth: 17, minHeight: 17),
              child: Center(
                child: Text(
                  '$value',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 9.5,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

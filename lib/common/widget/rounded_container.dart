import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final double radiusValue;
  final BorderRadiusGeometry? radius;

  const RoundedContainer({
    required this.child,
    this.margin,
    this.padding,
    this.color,
    this.radiusValue = 10,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius ?? BorderRadius.circular(radiusValue),
      ),
      child: child,
    );
  }
}

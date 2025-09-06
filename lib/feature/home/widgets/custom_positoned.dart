import 'package:flutter/cupertino.dart';

class CustomPosition extends StatelessWidget {
  final double? right;
  final double? left;
  final double? top;
  final double? bottom;
  final VoidCallback? onPress;
  final Widget child;

  const CustomPosition({
    super.key,
    this.right,
    this.left,
    this.top,
    this.bottom,
    this.onPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: onPress,
        child:child,
      ),
    );
  }
}

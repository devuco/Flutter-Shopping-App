import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Loader extends StatelessWidget {
  bool isLoading;
  Color color;
  Color backgroundColor;
  double? size;
  Loader(
      {super.key,
      required this.isLoading,
      this.color = Colors.black,
      this.backgroundColor = Colors.white,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Container(
        color: backgroundColor,
        height: size,
        width: size,
        child: Center(
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: size == null ? 4.0 : 2.0,
          ),
        ),
      ),
    );
  }
}

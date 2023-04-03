import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/utils/Utils.dart';

class Arc extends StatelessWidget {
  final String? color;
  final Widget child;
  const Arc({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox(
            height: Get.height / 3,
            width: Get.width,
            child: CustomPaint(
              painter: CurvePainter(Utils.getColor(color)),
            ),
          ),
          Center(
            child: child,
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  Color color;
  CurvePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    paint.color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

import 'package:flutter/cupertino.dart';

class NavBarClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    final w = size.width;
    final h = size.height;
    path.lineTo(0, h * 0.5);
    path.quadraticBezierTo(w * 0.1, h * 0.3, w * 0.1, h * 0.5);
    path.quadraticBezierTo(w * 0.1, h * 0.9, w * 0.2, h * 0.9);
    path.quadraticBezierTo(w * 0.28, h * 0.9, w * 0.4, h * 0.55);
    path.quadraticBezierTo(w * 0.5, h * 0.25, w * 0.6, h * 0.55);
    path.quadraticBezierTo(w * 0.72, h * 0.9, w * 0.8, h * 0.9);
    path.quadraticBezierTo(w * 0.9, h * 0.9, w * 0.9, h * 0.5);
    path.quadraticBezierTo(w * 0.9, h * 0.3, w, h * 0.5);
    path.lineTo(w, h);
    path.lineTo(0, h);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

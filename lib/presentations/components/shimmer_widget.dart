import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder =const RoundedRectangleBorder(),
  }) : super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Base Color is the color in the bottom, but highlightColor is the color in the top (Animation color)
    return Shimmer.fromColors(
      baseColor: const Color(0xffE3E3E3),
      highlightColor: const Color(0xffFAFAFA),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: shapeBorder,
        ),
      ),
    );
  }
}

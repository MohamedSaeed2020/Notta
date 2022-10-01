import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, required this.height, this.width = double.infinity})
      : super(key: key);

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffE3E3E3),
      highlightColor: const Color(0xffFAFAFA),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.black,  //Important
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 100}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffE3E3E3),
      highlightColor: const Color(0xffFAFAFA),
      child: Container(
        height: size,
        width: size,
        decoration:const BoxDecoration(
          color: Colors.black,//Important
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

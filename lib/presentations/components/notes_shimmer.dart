import 'package:flutter/material.dart';
import 'package:notes/presentations/components/shimmer_widget.dart';

class NotesShimmer extends StatelessWidget {
  const NotesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:const ShimmerWidget.circular(width:64,height:64),
      title: Align(
        alignment: Alignment.centerLeft,
        child: ShimmerWidget.rectangular(
            width: MediaQuery.of(context).size.width * 0.25,
            height:16
        ),
      ),
      subtitle: const ShimmerWidget.rectangular(height:14),
    );
  }
}

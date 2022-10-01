import 'package:flutter/material.dart';
import 'package:notes/presentations/components/skeleton.dart';

class NoteItemSkeleton extends StatelessWidget {
  const NoteItemSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleSkeleton(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80,height: 16,),
              const SizedBox(height: 8),
              const Skeleton(height: 16,),
              const SizedBox(height: 8),
              const Skeleton(height: 16,),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(height: 16,),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Skeleton(height: 16,),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
    this.isList = false,
    required this.listCount,
    required this.listHeight,
    required this.height,
  }) : super(key: key);

  final bool isList;
  final int listCount;
  final double listHeight;
  final double height;

  @override
  Widget build(BuildContext context) {
    return isList
        ? SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  listCount,
                  (index) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12.0)),
                      margin: const EdgeInsets.all(12.0),
                      height: listHeight,
                      width: double.infinity,
                    ),
                  ),
                )
              ],
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0)),
              margin: const EdgeInsets.all(12.0),
              height: height,
              width: double.infinity,
            ),
          );
  }
}

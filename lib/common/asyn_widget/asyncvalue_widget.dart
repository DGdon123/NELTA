// Generic AsyncValueWidget to work with values of type T

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_images.dart';
import 'package:nelta/common/shimmer%20widget/shimmer_widget.dart';

class AsyncValueWidget<T> extends ConsumerWidget {
  const AsyncValueWidget(
      {Key? key,
      required this.value,
      required this.data,
      this.isList = false,
      this.listCount = 4,
      this.listHeight = 100,
      this.height = 200,
      required this.providerBase})
      : super(key: key);
  // input async value
  final AsyncValue<T> value;
  // output builder function
  final Widget Function(T) data;
  final bool isList;
  final int listCount;
  final double listHeight;
  final double height;
  final ProviderBase providerBase;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return value.when(
        data: data,
        loading: () => Center(
                child: ShimmerWidget(
              listCount: listCount,
              listHeight: listHeight,
              isList: isList,
              height: height,
            )),
        error: (e, s) => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenH * 0.2),
                  height: screenH * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(AppImages.noNetImage),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    e == "Instance of 'AppError'"
                        ? "Connection failed due to internet connection"
                        : e.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorResources.buttonBg,
                        elevation: 0,
                        fixedSize: Size(screenW * 0.7, 0)),
                    onPressed: () => ref.refresh(providerBase),
                    child: const Text(
                      "Retry",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }
}

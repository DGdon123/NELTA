import 'package:flutter/material.dart';
import 'package:nelta/common/app_const/app_color.dart';

class HomeOptionCard extends StatelessWidget {
  const HomeOptionCard(
      {super.key,
      required this.onTap,
      required this.option,
      required this.optionLogo});
  final Function()? onTap;
  final String optionLogo;
  final String option;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: AppColorResources.appBg,
                offset: Offset(4, 6),
                spreadRadius: -2)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              optionLogo,
              height: 100,
            ),
            Text(
              option,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeOptionCard2 extends StatelessWidget {
  const HomeOptionCard2(
      {super.key,
      required this.onTap,
      required this.option,
      required this.optionLogo});
  final Function()? onTap;
  final String optionLogo;
  final String option;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            height: 90,
            width: 185,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 0),
                  width: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        option,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: Colors.grey[100],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(optionLogo),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
    // InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     padding: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(
    //       boxShadow: const [
    //         BoxShadow(
    //             color: AppColorResources.appBg,
    //             offset: Offset(4, 6),
    //             spreadRadius: -2)
    //       ],
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Image.asset(optionLogo),
    //         Text(option),
    //       ],
    //     ),
    //   ),
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:nelta/common/app_const/app_color.dart';

class UsertypeCard extends StatelessWidget {
  const UsertypeCard(
      {super.key,
      required this.onTap,
      required this.lable,
      required this.isMember});
  final Function()? onTap;
  final String lable;
  final bool isMember;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          lable,
          style: TextStyle(
              fontFamily: "PS", color: isMember ? Colors.white : Colors.grey),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color: isMember
                ? AppColorResources.appPrimaryColor
                : Color(0xffF1F1F1),
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

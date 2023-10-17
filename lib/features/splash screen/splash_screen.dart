// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:nelta/common/app_const/app_color.dart';
// import 'package:nelta/common/app_const/app_images.dart';
// import 'package:nelta/dashboard.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const Dashboard()));
//       // });
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           color: AppColorResources.appBrowColor,
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Center(
//                     child: Image.asset(
//                   AppImages.appLogo,
//                   width: 227,
//                   height: 227,
//                 )),
//               ),
//               Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 50),
//                     child: Column(
//                       children: const [
//                         Text(
//                           "NELTA",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               // color: ColorsResource.TEXT_GRAY_COLOR,
//                               // fontSize: Dimensions.BODY_10,
//                               fontWeight: FontWeight.normal),
//                         )
//                       ],
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

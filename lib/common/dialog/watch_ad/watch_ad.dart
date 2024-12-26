// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:women_lose_weight_flutter/routes/app_routes.dart';
// import 'package:women_lose_weight_flutter/ui/exercise_list/controllers/exercise_list_controller.dart';
// import 'package:women_lose_weight_flutter/utils/color.dart';
// import 'package:women_lose_weight_flutter/utils/constant.dart';
// import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';
// import 'package:auto_size_text/auto_size_text.dart';
//
// class WatchAdDialog extends StatelessWidget {
//   WatchAdDialog({super.key});
//
//   final ExerciseListController _exerciseListController = Get.find<ExerciseListController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       onPopInvoked: (_) {
//         // Get.back();
//         // Get.back();
//         // return Future.value(false);
//       },
//       child: Scaffold(
//         backgroundColor: AppColor.transparentBlack80,
//         body: SafeArea(
//           child: SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: Stack(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.back();
//                     Get.back();
//                   },
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//
//
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: AppSizes.width_12),
//                         margin: EdgeInsets.only(left: AppSizes.width_10, right: AppSizes.width_10, top: AppSizes.height_3, bottom: AppSizes.height_0_5),
//                         decoration: BoxDecoration(
//                           color: AppColor.primary,
//                           borderRadius: BorderRadius.circular(100.0),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         margin: EdgeInsets.symmetric(horizontal: AppSizes.width_10, vertical: AppSizes.height_1),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100.0),
//                             color: AppColor.grayUnlock),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

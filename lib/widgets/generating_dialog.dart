// import 'package:recruit_iq/generated/assets.dart';
// import 'package:recruit_iq/utils/App_Strings.dart';
// import 'package:recruit_iq/utils/App_Variable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
//
// class GeneratingDialog extends StatelessWidget {
//   const GeneratingDialog({super.key});
//
//   /// Call this to show
//   static void show() {
//     Get.dialog(
//       const GeneratingDialog(),
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.75),
//     );
//   }
//
//   /// Call this to hide
//   static void hide() {
//     if (Get.isDialogOpen ?? false) Get.back();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 60.w),
//         padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.w),
//         decoration: BoxDecoration(
//           color: const Color(0xFF0D0D0D).withOpacity(0.95),
//           borderRadius: BorderRadius.circular(28),
//           border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//
//             /// ANIMATION
//             Image.asset(
//               Assets.commonSandWatchLoader,
//               width: Get.width * 0.28,
//               fit: BoxFit.contain,
//             ),
//
//             SizedBox(height: 32.w),
//
//             /// TITLE
//             Text(
//               AppStrings.strgenerating.tr,
//               style: TextStyle(
//                 fontFamily: gsemibold,
//                 color: Colors.white,
//                 fontSize: textSize * 0.028,
//                 decoration: TextDecoration.none,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//
//             SizedBox(height: 10.w),
//
//             /// SUBTITLE
//             Text(
//               AppStrings.strgeneratingSubtxt.tr,
//               style: TextStyle(
//                 fontFamily: gregular,
//                 color: const Color(0xFF666666),
//                 fontSize: textSize * 0.022,
//                 decoration: TextDecoration.none,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//
//             SizedBox(height: 32.w),
//
//             /// PROGRESS DOTS
//             _PulseDots(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Animated loading dots
// class _PulseDots extends StatefulWidget {
//   @override
//   State<_PulseDots> createState() => _PulseDotsState();
// }
//
// class _PulseDotsState extends State<_PulseDots>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(3, (i) {
//             final delay = i / 3;
//             final value = ((_controller.value - delay) % 1.0).clamp(0.0, 1.0);
//             final opacity = (value < 0.5 ? value * 2 : (1 - value) * 2).clamp(0.2, 1.0);
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: 6,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(opacity),
//                 shape: BoxShape.circle,
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }
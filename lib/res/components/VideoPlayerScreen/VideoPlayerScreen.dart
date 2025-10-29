// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   bool _showControls = false;
//   Timer? _hideControlsTimer;
//   Timer? _watchTimeTimer;
//   int _watchTimeInSeconds = 0;
//   bool _isBuffering = true;
//   bool _isFullscreen = false;
//
//   final VideoWatchTimeController _watchTimeController = Get.put(VideoWatchTimeController());
//   final LessonController lessonController = Get.find();
//   final VideoController controller = Get.find();
//
//   @override
//   void initState() {
//     super.initState();
//     _setupPlayerListener();
//     _startWatchTimeTimer();
//   }
//
//   void _setupPlayerListener() {
//     controller.videoPlayerController?.addListener(() {
//       final value = controller.videoPlayerController!.value;
//
//       if (!mounted) return;
//
//       setState(() {
//         if (value.isBuffering) {
//           _isBuffering = true;
//           Future.delayed(const Duration(seconds: 2), () {
//             if (!mounted) return;
//             final currentValue = controller.videoPlayerController!.value;
//             if (currentValue.isPlaying && !currentValue.isBuffering) {
//               setState(() => _isBuffering = false);
//             }
//           });
//         } else if (value.isPlaying && !value.isBuffering) {
//           _isBuffering = false;
//         } else if (value.position >= value.duration) {
//           _isBuffering = false;
//         } else if (!value.isPlaying) {
//           _isBuffering = false;
//         }
//       });
//     });
//   }
//
//   void _startWatchTimeTimer() {
//     _watchTimeTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (controller.videoPlayerController?.value.isPlaying ?? false) {
//         _watchTimeInSeconds++;
//         debugPrint("⏱️ Watched time: $_watchTimeInSeconds seconds");
//
//         if (_watchTimeInSeconds % 10 == 0) {
//           _postWatchTimeToApi();
//         }
//       }
//     });
//   }
//
//   void _stopWatchTimeTimer() {
//     _watchTimeTimer?.cancel();
//   }
//
//   void _postWatchTimeToApi() {
//     final videoId = lessonController.videoId;
//     if (videoId != 0) {
//       debugPrint("📤 Posting watch time...");
//       _watchTimeController.postVideoWatchTime(context, videoId, _watchTimeInSeconds);
//     } else {
//       debugPrint("❌ No valid videoId to send watch time");
//     }
//   }
//
//   void _toggleControls() {
//     setState(() {
//       _showControls = !_showControls;
//     });
//
//     if (_showControls) {
//       _startHideControlsTimer();
//     }
//   }
//
//   void _startHideControlsTimer() {
//     _hideControlsTimer?.cancel();
//     _hideControlsTimer = Timer(Duration(seconds: 5), () {
//       setState(() {
//         _showControls = false;
//       });
//     });
//   }
//
//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;
//     });
//
//     if (_isFullscreen) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     } else {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//       ]);
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     }
//   }
//
//   @override
//   void dispose() {
//     _stopWatchTimeTimer();
//     _hideControlsTimer?.cancel();
//     controller.videoPlayerController?.dispose();
//     controller.resetPlayer();
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//     return GetBuilder<VideoController>(builder: (_) {
//       if (controller.videoPlayerController == null) {
//         return SizedBox(
//           height: 200,
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }
//       final video = controller.videoPlayerController;
//       return controller.isFloatingVideoVisible && !isLandscape
//           ? SizedBox()
//           : GestureDetector(
//               onTap: _toggleControls,
//               onDoubleTap: _toggleFullscreen, // 👈 Double tap to fullscreen
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 height: _isFullscreen ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.25,
//                 width: MediaQuery.of(context).size.width,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(_isFullscreen ? 0 : 8),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       VideoPlayer(controller.videoPlayerController!),
//                       if (_isBuffering && !video!.value.isPlaying)
//                         const Positioned.fill(
//                           child: Center(child: CircularProgressIndicator()),
//                         ),
//                       if (_showControls)
//                         Container(
//                           color: Colors.black45,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.replay_10, color: Colors.white, size: 40),
//                                       onPressed: () {
//                                         final newPosition =
//                                             controller.videoPlayerController!.value.position - Duration(seconds: 10);
//                                         controller.videoPlayerController!.seekTo(newPosition);
//                                         _startHideControlsTimer();
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         controller.videoPlayerController!.value.isPlaying
//                                             ? Icons.pause_circle_filled
//                                             : Icons.play_circle_filled,
//                                         size: 50,
//                                         color: Colors.white,
//                                       ),
//                                       onPressed: () {
//                                         if (controller.videoPlayerController!.value.isPlaying) {
//                                           controller.videoPlayerController!.pause();
//                                         } else {
//                                           controller.videoPlayerController!.play();
//                                         }
//                                         controller.update();
//                                         _startHideControlsTimer();
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.forward_10, color: Colors.white, size: 40),
//                                       onPressed: () {
//                                         final newPosition =
//                                             controller.videoPlayerController!.value.position + Duration(seconds: 10);
//                                         controller.videoPlayerController!.seekTo(newPosition);
//                                         _startHideControlsTimer();
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 1),
//                                 child: VideoProgressIndicator(
//                                   controller.videoPlayerController!,
//                                   allowScrubbing: true,
//                                   colors: VideoProgressColors(
//                                     playedColor: Colors.red,
//                                     bufferedColor: Colors.white,
//                                     backgroundColor: Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       Positioned(
//                         bottom: 10,
//                         right: 10,
//                         child: IconButton(
//                           icon: Icon(
//                             _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
//                             size: 30,
//                             color: Colors.white,
//                           ),
//                           onPressed: _toggleFullscreen,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//     });
//   }
// }

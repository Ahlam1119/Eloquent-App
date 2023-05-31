import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String asset;
  final String phaseName;
  final String image;
  final Color CircalColor;
  final Color CardColor;
  final Color TextColor;
  final double width;
  final double hight;
  VideoCard(
      {required this.asset,
      required this.phaseName,
      required this.CardColor,
      required this.CircalColor,
      required this.image,
      required this.TextColor,
      required this.hight,
      required this.width});
  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  late String asset = widget.asset;
  late String phaseName = widget.phaseName;
  late String image = widget.image;
  late Color CircalColor = widget.CircalColor;
  late Color CardColor = widget.CardColor;
  late Color TextColor = widget.TextColor;
  late double width = widget.width;
  late double hight = widget.hight;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(asset)
      ..initialize().then((_) {
        setState(() {}); // rebuild the widget once the video is initialized
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _controller.initialize();
        await _controller.setVolume(1.0);
        await _controller.play();
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
            body: SafeArea(
              child: RotatedBox(
                quarterTurns: 1,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        // color: Colors.black.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.fullscreen_exit,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
        _controller.pause();
        setState(
            () {}); // rebuild the widget once the video playback has finished
      },
      child: Container(
        width: 351,
        height: 178,
        child: Card(
          color: CardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          elevation: 3,
          shadowColor: Color.fromARGB(127, 0, 0, 0),
          child: Stack(
            children: [
              Positioned(
                top: -80,
                right: -45,
                child: Transform.rotate(
                  angle: -2.97,
                  child: Container(
                    width: 239,
                    height: 223,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CircalColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                bottom: 10,
                child: Container(
                  width: width,
                  height: hight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                top: 70,
                right: 20,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "مرحلة",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Color(0xfffbfbfb),
                            fontSize: 30,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                            height: 0.2),
                      ),
                      Text(
                        "تمارين " + phaseName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: TextColor,
                          fontSize: 35,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}




// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoCard extends StatefulWidget {
//   @override
//   _VideoCardState createState() => _VideoCardState();
// }

// class _VideoCardState extends State<VideoCard> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset("assets/video.mp4")
//       ..initialize().then((_) {
//         setState(() {}); // rebuild the widget once the video is initialized
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PlaybackWidget(
//       controller: _controller,
//       child: Container(
//         width: 351,
//         height: 200,
//         child: Card(
//           color: Color(0xfff7ebd7),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
//           elevation: 4,
//           shadowColor: Color.fromARGB(127, 0, 0, 0),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: -60,
//                 right: -50,
//                 child: Transform.rotate(
//                   angle: -2.97,
//                   child: Container(
//                     width: 239,
//                     height: 223,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0x99f1bb67),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 bottom: 0,
//                 child: Container(
//                   width: 193,
//                   height: 182,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('images/giraffe.png'),
//                           fit: BoxFit.cover)),
//                 ),
//               ),
//               Positioned(
//                 top: 70,
//                 right: 30,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "مرحلة",
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                             color: Color(0xfffbfbfb),
//                             fontSize: 30,
//                             fontFamily: "Cairo",
//                             fontWeight: FontWeight.w600,
//                             height: 0.8),
//                       ),
//                       Text(
//                         "التنفس",
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                           color: Color(0xff7c6063),
//                           fontSize: 35,
//                           fontFamily: "Cairo",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class PlaybackWidget extends StatefulWidget {
//   final VideoPlayerController controller;
//   final Widget child;

//   PlaybackWidget({required this.controller, required this.child});

//   @override
//   _PlaybackWidgetState createState() => _PlaybackWidgetState();
// }

// class _PlaybackWidgetState extends State<PlaybackWidget> {
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_onPlaybackStatusChanged);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         await widget.controller.initialize();
//         await widget.controller.setVolume(1.0);
//         await widget.controller.play();
//         await Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: SafeArea(
//               child: RotatedBox(
//                 quarterTurns: 1,
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: AspectRatio(
//                         aspectRatio: widget.controller.value.aspectRatio,
//                         child: VideoPlayer(widget.controller),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         width: double.infinity,
//                         color: Colors.black.withOpacity(0.5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               icon: Icon(
//                                 _isPlaying ? Icons.pause : Icons.play_arrow,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPlaying = !_isPlaying;
//                                   _isPlaying
//                                       ? widget.controller.play()
//                                       : widget.controller.pause();
//                                 });
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.fullscreen_exit,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//         setState(() {
//           _isPlaying = false;
//         });
//         widget.controller.pause();
//       },
//       child: widget.child,
//     );
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_onPlaybackStatusChanged);
//     super.dispose();
//   }

//   void _onPlaybackStatusChanged() {
//     setState(() {
//       _isPlaying = widget.controller.value.isPlaying;
//     });
//   }
// }
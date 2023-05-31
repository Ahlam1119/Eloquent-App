import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key,
      required this.callID,
      required this.UserId,
      required this.Name})
      : super(key: key);
  final String callID;
  final String UserId;
  final String Name;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID:
            323356685, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            "60e756cdbc290e7072bcb6f3ee6b1268dd48268d4fd2875f63ee19a73ec398dc", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: UserId,
        userName: Name,
        callID: callID,
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}

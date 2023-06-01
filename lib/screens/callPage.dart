import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter/material.dart';

//  Video Call
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
        appID: 323356685,
        appSign:
            "60e756cdbc290e7072bcb6f3ee6b1268dd48268d4fd2875f63ee19a73ec398dc",
        userID: UserId,
        userName: Name,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}

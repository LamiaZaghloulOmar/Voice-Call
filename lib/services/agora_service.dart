import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_voice_call/main.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  static const String appId = 'dd981e990a0c4799ad90f7505ad13bfc';
  static const String token =
      '007eJxTYAgIXCn9/qvWlc/bFTzzO7ZdCv4au9HNI+HKzpJ9P24vsbyuwJCSYmlhmGppaZBokGxibmmZmGJpkGZuamCamGJonJSW/PKPX1pDICPDsa5mJkYGCATxORnK8jOTU50Tc3IYGAACwiVQ';
  static const String channelName = 'voiceCall';

  late RtcEngine _engine;
  late int _localUid = 0;

  Future<void> initialize() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: AgoraService.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await _engine.enableVideo();

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
        },
        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          debugPrint("remote user $uid joined");
          _localUid = uid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          _engine.leaveChannel();
          Navigator.of(navigatorKey.currentContext!).pop(true);
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannel(
      token: AgoraService.token,
      channelId: AgoraService.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> toggleMute(bool mute) async {
    await _engine.muteLocalAudioStream(mute);
  }

  Future<void> adjustPlaybackVolume(int volume) async {
    await _engine.adjustPlaybackSignalVolume(volume);
  }

  int get localUid => _localUid;

  RtcEngine get engine => _engine;
}

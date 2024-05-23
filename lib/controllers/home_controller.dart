import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_voice_call/services/agora_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AgoraService _agoraService = AgoraService();
  var isMuted = false.obs;
  var playbackVolume = 100.obs;
  var localUid = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAgora();
  }

  void _initializeAgora() async {
    await _agoraService.initialize();
  }

  void joinChannel() async {
    localUid.value = _agoraService.localUid;
  }

  void leaveChannel() async {
    await _agoraService.leaveChannel();
    localUid.value = 0; // Reset the UID when leaving the channel
  }

  void toggleMute() async {
    isMuted.value = !isMuted.value;
    await _agoraService.toggleMute(isMuted.value);
  }

  void changeVolume(int volume) async {
    playbackVolume.value = volume;
    await _agoraService.adjustPlaybackVolume(volume);
  }

  RtcEngine get engine => _agoraService.engine;
}

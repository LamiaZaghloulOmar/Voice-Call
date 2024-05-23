import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class AudioCallScreen extends GetView<HomeController> {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 100,
                backgroundColor: Color.fromARGB(255, 112, 116, 247)),
            const SizedBox(height: 30),
            Obx(() => controller.localUid.value != 0
                ? Text('calling start : ${controller.localUid.value}')
                : const Text('calling start')),
            const SizedBox(height: 60),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        controller.leaveChannel();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.call_end,
                          size: 50, color: Colors.red)),
                  const SizedBox(width: 30),
                  Obx(
                    () => IconButton(
                        onPressed: () => controller.toggleMute(),
                        icon: controller.isMuted.value
                            ? const Icon(
                                Icons.volume_off,
                                size: 40,
                              )
                            : const Icon(
                                Icons.volume_up,
                                size: 40,
                              )),
                  ),
                  const SizedBox(width: 30),
                  if (controller.localUid.value != 0)
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call,
                            size: 50, color: Colors.green)),
                ]),
            Obx(() => Slider(
                  value: controller.playbackVolume.value.toDouble(),
                  min: 0,
                  max: 400,
                  divisions: 40,
                  label: controller.playbackVolume.value.toString(),
                  onChanged: (double value) {
                    controller.changeVolume(value.toInt());
                  },
                )),
            Text('Playback Volume: ${controller.playbackVolume.value}'),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:agora_voice_call/controllers/home_controller.dart';
import 'package:agora_voice_call/views/audio_call.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Voice Call',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 112, 116, 247),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 100,
                backgroundColor: Color.fromARGB(255, 112, 116, 247)),
            const SizedBox(height: 30),
            const Text('calling ----'),
            const SizedBox(height: 60),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        exit(0);
                      },
                      icon: const Icon(Icons.call_end,
                          size: 50, color: Colors.red)),
                  const SizedBox(width: 30),
                  const SizedBox(width: 30),
                  IconButton(
                      onPressed: () {
                        Get.lazyPut(() => HomeController());
                        Get.to(
                          const AudioCallScreen(),
                        );
                      },
                      icon: const Icon(Icons.call,
                          size: 50, color: Colors.green)),
                ]),
          ],
        ),
      ),
    );
  }
}

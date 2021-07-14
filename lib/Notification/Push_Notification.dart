
import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    BuildContext context;

    ///message['title']+' '+message['body']
    _fcm.configure(

      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        const alarmAudioPath = "notification.mp3";
        AudioCache player = new AudioCache();
        player.play(alarmAudioPath);

      },
      onLaunch: (Map<String, dynamic> message) async {

        print("onLaunch: $message");

        const alarmAudioPath = "notification.mp3";
        AudioCache player = new AudioCache();
        player.play(alarmAudioPath);

      },
      onResume: (Map<String, dynamic> message) async {


        print("onResume: $message");
        const alarmAudioPath = "notification.mp3";
        AudioCache player = new AudioCache();
        player.play(alarmAudioPath);


      },

    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ville/api/main.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/enums/main.dart';
import 'package:ville/models/main.dart';
import 'package:ville/scenes/home/HomeOutdoorScene.dart';
import 'package:ville/scenes/indoor/HomeIndoorScene.dart';
import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    register();
  }

  void register() async {
    //Register user to db
    await UserStore.register(
      MPlayer(
        wallet: Config.WALLET_PUBLIC, 
        name: "Nhats"
      )
    );

    //Register user home map
    await MapStore.register(MMap(
      id: Config.WALLET_PUBLIC,
      mapSrc: "maps/PlayerHome1.json",
      type: EMapType.IN_DOOR
    ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeOutdoorScene(),
    );
  }
}

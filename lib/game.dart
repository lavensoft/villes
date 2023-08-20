import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/api/store/UserStore.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/models/main.dart';
import 'package:ville/ui/MainUI.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  void initState() {
    super.initState();

    authClient();
  }

  void authClient() async {
    //Register to db
    await UserStore.register(
      MPlayer(
        wallet: Config.WALLET_PUBLIC, 
        name: "Nhats"
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BonfireWidget(
        showCollisionArea: true,
        cameraConfig: CameraConfig(
            zoom: 1, smoothCameraEnabled: true, moveOnlyMapArea: true),
        joystick: JoystickMoveToPosition(
          enabledMoveCameraWithClick: true,
          mouseButtonUsedToMoveCamera: MouseButton.left,
          mouseButtonUsedToMoveToPosition: MouseButton.right,
        ),
        map: WorldMapByTiled('maps/PlayerHome1.json',
            forceTileSize: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom)),
        player: UPlayer(Vector2(100, 100)),
        overlayBuilderMap: {
          "mainUi": (BuildContext context, BonfireGame game) {
            return const MainUI();
          }
        },
        initialActiveOverlays: const ['mainUi'],
      ),
    );
  }
}

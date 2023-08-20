import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';

class Game extends StatefulWidget {
  const Game({ super.key });

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BonfireWidget(
        showCollisionArea: true,
        cameraConfig: CameraConfig(
          zoom: 1,
          smoothCameraEnabled: true,
          moveOnlyMapArea: true
        ),
        joystick: JoystickMoveToPosition(
          enabledMoveCameraWithClick: true,
          mouseButtonUsedToMoveCamera: MouseButton.left,
          mouseButtonUsedToMoveToPosition: MouseButton.right,
        ),
        map: WorldMapByTiled('maps/PlayerHome1.json', forceTileSize: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom)),
        player: UPlayer(Vector2(100, 100)),
      ),
    );
  }
}
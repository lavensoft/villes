import 'dart:convert';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/api/main.dart';
import 'package:ville/api/store/UserStore.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/enums/EGameObject.dart';
import 'package:ville/enums/main.dart';
import 'package:ville/factories/main.dart';
import 'package:ville/models/main.dart';
import 'package:ville/objects/interiors/Chair.dart';
import 'package:ville/ui/MainUI.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var gameController = GameController();
  var worldMap = WorldMapByTiled("maps/PlayerHome1.json", forceTileSize: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom));

  @override
  void initState() {
    super.initState();

    register();
    loadMap();
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
    await MapStore.register(
      MMap(
        id: Config.WALLET_PUBLIC,
        mapSrc: "maps/PlayerHome1.json",
        mapType: EMapType.IN_DOOR
      )
    );
  }

  void loadMap() async {

  }

  void spawnObject({
    required String objectId,
    Vector2? position,
    bool buildMode = false
  }) {
    var gameObject = GameObjectFactory.createInstance(
      objectId,
      position: position ?? Vector2.all(0),
      buildMode: buildMode
    );

    // gameController.addGameComponent(component)
    gameController.addGameComponent(gameObject);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BonfireWidget(
        gameController: gameController,
        showCollisionArea: true,
        cameraConfig: CameraConfig(
            zoom: 1, smoothCameraEnabled: true, moveOnlyMapArea: true),
        joystick: JoystickMoveToPosition(
          enabledMoveCameraWithClick: true,
          mouseButtonUsedToMoveCamera: MouseButton.left,
          mouseButtonUsedToMoveToPosition: MouseButton.right,
        ),
        map: worldMap,
        player: UPlayer(Vector2(100, 100)),
        overlayBuilderMap: {
          "mainUi": (BuildContext context, BonfireGame game) {
            return MainUI(
              onSpawnObject: (objectId) {
                spawnObject(
                  objectId: objectId,
                  buildMode: true,
                );
              },
            );
          },
        },
        initialActiveOverlays: const ["mainUi"],
      ),
    );
  }
}

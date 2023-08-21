import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/api/main.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/enums/main.dart';
import 'package:ville/factories/main.dart';
import 'package:ville/models/main.dart';
import 'package:ville/objects/GameObject.dart';
import 'package:ville/ui/MainUI.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var gameController = GameController();
  var worldMap = WorldMapByTiled("maps/PlayerHome1.json", forceTileSize: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom));
  var mapMeta = MMap(
    id: Config.WALLET_PUBLIC,
    mapSrc: "maps/PlayerHome1.json",
    type: EMapType.IN_DOOR
  );

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
    await MapStore.register(mapMeta);
  }

  void loadMap() async {
    //Load meta
    //!TODO Realtime load chỉ load lại những item thay đổi, không load lại toàn bộ map
    MapStore.onValue(Config.WALLET_PUBLIC, EMapType.IN_DOOR, (map) {
      map.decorations ??= [];

      setState(() {
        mapMeta = map;

        //Load world map
        // worldMap = WorldMapByTiled(map.mapSrc!, forceTileSize: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom));
      });

      //Load object
      for (var e in mapMeta.decorations!) {
        var gameObject = GameObjectFactory.createInstance(e.id!, position: e.position!);
        var oldObject = gameController.visibleComponents!.where((comp) => comp.position == gameObject.position);

        //Remove old component by their position
        if(oldObject.isNotEmpty) {
          oldObject.first.removeFromParent();
        }

        //Add new
        gameController.addGameComponent(gameObject);
      }
    });
  }

  void spawnBuildModeObject({
    required String objectId,
    Vector2? position,
    bool buildMode = false
  }) {
    var gameObject = GameObjectFactory.createInstance(
      objectId,
      position: position ?? Vector2.all(0),
      buildMode: buildMode,
      onPlace: (position) => addMapMetaDecoration(objectId, position)
    );

    // gameController.addGameComponent(component)
    gameController.addGameComponent(gameObject);
  }

  //Add game object to mapMeta and save on db
  Future addMapMetaDecoration(String objectId, Vector2 position) async {
    mapMeta.decorations?.add(MGameObject(
      id: objectId,
      position: position,
      owner: Config.WALLET_PUBLIC
    ));

    await saveMapMeta();
  }

  //Save mapMeta to db
  Future saveMapMeta() async {
    await MapStore.update(mapMeta);
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
              onSpawnBuildObject: (objectId) {
                spawnBuildModeObject(
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

import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/api/main.dart';
import 'package:ville/characters/npc/Chicken.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/enums/main.dart';
import 'package:ville/factories/main.dart';
import 'package:ville/models/main.dart';
import 'package:ville/objects/main.dart';
import 'package:ville/objects/sensors/TeleSensor.dart';
import 'package:ville/scenes/home/HomeOutdoorScene.dart';
import 'package:ville/ui/MainUI.dart';

class BarnIndoorScene extends StatefulWidget {
  const BarnIndoorScene({super.key});

  @override
  State<BarnIndoorScene> createState() => _BarnIndoorSceneState();
}

class _BarnIndoorSceneState extends State<BarnIndoorScene> {
  final gameController = GameController();
  final mapSrc = "maps/Barn.json";
  final mapType = EMapType.IN_DOOR;
  late Vector2 playerSpawnPos;
  MPlayer player = MPlayer();
  late MMap mapMeta = MMap(
    id: Config.WALLET_PUBLIC,
    mapSrc: mapSrc,
    type: mapType
  );

  @override
  void initState() {
    super.initState();
    loadMap();
    initPlayer();
  }

  //* [PLAYER HANDLERS]
  void initPlayer() async {
    await gameController.mounted;

    //init location
    gameController.player?.position = playerSpawnPos;

    //Listen data
    UserStore.onValue(Config.WALLET_PUBLIC, (p) {
      setState(() {
          player = p;
        });
    });
  }

  //* [MAP HANDLERS]
  void loadMap() async {
    //Load meta
    //!TODO Realtime load chỉ load lại những item thay đổi, không load lại toàn bộ map
    MapStore.onValue(Config.WALLET_PUBLIC, mapType, (map) {
      map.decorations ??= [];

      setState(() {
        mapMeta = map;
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

  Future<dynamic> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info,bool _){
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  void spawnBuildModeObject({
    required MInventoryItem item,
    Vector2? position,
    bool buildMode = false
  }) async {

    var gameObject = DynamicObject(
      position: position ?? Vector2.all(0),
      buildMode: buildMode,
      spriteImage: await getImage(item.spriteSrc!) , 
      spriteSize: item.spriteSize!, 
      objectId: item.id,
      onPlace: (position) {}
    );


    // var gameObject = GameObjectFactory.createInstance(
    //   objectId,
    //   position: position ?? Vector2.all(0),
    //   buildMode: buildMode,
    //   onPlace: (position) => addMapMetaDecoration(objectId, position)
    // );

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

  //Map teleport
  void mapTeleport(String mapSrc) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomeOutdoorScene()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BonfireWidget(
        gameController: gameController,
        showCollisionArea: false,
        cameraConfig: CameraConfig(
            zoom: 1, smoothCameraEnabled: true, moveOnlyMapArea: true),
        joystick:  Joystick(
            keyboardConfig: KeyboardConfig(
            enable: true, // Use to enable ou disable keyboard events (default is true)
            // acceptedKeys: [ // You can pass specific Keys accepted. If null accept all keys
            //   LogicalKeyboardKey.space,
            // ],
            keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // Type of the directional (arrows or wasd)
          ), // Here you , // Here you enable receive keyboard interaction
          directional: JoystickDirectional(
            // spriteBackgroundDirectional: Sprite.load('joystick_background.png'), //directinal control background
            // spriteKnobDirectional: Sprite.load('joystick_knob.png'), // directional indicator circle background
            color: Colors.black, // if you do not pass  'pathSpriteBackgroundDirectional' or  'pathSpriteKnobDirectional' you can define a color for the directional.
            size: 100, // directional control size
            isFixed: false, // enables directional with dynamic position in relation to the first touch on the screen
          ),
        ),
        map: WorldMapByTiled(
          mapSrc, 
          forceTileSize: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom),
          objectsBuilder: {
            "door": (TiledObjectProperties properties) => TeleSensor(
              position: properties.position,
              mapSrc: properties.others["mapSrc"],
              onTele: (e) => mapTeleport(e)
            ),
            "spawnPoint": (TiledObjectProperties properties) {
              setState(() {
                playerSpawnPos = properties.position;
              });

              return SpawnPoint(position: properties.position);
            },
            "chicken": (TiledObjectProperties properties) => Chicken(properties.position)
          }
        ),
        player: UPlayer(Vector2.all(0)),
        overlayBuilderMap: {
          "mainUi": (BuildContext context, BonfireGame game) {
            return MainUI(
              onNFTCreate: () => StatsStore.burnEnergy(50),
              player: player,
              onSpawnBuildObject: (item) {
                spawnBuildModeObject(
                  item: item,
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

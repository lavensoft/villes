import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/api/main.dart';
import 'package:ville/api/shyft/ShyftToken.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/enums/main.dart';
import 'package:ville/factories/main.dart';
import 'package:ville/models/main.dart';
import 'package:ville/objects/main.dart';
import 'package:ville/objects/sensors/TeleSensor.dart';
import 'package:ville/ui/MainUI.dart';
import 'dart:async' as DartAsync;

class HomeOutdoorScene extends StatefulWidget {
  const HomeOutdoorScene({super.key});

  @override
  State<HomeOutdoorScene> createState() => _HomeOutdoorSceneState();
}

class _HomeOutdoorSceneState extends State<HomeOutdoorScene> {
  var gameController = GameController();
  final mapSrc = "maps/PlayerHomeOutdoor1.json";
  final mapType = EMapType.IN_DOOR;
  late MMap mapMeta = MMap(
    id: Config.WALLET_PUBLIC,
    mapSrc: mapSrc,
    type: mapType
  );
  late Vector2 playerSpawnPos;
  late List<MInventoryItem> itemsCollect = [];
  DartAsync.Timer? itemCollectDebounce;

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
  }

  void collectItem(String tokenAddress, int amount) {
    var itemExist = false;
    //Update amount if item exist
    var collects = itemsCollect.map((e) {
      if(e.tokenAddress == tokenAddress) {
        e.amount += amount;
        itemExist = true;
      }

      return e;
    }).toList();

    //Add new if not exist
    if(!itemExist) {
      collects.add(MInventoryItem(
        tokenAddress: tokenAddress,
        amount: amount
      ));
    }

    setState(() {
      itemsCollect = collects;
    });
  
    if(itemCollectDebounce?.isActive ?? false) itemCollectDebounce?.cancel();

    itemCollectDebounce = DartAsync.Timer(const Duration(milliseconds: 5000), () async { 
      //Airdrop token collected
      for(MInventoryItem item in itemsCollect) {
        await Shyft.token.airdropToken(item.tokenAddress, item.amount);
      }
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

  //Map teleport
  void mapTeleport(String mapSrc) {
    print("TELEPORT");
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
            "crop": (TiledObjectProperties properties) => MelonCrop(
              position: properties.position,
              onCollect: (String tokenAddress) async {
                //!TODO: Add add amount
                collectItem(tokenAddress, 1);
              }
            )
          }
        ),
        player: UPlayer(Vector2.all(0)),
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

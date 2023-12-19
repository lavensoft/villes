import 'package:bonfire/bonfire.dart';
import 'package:ville/characters/player/UPlayer.dart';
import 'package:ville/config/Config.dart';

class TeleSensor extends GameDecoration with Sensor {
  TeleSensor({ required Vector2 position, required this.mapSrc, required this.onTele }) : 
    super.withSprite(
      sprite: Sprite.load(
        "ui/transparent.png",
        srcPosition: Vector2.all(0),
        srcSize: Vector2.all(Config.TILE_SIZE)
      ), 
      position: position, 
      size: Vector2.all(Config.TILE_SIZE),
    ) {
      // call this method to configure sensor area.
      setupSensorArea(
          areaSensor: [
              CollisionArea.rectangle(
                  size: Vector2.all(Config.TILE_SIZE),
              ),
          ]
      );
  }

  final String mapSrc;
  final Function onTele;
  bool actived = false;

  @override
  void onContact(GameComponent component) {
    if(!actived && component is UPlayer) {
      print(component);
      onTele(mapSrc);
      actived = true;
    }
  }

  @override
  void onContactExit(GameComponent component) {
    actived = false;
  }
}
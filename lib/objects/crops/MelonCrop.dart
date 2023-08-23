import 'package:bonfire/bonfire.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/enums/main.dart';

class MelonCrop extends GameDecoration with Sensor {
  MelonCrop({ required Vector2 position, required this.onCollect }):
  super.withSprite(
      sprite: Sprite.load(
        "enviroment/springobjects.png",
        srcPosition: Vector2(224, 160),
        srcSize: Vector2.all(16)
      ), 
      position: position, 
      size: Vector2.all(Config.TILE_SIZE - 1),
    ) {
      // call this method to configure sensor area.
      setupSensorArea(
          areaSensor: [
              CollisionArea.rectangle(
                  size: Vector2.all(Config.TILE_SIZE - 1),
              ),
          ]
      );
  }
  
  bool actived = false;
  final Function onCollect;
  final String tokenAddress = ETokenAddress.VI_MELON;

  @override
  void onContact(GameComponent component) {
    if(!actived) {
      actived = true;
      enabledSensor = false;
      onCollect(tokenAddress);
      size = (Vector2.all(0));
    }
  }
}
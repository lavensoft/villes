import 'package:bonfire/bonfire.dart';
import 'package:ville/config/Config.dart';

class TeleSensor extends GameDecoration with Sensor {
  TeleSensor(Vector2 position) : 
    super.withSprite(
      sprite: Sprite.load(
        "enviroment/spring_town.png",
        srcPosition: Vector2.all(0),
        srcSize: Vector2.all(Config.TILE_SIZE)
      ), 
      position: position, 
      size: Vector2.all(Config.TILE_SIZE)
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

  @override
  void onContact(GameComponent component) {
      // do anything with the Component that take contact
      print("TELE");
  }
}
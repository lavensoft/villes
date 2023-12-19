import 'package:bonfire/bonfire.dart';
import 'package:ville/config/Config.dart';

class SpawnPoint extends GameDecoration {
  SpawnPoint({ required Vector2 position }) : 
    super.withSprite(
      sprite: Sprite.load(
        "ui/transparent.png",
        srcPosition: Vector2.all(0),
        srcSize: Vector2.all(Config.TILE_SIZE)
      ), 
      position: position, 
      size: Vector2.all(Config.TILE_SIZE),
    );
}
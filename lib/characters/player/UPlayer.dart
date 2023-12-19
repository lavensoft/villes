import 'package:bonfire/bonfire.dart';
import 'package:ville/api/main.dart';
import 'package:ville/characters/player/UPlayerSpriteSheet.dart';
import 'package:ville/config/Config.dart';
import 'dart:async' as Async;

class UPlayer extends SimplePlayer with ObjectCollision {
  UPlayer(Vector2 position)
      : super(
            position: position,
            size: Vector2(16 * Config.tileZoom, 32 * Config.tileZoom),
            animation: UPlayerSpriteSheet.simpleDirectionAnimation,
            initDirection: Direction.down) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16 * Config.tileZoom, 32 * Config.tileZoom),
            align: Vector2(0, 0),
          ),
        ],
      ),
    );
  }

  Async.Timer? _debounce;

  @override
  void update(double dt) {
    UserStore.updatePosition(super.transform.position, super.lastDirection);
    super.update(dt);
  }
}

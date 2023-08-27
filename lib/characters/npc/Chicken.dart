import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:ville/characters/npc/ChickenSpriteSheet.dart';
import 'package:ville/config/Config.dart';
import "dart:async" as Async;

class Chicken extends SimpleNpc with ObjectCollision {
    Chicken(Vector2 position)
      : super(
          position: position, //required
          size: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom),
          initDirection: Direction.right,
          animation: ChickenSpriteSheet.simpleDirectionAnimation,
      ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16 * Config.tileZoom, 16 * Config.tileZoom),
            align: Vector2(0, 0),
          ),
        ],
      ),
    );
  }

    @override
    void update(double dt) {
      // Do anything
      // runs every 1 second
      Async.Timer.periodic(const Duration(seconds: 1), (timer) {
        super.moveByVector(Vector2(
          Random().nextInt(30).toDouble() - 16,
          Random().nextInt(30).toDouble() - 16
        ));
      });

      super.update(dt);
    }

    @override
    void render(Canvas canvas) {
      // Do anything
      super.render(canvas);
    }

}
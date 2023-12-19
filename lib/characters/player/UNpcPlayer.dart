import 'package:bonfire/bonfire.dart';
import 'package:flutter/painting.dart';
import 'package:ville/api/store/UserStore.dart';
import 'package:ville/characters/player/UNpcPlayerSpriteSheet.dart';
import 'package:ville/config/Config.dart';

class UNpcPlayer extends SimpleAlly with ObjectCollision {
  UNpcPlayer(Vector2 position) : super(
    position: position,
    size: Vector2(16 * Config.tileZoom, 32 * Config.tileZoom),
    animation: UNpcPlayerSpriteSheet.simpleDirectionAnimation,
    initDirection: Direction.down
  ) {
    // setupCollision(
    //   CollisionConfig(
    //     collisions: [
    //       CollisionArea.rectangle(
    //         size: Vector2(16 * Config.tileZoom, 32 * Config.tileZoom),
    //         align: Vector2(0, 0),
    //       ),
    //     ],
    //   ),
    // );
    //Listen data
    UserStore.onValue(Config.S_WALLET_PUBLIC, (p) {
      super.moveByVector(Vector2(
        p.position!.x - super.position.x, 
        p.position!.y - super.position.y
      ));

      if(p.position == super.transform.position) {
        print("IDLE");
        super.idle();
      }else{
        if(p.direction == Direction.up) {
          super.moveUp(0);
        }else if(p.direction == Direction.down) {
          super.moveDown(0);
        }else if(p.direction == Direction.left) {
          super.moveLeft(0);
        }else {
          super.moveRight(0);
        }
      }
    });
  }

  @override
  void render(Canvas canvas) {
    // Do anything
    super.render(canvas);
  }

}
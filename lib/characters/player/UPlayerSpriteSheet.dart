// ignore_for_file: file_names

import 'package:bonfire/bonfire.dart';

class UPlayerSpriteSheet {
  static double runStepTime = .24;
  static double idleStepTime = .24;
  static String spriteImage = "player/player3.png";

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: UPlayerSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 64)),
      );


  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: UPlayerSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 0)),
      );
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: UPlayerSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 32)),
      );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: UPlayerSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 32),
            texturePosition: Vector2(0, 96)),
      );

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: UPlayerSpriteSheet.runStepTime,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 64),
        ),
      );


  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: UPlayerSpriteSheet.runStepTime,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 0),
        ),
      );


  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: UPlayerSpriteSheet.runStepTime,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 32),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        UPlayerSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: UPlayerSpriteSheet.runStepTime,
          textureSize: Vector2(16, 32),
          texturePosition: Vector2(0, 96),
        ),
      );


  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleUp: idleUp,
        idleDown: idleDown,
        idleRight: idleRight,
        idleLeft: idleLeft,
        runUp: runUp,
        runDown: runDown,
        runRight: runRight,
        runLeft: runLeft,
      );
}

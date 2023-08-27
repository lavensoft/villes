// ignore_for_file: file_names

import 'package:bonfire/bonfire.dart';

class ChickenSpriteSheet {
  static double runStepTime = .24;
  static double idleStepTime = .24;
  static String spriteImage = "characters/ChickWhiteBig.png";

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: ChickenSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 16),
            texturePosition: Vector2(0, 32)),
      );


  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: ChickenSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 16),
            texturePosition: Vector2(0, 48)),
      );
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: ChickenSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 16),
            texturePosition: Vector2(0, 16)),
      );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: ChickenSpriteSheet.idleStepTime,
            textureSize: Vector2(16, 16),
            texturePosition: Vector2(0, 0)),
      );

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: ChickenSpriteSheet.runStepTime,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 32),
        ),
      );


  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: ChickenSpriteSheet.runStepTime,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 48),
        ),
      );


  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: ChickenSpriteSheet.runStepTime,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 16),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        ChickenSpriteSheet.spriteImage,
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: ChickenSpriteSheet.runStepTime,
          textureSize: Vector2(16, 16),
          texturePosition: Vector2(0, 0),
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

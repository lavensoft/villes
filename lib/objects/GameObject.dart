import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class GameObject extends GameDecoration {
  GameObject({
    required Vector2 position,
    required String imageSrc,
    required Vector2 size,
    int amount = 1,
    double stepTime = 0,
    Vector2? textureSize,
    required Vector2 texturePosition,
    required this.objectId,
  }) : super.withAnimation(
    animation: SpriteAnimation.load(
      imageSrc,
      SpriteAnimationData.sequenced(
        amount: amount, 
        stepTime: stepTime, 
        textureSize: textureSize ?? size,
        texturePosition: texturePosition,
      )
    ),
    position: position, 
    size: size
  );

  String objectId;

  @override
  void update(double dt) {
      // do anything
      super.update(dt);
  }

  @override
  void render(Canvas canvas) {
      // do anything
      super.render(canvas);
  }
}
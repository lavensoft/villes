import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/objects/GameObject.dart';

class DynamicObject extends GameDecoration with MouseGesture {
  DynamicObject({
    required Vector2 position,
    this.buildMode = false,
    this.onPlace,
    required this.spriteImage,
    required this.spriteSize,
    required this.objectId
  }) : super.withSprite(
    sprite: Sprite(
      spriteImage, 
      srcPosition: Vector2.all(0), 
      srcSize: spriteSize
    ), 
    position: position, 
    size: Vector2(spriteSize.x * Config.tileZoom, spriteSize.y * Config.tileZoom),
  );

  //   position: position,
  //   imageSrc: spriteSrc,
  //   size: Vector2(spriteSize.x * Config.tileZoom, spriteSize.y * Config.tileZoom),
  //   amount: 1,
  //   stepTime: 1,
  //   textureSize: spriteSize,
  //   texturePosition: Vector2(0, 0),
  //   objectId: id
  // );

  bool buildMode;
  Function(Vector2 position)? onPlace;
  Vector2 spriteSize;
  String objectId;
  final dynamic spriteImage;

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

  @override
  void onMouseHoverScreen(int pointer, Vector2 position) {
    if(buildMode) {
      double gridSize = Config.TILE_SIZE;
      this.position = Vector2(
        (position.x / gridSize).floorToDouble() * gridSize,
        (position.y / gridSize).floorToDouble() * gridSize
      );
    }
  }
  
  @override
  void onMouseTap(MouseButton button) {
    if(buildMode) {
      buildMode = false;

      onPlace!(position);
    }
  }
}
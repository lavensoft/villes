import 'dart:ui';
import 'package:bonfire/bonfire.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/objects/GameObject.dart';

class Chair extends GameObject with MouseGesture {
  Chair({
    required Vector2 position,
    this.buildMode = false,
    this.onPlace
  }) : super(
    position: position,
    imageSrc: "interiors/townInterior.png",
    size: Vector2(16 * Config.tileZoom, 32 * Config.tileZoom),
    amount: 1,
    stepTime: 1,
    textureSize: Vector2(16, 32),
    texturePosition: Vector2(144, 240),
    objectId: "chair"
  );

  bool buildMode;
  Function(Vector2 position)? onPlace;

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
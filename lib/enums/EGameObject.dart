import 'package:bonfire/bonfire.dart';
import 'package:ville/objects/interiors/Chair.dart';

final Map<String, Function> EGameObject = {
  "chair": ({
    required position,
    buildMode = false,
    Function(Vector2 position)? onPlace,
  }) => Chair(
    position: position,
    buildMode: buildMode,
    onPlace: onPlace
  )
};
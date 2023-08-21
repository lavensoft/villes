import 'package:ville/objects/interiors/Chair.dart';

final Map<String, Function> EGameObject = {
  "chair": ({
    required position,
    buildMode = false
  }) => Chair(
    position: position,
    buildMode: buildMode
  )
};
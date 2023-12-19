import 'package:bonfire/bonfire.dart';
import 'package:ville/enums/EGameObject.dart';

class GameObjectFactory {
  static final Map<String, Function> _classMap = EGameObject;

  static createInstance(String objectId, {
    required Vector2 position,
    buildMode = false,
    Function(Vector2 position)? onPlace,
  }) {
    if (_classMap.containsKey(objectId)) {
      return _classMap[objectId]!(
        position: position,
        buildMode: buildMode,
        onPlace: onPlace,
      ); // Call the function to create an instance
    } else {
      throw Exception("Class not found");
    }
  }
}
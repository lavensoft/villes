import 'package:bonfire/bonfire.dart';

class MGameObject {
  String? id;
  Vector2? position;
  String? owner;
  Map<String, dynamic> properties = {};

  MGameObject({
    this.id,
    this.position,
    this.owner,
    this.properties = const {}
  });

  toMap() {
    //!TODO: REMOVE NULL FIELD
    return {
      "id": id,
      "position": position != null ? {
        "x": position?.x,
        "y": position?.y
      } : null,
      "owner": owner,
      "properties": properties 
    };
  }

  MGameObject fromMap(Map data) {
    id = data["id"];
    owner = data["owner"];
    properties = data["properties"] ?? {};

    if(data["position"] != null) {
      position = Vector2(data["position"]["x"] * 1.0, data["position"]["y"] * 1.0);
    }

    return this;
  }
}
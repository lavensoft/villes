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
      "position": position,
      "owner": owner,
      "properties": properties 
    };
  }

  MGameObject fromMap(Map data) {
    id = data["id"];
    position = data["position"];
    owner = data["owner"];
    properties = data["properties"] ?? {};

    return this;
  }
}
import 'package:ville/enums/main.dart';
import 'package:ville/models/main.dart';

class MMap {
  String? id;
  String? mapSrc;
  String? mapType;
  List<MGameObject> decorations = [];

  MMap({
    this.id,
    this.mapSrc,
    this.decorations = const [],
    this.mapType
  });

  toMap() {
    //!TODO: REMOVE NULL FIELD
    return {
      "id": id,
      "mapSrc": mapSrc,
      "type": mapType,
      "decorations": decorations.map((e) => e.toMap()).toList()
    };
  }

  MMap fromMap(Map data) {
    id = data["id"];
    mapSrc = data["mapSrc"];
    mapType = data["mapType"];
    
    if(data["decorations"] != null) {
      decorations = (data["decorations"] as List).map((d) => MGameObject().fromMap(d)).toList();
    }

    return this;
  }
}
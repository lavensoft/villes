import 'package:ville/models/main.dart';

class MMap {
  String? id;
  String? mapSrc;
  String? type;
  List<MGameObject>? decorations;

  MMap({
    this.id,
    this.mapSrc,
    this.decorations,
    this.type
  });

  toMap() {
    //!TODO: REMOVE NULL FIELD
    return {
      "id": id,
      "mapSrc": mapSrc,
      "type": type,
      "decorations": decorations?.map((e) => e.toMap()).toList()
    };
  }

  MMap fromMap(Map data) {
    id = data["id"];
    mapSrc = data["mapSrc"];
    type = data["type"];
    
    if(data["decorations"] != null) {
      decorations = (data["decorations"] as List).map((d) => MGameObject().fromMap(d)).toList();
    }

    return this;
  }
}
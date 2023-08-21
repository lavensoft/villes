import 'package:firebase_database/firebase_database.dart';
import 'package:ville/enums/main.dart';
import 'package:ville/models/main.dart';

class MapStore {  
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future register(MMap map) async {
    var resp = await database.ref("maps/${map.mapType}/${map.id}").get();
    
    if(resp.value != null) {
      return;
    }

    await database.ref("maps/${map.mapType}/${map.id}").set(map.toMap());
  }
}
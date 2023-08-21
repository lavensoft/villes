import 'package:firebase_database/firebase_database.dart';
import 'package:ville/models/main.dart';

class MapStore {  
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future register(MMap map) async {
    var resp = await database.ref("maps/${map.type}/${map.id}").get();
    
    if(resp.value != null) {
      return;
    }

    await database.ref("maps/${map.type}/${map.id}").set(map.toMap());
  }

  static onValue(String id, String type, Function(MMap) onData) {
    database.ref("maps/$type/$id").onValue.listen((event) {
      final data = event.snapshot.value;
      if(data != null) {
        onData(MMap().fromMap((data as Map)));
      }
    }); 
  }

  static update(MMap map) async {
    await database.ref("maps/${map.type}/${map.id}").update(map.toMap());
  }
}
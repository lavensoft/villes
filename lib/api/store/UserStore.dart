import 'package:firebase_database/firebase_database.dart';
import 'package:ville/models/main.dart';
import 'package:ville/models/player/MPlayerStats.dart';

class UserStore {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static register(MPlayer player) async {
    return await database.ref("users/${player.wallet}").set(player.toMap());
  }

  static onValue(String wallet, Function(MPlayer) onData) async {
    database.ref("users/$wallet").onValue.listen((event) {
      final data = event.snapshot.value;
      if(data != null) {
        onData(MPlayer().fromMap((data as Map)));
      }
    }); 
  }
}
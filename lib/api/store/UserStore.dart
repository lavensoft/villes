import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/models/main.dart';
import 'package:ville/models/player/MPlayerStats.dart';

class UserStore {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static StreamSubscription<DatabaseEvent>? onValueSub;

  static Future register(MPlayer player) async {
    var resp = await database.ref("users/${player.wallet}").get();
    
    if(resp.value != null) {
      return;
    }

    await database.ref("users/${player.wallet}").set(player.toMap());
  }

  static onValue(String wallet, Function(MPlayer) onData) {
    onValueSub = database.ref("users/$wallet").onValue.listen((event) {
      final data = event.snapshot.value;
      if(data != null) {
        onData(MPlayer().fromMap((data as Map)));
      }
    }); 
  }

  static Future updatePosition(Vector2 position, Direction direction) async {
    await database.ref("users/${Config.WALLET_PUBLIC}").update({
      "position": [position.x, position.y],
      "direction": direction.index
    });
  }

  static cancelOnValue() async {
    await onValueSub!.cancel();
  }
}
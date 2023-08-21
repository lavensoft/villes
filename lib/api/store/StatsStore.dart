import 'package:firebase_database/firebase_database.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/models/player/MPlayerStats.dart';

class StatsStore {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<MPlayerStats> getStats(String wallet) async {
    var resp = await database.ref("users/$wallet").get();

    return MPlayerStats().fromMap((resp.value as Map)["stats"]);
  }

  static Future burnEnergy(int amount) async {
    MPlayerStats playerStats = await getStats(Config.WALLET_PUBLIC);
    playerStats.energy -= amount;
    
    if(playerStats.energy < 0) playerStats.energy = 0;

    await database.ref("users/${Config.WALLET_PUBLIC}").update({
      "stats": playerStats.toMap()
    });
  }

  static Future addEnergy(int amount) async {
    MPlayerStats playerStats = await getStats(Config.WALLET_PUBLIC);
    playerStats.energy += amount;

    if(playerStats.energy > 200) playerStats.energy = 200;

    await database.ref("users/${Config.WALLET_PUBLIC}").set({
      "stats": playerStats.toMap()
    });
  }
}
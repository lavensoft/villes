import 'package:ville/models/player/MPlayerStats.dart';

class MPlayer {
  late String? wallet;
  late String? name;
  MPlayerStats? stats;

  MPlayer({ this.wallet, this.name, this.stats });

  toMap() {
    //!TODO: REMOVE NULL FIELD
    return {
      "wallet": wallet,
      "name": name,
      "stats": stats?.toMap() ?? MPlayerStats(energy: 200).toMap()
    };
  }

  MPlayer fromMap(Map data) {
    wallet = data["wallet"] ?? "";
    name = data["name"] ?? "";
    stats = MPlayerStats().fromMap(data["stats"]);

    return this;
  }
}
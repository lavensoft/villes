import 'package:bonfire/bonfire.dart';
import 'package:ville/models/player/MPlayerStats.dart';

class MPlayer {
  late String? wallet;
  late String? name;
  MPlayerStats? stats;
  late Vector2? position;
  late Direction? direction;

  MPlayer({ this.wallet, this.name, this.stats, this.position, this.direction });

  toMap() {
    //!TODO: REMOVE NULL FIELD
    return {
      "wallet": wallet,
      "name": name,
      "stats": stats?.toMap() ?? MPlayerStats(energy: 200).toMap(),
      "position": [position!.x, position!.y],
      "direction": direction,
    };
  }

  MPlayer fromMap(Map data) {
    wallet = data["wallet"] ?? "";
    name = data["name"] ?? "";
    stats = data["stats"] != null ? MPlayerStats().fromMap(data["stats"]) : MPlayerStats(energy: 200);
    position = Vector2(data["position"][0] ?? 0, data["position"][1] ?? 0);
    direction = data["direction"] != null ? 
     data["direction"] == 3 ? Direction.down :
     data["direction"] == 2 ? Direction.up :
     data["direction"] == 1 ? Direction.right :
     Direction.left
     : Direction.down;

    return this;
  }
}
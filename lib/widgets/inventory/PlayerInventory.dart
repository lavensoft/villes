import 'package:flutter/material.dart';
import 'package:ville/api/shyft/Shyft.dart';
import 'package:ville/models/MInventoryItem.dart';
import 'package:ville/widgets/inventory/InventorySlot.dart';

class PlayerInventory extends StatefulWidget {
  const PlayerInventory({super.key});

  @override
  State<PlayerInventory> createState() => _PlayerInventoryState();
}

class _PlayerInventoryState extends State<PlayerInventory> {
  List<MInventoryItem> items = [];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    final tokenResp = await Shyft.wallet.getAllTokens();
    final tokens = (tokenResp["result"] as List).map(
      (item) => MInventoryItem(
        item["info"]["symbol"],
        item["info"]["image"],
        item["balance"],
        item["info"]["name"]
      )
    ).toList();

    setState(() {
      items = tokens;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 420,
      color: Colors.white,
      child: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        crossAxisCount: 6,
        children: items.map((i) => 
          InventorySlot(image: Image.network(i.image), amount: i.amount)
        ).toList()
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ville/api/main.dart';
import 'package:ville/api/shyft/Shyft.dart';
import 'package:ville/models/MInventoryItem.dart';
import 'package:ville/models/player/MPlayerStats.dart';
import 'package:ville/widgets/inventory/InventorySlot.dart';

class PlayerInventory extends StatefulWidget {
  const PlayerInventory({ super.key, required this.onClose, required this.visible });

  final Function onClose;
  final bool visible;

  @override
  State<PlayerInventory> createState() => _PlayerInventoryState();
}

class _PlayerInventoryState extends State<PlayerInventory> {
  List<MInventoryItem> items = [];

  @override
  void initState() {
    super.initState();
    fetchTokens();
  }

  void fetchTokens() async {
    final tokenResp = await Shyft.wallet.getAllTokens();
    final tokens = (tokenResp["result"] as List).map(
      (item) => MInventoryItem(
        id: item["info"]["symbol"],
        image: item["info"]["image"],
        amount: item["balance"],
        name: item["info"]["name"],
        tokenAddress: item["address"],
      )
    ).toList();

    setState(() {
      items = tokens;
    });
  }

  void burnItem(int itemIndex, int amount) async {
    List<MInventoryItem> nItems = List.from(items);
    nItems[itemIndex].amount -= amount;

    if(nItems[itemIndex].amount <= 0) {
      nItems.removeAt(itemIndex);
    }

    setState(() {
      items = nItems;
    });

    //Burn on shyft
    await Shyft.token.burnToken(nItems[itemIndex].tokenAddress, amount);
  }

  void eatItem(int itemIndex, int amount) async {
    burnItem(itemIndex, amount);
    //!TODO: Cộng năng lượng từ thông số của thực phẩm vừa ăn [ ENERGY ]
    await StatsStore.addEnergy(10);
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.visible) return Container();
    
    return Container(
      width: 600,
      height: 420,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text("X"),
              onPressed: () => widget.onClose(),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 6,
              children: items.asMap().entries.map((entry) {
                MInventoryItem i = entry.value;
                int index = entry.key;

                return InventorySlot(
                  image: Image.network(i.image), 
                  amount: i.amount,
                  onEat: () {
                    eatItem(index, 1);
                  },
                );
              }).toList()
            ),
          )
        ],
      )
    );
  }
}

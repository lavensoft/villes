import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ville/api/main.dart';
import 'package:ville/models/main.dart';
import 'package:ville/widgets/market/MarketSlot.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({ super.key });

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  List<MInventoryItem> items = [];
  List<MMarketItem> ownListedItems = [];
  List<MMarketItem> listedItems = [];

  //Sale
  int? itemSaleSelectedIndex;
  var supplyTxtCtrl = TextEditingController();
  var priceTxtCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchInventory();
    fetchListed();
  }

  void fetchInventory() async {
    //Fetch all tokens
    final tokens = await Shyft.wallet.getInventoryItems();

    setState(() {
      items = tokens;
    });

    //!TODO: FETCH ALLS NFT
  }

  void fetchListed() async {
    List<MMarketItem> olItems = await Shyft.market.getOwnListed();
    List<MMarketItem> lItems = await Shyft.market.getListed();

    setState(() {
      ownListedItems = olItems;
      listedItems = lItems;
    });
  }


  //* [BUY HANDLERS]
  void buyItem(int itemIndex) {
    MMarketItem item = listedItems[itemIndex];

    Shyft.market.buyItem(item);
    
    //Remove on store
    listedItems.removeAt(itemIndex);
  }

  //* [SALE HANDLERS]
  void listOnMarket() {
    //!TODO: After list on market, need to transfer item to Lavenes wallet
    int amount = int.parse(supplyTxtCtrl.text);
    int price = int.parse(priceTxtCtrl.text);
    var marketItem = MMarketItem(
      tokenAddress: items[itemSaleSelectedIndex!].tokenAddress,
      amount: amount,
      billBoard: false,
      price: price,
      image: items[itemSaleSelectedIndex!].image,
      type: items[itemSaleSelectedIndex!].type
    );

    Shyft.market.listToken(
      item: marketItem,
      price: price,
      amount: amount
    );
    
    priceTxtCtrl.text = "";
    supplyTxtCtrl.text = "";

    List<MInventoryItem> newItems = [];

    for(int i = 0; i < items.length; i++) {
      if(i == itemSaleSelectedIndex) {
        items[i].amount -= amount;

        if(items[i].amount > 0) {
          newItems.add(items[i]);
        }
      }else{
        newItems.add(items[i]);
      }
    }

    ownListedItems.add(marketItem);

    setState(() {
      itemSaleSelectedIndex = null;
      items = newItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //* [MARKET]
        Container(
          height: 600,
          child: Column(
            children: [
              //* [LISTING PLACE]
              Container(
                width: 600,
                height: 118,
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: GridView.count(
                  crossAxisCount: 6,
                  crossAxisSpacing: 12,
                  children: ownListedItems.map((e) => MarketSlot(imageSrc: e.image!, amount: e.amount!, price: e.price)).toList(),
                ),
              ),
              //* [MARKETPLACE]
              Container(
                width: 600,
                height: 360,
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: listedItems.asMap().entries.map((entry) {
                    MMarketItem i = entry.value;
                    int index = entry.key;

                    return MarketSlot(
                      amount: i.amount!,
                      imageSrc: i.image!,
                      price: i.price!,
                      onTap: () => buyItem(index),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        //* [LIST CONFIG]
        Container(
          height: 600,
          child: Column(
            children: [
              //* [LISTING PLACE]
              Container(
                width: 420,
                height: 179,
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      color: Colors.black,
                      child: itemSaleSelectedIndex != null ? Image.network(items[itemSaleSelectedIndex!].image) : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Container(
                          width: 240,
                          child: TextField(
                            controller: supplyTxtCtrl,
                            decoration: const InputDecoration(
                              hintText: "Supply",
                              hintStyle: TextStyle(
                                fontSize: 14
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Container(
                          width: 240,
                          child: TextField(
                            controller: priceTxtCtrl,
                            decoration: const InputDecoration(
                              hintText: "Price",
                              hintStyle: TextStyle(
                                fontSize: 14
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () => listOnMarket(),
                          child: Text("List on market")
                        )
                      ],
                    )
                  ],
                )
              ),
              //* [MARKETPLACE]
              Container(
                width: 420,
                height: 299,
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: items.asMap().entries.map((entry) {
                    MInventoryItem i = entry.value;
                    int index = entry.key;

                    return MarketSlot(
                      amount: i.amount,
                      imageSrc: i.image,
                      onTap: () {
                        setState(() {
                          itemSaleSelectedIndex = index;
                        });

                        supplyTxtCtrl.text = i.amount.toString();
                        priceTxtCtrl.text = "0";
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
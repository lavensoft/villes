import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/models/main.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class ShyftMarket {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  //List token ( amount > 1 )
  Future listToken({ required MMarketItem item, required int amount, required int price, bool? billBoard = false }) async {
    await database.ref("markets/${getRandomString(15)}").set({
      "seller": Config.WALLET_PUBLIC,
      "tokenAddress": item.tokenAddress,
      "amount": amount,
      "price": price,
      "image": item.image,
      "billBoard": billBoard
    });
  }

  Future<List<MMarketItem>> getListed() async {
    Map value = ((await database.ref("markets").get()).value as Map);
    List<MMarketItem> listed = value.entries.map((e) => MMarketItem(
      image: value[e.key]["image"],
      amount: value[e.key]["amount"],
      billBoard: value[e.key]["billBoard"],
      seller: value[e.key]["seller"],
      price: value[e.key]["price"],
      tokenAddress: value[e.key]["tokenAddress"],
    )).toList();

    //Filter seller
    listed = listed.where((element) => element.seller == Config.WALLET_PUBLIC).toList();

    return listed;
  }
}
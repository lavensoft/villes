import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:ville/api/main.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/models/main.dart';
import "package:http/http.dart" as http;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class ShyftMarket {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  //List token ( amount > 1 )
  Future listToken({required MMarketItem item, required int amount, required int price, bool? billBoard = false}) async {
    await database.ref("markets/${getRandomString(15)}").set({
      "seller": Config.WALLET_PUBLIC,
      "tokenAddress": item.tokenAddress,
      "amount": amount,
      "price": price,
      "image": item.image,
      "billBoard": billBoard,
      "type": item.type,
      "fee": item.fee
    });

    if(item.type == "nfts") { //NFT //!TODO: MARKET
      final Map<String, dynamic> data = {
        "network": Config.WALLET_NETWORK,
        "marketplace_address": Config.MARKET_ADDRESS,
        "private_key": Config.WALLET_PRIVATE,
        "nft_address": item.tokenAddress,
        "price": price
      };

      await http.post(Uri.https("api.shyft.to", "sol/v0/marketplace/list"),
        headers: {
          'Content-Type': 'application/json',
          "x-api-key": Config.SHYFT_KEY
        },
        body: jsonEncode(data)
      );
    }else{ //TOKEN
      final Map<String, dynamic> data = {
        "network": Config.WALLET_NETWORK,
        "from_address": Config.WALLET_PRIVATE,
        "to_address": Config.L_WALLET_PUBLIC,
        "token_address": item.tokenAddress,
        "amount": amount
      };

      await http.post(Uri.https("api.shyft.to", "sol/v1/token/transfer"),
        headers: {
          'Content-Type': 'application/json',
          "x-api-key": Config.SHYFT_KEY
        },
        body: jsonEncode(data)
      );
    }
  }

  Future<List<MMarketItem>> getOwnListed() async {
    var snap = await database.ref("markets").get();

    if(snap.value == null) return [];

    Map value = snap.value as Map;
    List<MMarketItem> listed = value.entries
        .map((e) => MMarketItem(
              image: value[e.key]["image"],
              amount: value[e.key]["amount"],
              billBoard: value[e.key]["billBoard"],
              seller: value[e.key]["seller"],
              price: value[e.key]["price"],
              tokenAddress: value[e.key]["tokenAddress"],
              type: value[e.key]["type"],
              fee: value[e.key]["fee"],
              marketId: e.key
            ))
        .toList();

    //Filter seller
    listed = listed
        .where((element) => element.seller == Config.WALLET_PUBLIC)
        .toList();

    return listed;
  }

  Future<List<MMarketItem>> getListed() async {
    var snap = await database.ref("markets").get();

    if(snap.value == null) return [];

    Map value = snap.value as Map;
    List<MMarketItem> listed = value.entries
        .map((e) => MMarketItem(
              image: value[e.key]["image"],
              amount: value[e.key]["amount"],
              billBoard: value[e.key]["billBoard"],
              seller: value[e.key]["seller"],
              price: value[e.key]["price"],
              tokenAddress: value[e.key]["tokenAddress"],
              type: value[e.key]["type"],
              fee: value[e.key]["fee"],
              marketId: e.key
            ))
        .toList();

    //Filter seller
    listed = listed
        .where((element) => element.seller != Config.WALLET_PUBLIC)
        .toList();

    return listed;
  }

  Future buyItem(MMarketItem item) async {
    if(item.type == "nfts") { //NFT Shyft Marketplace //!TODO: FIXIT
      final Map<String, dynamic> data = {
        "network": Config.WALLET_NETWORK,
        "private_key": Config.WALLET_PRIVATE,
        "seller_address": item.seller,
        "marketplace_address": Config.MARKET_ADDRESS,
        "nft_address": item.tokenAddress,
        "price": item.price! - item.fee!
      };

      await http.post(Uri.https("api.shyft.to", "sol/v0/marketplace/buy"),
        headers: {
          'Content-Type': 'application/json',
          "x-api-key": Config.SHYFT_KEY
        },
        body: jsonEncode(data)
      );
    }else{ //TOKEN Buy
      //Transfer emerald to seller
      await Shyft.token.transferEmerald(item.seller!, item.price!);

      print("DONE");

      //Airdrop token
      await Shyft.token.airdrop(item.tokenAddress!, item.amount!);
    }

    //Remove item onstore
    // await database.ref("markets/${item.marketId}").remove();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ville/config/Config.dart';

class ShyftWallet {
  Future<Map> getAllTokens() async {
    if(Config.SHYFT_API_ENABLED) {
      final Map<String, dynamic> data = {
        "network": Config.WALLET_NETWORK,
        "wallet": Config.WALLET_PUBLIC
      };

      final http.Response response = await http.get(
        Uri.https("api.shyft.to", "sol/v1/wallet/all_tokens", data),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "x-api-key": Config.SHYFT_KEY
        },
      );

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      return decodedResponse;
    }

    return {
      "success": true,
      "message": "1 tokens fetched successfully",
      "result": [
        {
          "address": "HTrU8JQTLwaiHddqXgrX8dn7EAzLWjhDpkt2vk6VMTec",
          "balance": 10000,
          "associated_account": "EVcMm8XiN4Kkveenr2tCuAAGccv73QUZ36ffM56QSaGf",
          "info": {
            "name": "Ville Wheat Seed",
            "symbol": "VLF",
            "image": "https://nftstorage.link/ipfs/bafkreihf2jwoiubgvqlvhc4vjz5yajaitujvhls2n6zfkmmgc7tro2sfxu",
            "decimals": 0
          }
        },
        {
          "address": "chair",
          "balance": 10000,
          "associated_account": "EVcMm8XiN4Kkveenr2tCuAAGccv73QUZ36ffM56QSaGf",
          "info": {
            "name": "Chair",
            "symbol": "chair",
            "image": "https://nftstorage.link/ipfs/bafkreihf2jwoiubgvqlvhc4vjz5yajaitujvhls2n6zfkmmgc7tro2sfxu",
            "decimals": 0
          }
        }
      ]
    };
  }
}
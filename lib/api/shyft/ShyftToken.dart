import 'dart:convert';

import 'package:ville/config/Config.dart';
import "package:http/http.dart" as http;

class ShyftToken {
  Future burn(String tokenAddress, int amount) async {
    final Map<String, dynamic> data = {
      "network": Config.WALLET_NETWORK,
      "private_key": Config.WALLET_PRIVATE,
      "token_address": tokenAddress,
      "amount": amount
    };

    await http.delete(
      Uri.https("api.shyft.to", "sol/v1/token/burn"),
      headers: {
        'Content-Type': 'application/json',
        "x-api-key": Config.SHYFT_KEY
      },
      body: jsonEncode(data)
    );
  }

  Future airdrop(String tokenAddress, int amount) async {
    final Map<String, dynamic> data = {
      "network": Config.WALLET_NETWORK,
      "from_address": Config.L_WALLET_PRIV,
      "to_address": Config.WALLET_PUBLIC,
      "token_address": tokenAddress,
      "amount": amount
    };

    await http.post(
      Uri.https("api.shyft.to", "sol/v1/token/transfer"),
      headers: {
        'Content-Type': 'application/json',
        "x-api-key": Config.SHYFT_KEY
      },
      body: jsonEncode(data)
    );
  }

  Future transferEmerald(String toAddress, int amount) async {
    final Map<String, dynamic> data = {
      "network": Config.WALLET_NETWORK,
      "from_address": Config.WALLET_PRIVATE,
      "to_address": toAddress,
      "token_address": Config.EMERALD_ADDRESS,
      "amount": amount
    };

    await http.post(
      Uri.https("api.shyft.to", "sol/v1/token/transfer"),
      headers: {
        'Content-Type': 'application/json',
        "x-api-key": Config.SHYFT_KEY
      },
      body: jsonEncode(data)
    );
  }

  Future stake(int amount) async {
    await transferEmerald(Config.L_WALLET_PUBLIC, amount);
  }
}
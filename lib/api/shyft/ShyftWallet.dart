import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ville/config/Config.dart';

class ShyftWallet {
  Future<Map> getAllTokens() async {
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
}
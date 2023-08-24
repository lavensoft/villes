import "dart:convert";

import "package:http/http.dart" as http;
import "package:ville/config/Config.dart";

class ShyftNFT {
  Future airdrop(String tokenAddress) async {
    final Map<String, dynamic> data = {
      "network": Config.WALLET_NETWORK,
      "from_address": Config.L_WALLET_PRIV,
      "to_address": Config.WALLET_PUBLIC,
      "token_address": tokenAddress,
    };

    await http.post(
      Uri.https("api.shyft.to", "sol/v1/nft/transfer"),
      headers: {
        'Content-Type': 'application/json',
        "x-api-key": Config.SHYFT_KEY
      },
      body: jsonEncode(data)
    );
  }
}
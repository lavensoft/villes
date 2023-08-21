import 'package:ville/config/Config.dart';
import "package:http/http.dart" as http;

class ShyftToken {
  static Future burn(String tokenAddress, int amount) async {
    if(Config.SHYFT_API_ENABLED) {
      final Map<String, dynamic> data = {
        "network": Config.WALLET_NETWORK,
        "private_key": Config.WALLET_PRIVATE,
        "token_address": tokenAddress,
        "amount": amount
      };

      await http.delete(
        Uri.https("api.shyft.to", "sol/v1/token/burn"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "x-api-key": Config.SHYFT_KEY
        },
        body: data
      );

      return;
    }

    return;
  }
}
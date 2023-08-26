import "dart:convert";
import 'package:http_parser/http_parser.dart';
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

  Future create({
    required String name,
    required int maxSupply,
    required String desc,
    required int width,
    required int height,
    required String symbol,
    required List<int> thumbBytes,
    required List<int> spriteBytes,
  }) async {
    var request = http.MultipartRequest("POST", Uri.https("api.shyft.to", "sol/v1/nft/create"));

    //*BODY
    request.fields["private_key"] = Config.WALLET_PRIVATE;
    request.fields["max_supply"] = maxSupply.toString();
    request.fields["name"] = name;
    request.fields["royalty"] = "0";
    request.fields["network"] = Config.WALLET_NETWORK;
    request.fields["receiver"] = Config.WALLET_PUBLIC;
    request.fields["attributes"] = "[  {    \"width\": \"$width\",    \"height\": \"$height\"  }]";
    request.fields["symbol"] = symbol;
    request.fields["description"] = desc;
    request.fields["service_charge"] = "{  \"receiver\": \"${Config.WALLET_PUBLIC}\",  \"amount\": 0.01}";
    request.files.add(
      http.MultipartFile.fromBytes("file", thumbBytes, contentType: MediaType("image", "png"), filename: "thumb.png")
    );
    request.files.add(
      http.MultipartFile.fromBytes("data", spriteBytes, contentType: MediaType("image", "png"), filename: "sprite.png")
    );

    //*HEADERS
    request.headers["x-api-key"] = Config.SHYFT_KEY;
    request.headers["Content-Type"] = "multipart/form-data";

    await request.send();
  }
}
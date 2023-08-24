import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ville/config/Config.dart';
import 'package:ville/models/main.dart';

class ShyftWallet {
  Future<List> getAllNFTs() async {
    if(Config.SHYFT_API_ENABLED) {
      final Map<String, dynamic> data = {
        "network": Config.WALLET_NETWORK,
        "address": Config.WALLET_PUBLIC
      };

      final http.Response response = await http.get(
        Uri.https("api.shyft.to", "https://api.shyft.to/sol/v1/nft/read_all", data),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "x-api-key": Config.SHYFT_KEY
        },
      );

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      return decodedResponse["result"] != null ? (decodedResponse["result"] as List) : [];
    }

    return [
    {
      "name": "FOX",
      "symbol": "VI_AFX",
      "royalty": 5,
      "image_uri": "https://nftstorage.link/ipfs/bafkreie4syfjmssy75v6r3pbj2npa6qnneoc6esrje5mfhcb25uxnkqrie",
      "cached_image_uri": "https://nftstorage.link/ipfs/bafkreie4syfjmssy75v6r3pbj2npa6qnneoc6esrje5mfhcb25uxnkqrie",
      "animation_url": "",
      "cached_animation_url": "",
      "metadata_uri": "https://nftstorage.link/ipfs/bafkreihcaanthl2j2k5rsx5hmordyztb6l3gra2l4gwpvxvkxfqua5yzgy",
      "description": "FOX",
      "mint": "9MvJiavBVtL4cbxNG9AnCA722GUETmYAL3kQpQY4wovC",
      "owner": "3bRB21mj2t279iYufzjmJoupUbsrCVDHgUzgWzACHrJu",
      "update_authority": "8s4VZvLAq6Hpoi3ahuF7zSVHDh9mX7tAUMNAJsDGwzLe",
      "creators": [
        {
          "address": "8s4VZvLAq6Hpoi3ahuF7zSVHDh9mX7tAUMNAJsDGwzLe",
          "share": 100,
          "verified": true
        }
      ],
      "collection": {},
      "attributes": {
        "edification": "100"
      },
      "attributes_array": [
        {
          "trait_type": "edification",
          "value": "100"
        }
      ],
      "files": [
        {
          "uri": "https://nftstorage.link/ipfs/bafkreie4syfjmssy75v6r3pbj2npa6qnneoc6esrje5mfhcb25uxnkqrie",
          "type": "image/png"
        },
        {
          "uri": "https://nftstorage.link/ipfs/bafkreie4syfjmssy75v6r3pbj2npa6qnneoc6esrje5mfhcb25uxnkqrie",
          "type": "image/png"
        }
      ],
      "external_url": "",
      "primary_sale_happened": false,
      "is_mutable": true,
      "token_standard": "NonFungible",
      "is_loaded_metadata": true,
      "is_compressed": false,
      "merkle_tree": ""
    },
    {
      "name": "Monkey Money",
      "symbol": "VI_MKN",
      "royalty": 5,
      "image_uri": "https://nftstorage.link/ipfs/bafybeifum26csy7fmoacqxglpnptelzlagmalv3f6rlef2n4yi5qsteuse",
      "cached_image_uri": "https://nftstorage.link/ipfs/bafybeifum26csy7fmoacqxglpnptelzlagmalv3f6rlef2n4yi5qsteuse",
      "animation_url": "",
      "cached_animation_url": "",
      "metadata_uri": "https://nftstorage.link/ipfs/bafkreibwwlikuo5kqs4yqjfsg7jgrtxijmxnqr5vgd2xefttiauudneapm",
      "description": "FOX",
      "mint": "PMeZrrhYMuFn7FtzJj9RTM4Uc37de7oEUL6kz44auB6",
      "owner": "3bRB21mj2t279iYufzjmJoupUbsrCVDHgUzgWzACHrJu",
      "update_authority": "3bRB21mj2t279iYufzjmJoupUbsrCVDHgUzgWzACHrJu",
      "creators": [
        {
          "address": "3bRB21mj2t279iYufzjmJoupUbsrCVDHgUzgWzACHrJu",
          "share": 100,
          "verified": true
        }
      ],
      "collection": {},
      "attributes": {
        "edification": "100"
      },
      "attributes_array": [
        {
          "trait_type": "edification",
          "value": "100"
        }
      ],
      "files": [
        {
          "uri": "https://nftstorage.link/ipfs/bafybeifum26csy7fmoacqxglpnptelzlagmalv3f6rlef2n4yi5qsteuse",
          "type": "image/gif"
        },
        {
          "uri": "https://nftstorage.link/ipfs/bafybeifum26csy7fmoacqxglpnptelzlagmalv3f6rlef2n4yi5qsteuse",
          "type": "image/gif"
        }
      ],
      "external_url": "",
      "is_loaded_metadata": true,
      "primary_sale_happened": false,
      "is_mutable": true,
      "token_standard": "NonFungible",
      "is_compressed": false,
      "merkle_tree": ""
    }
  ];
  }

  Future<List> getAllTokens() async {
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

      return decodedResponse["result"] != null ? (decodedResponse["result"] as List) : [];
    }

    return [
      {
        "address": "GLWVrFHE3Mp6tHeX7KCpUxs9NGCef2pE8E1GVpyvUGov", 
        "balance": 100, 
        "associated_account": "d7P4oVcJurtowEAHzxz4vxVFgcZ7Vu5T3V3fpERZqjz", 
        "info": {
          "name": "Ville Melon", 
          "symbol": "VI_MELON", 
          "image": "https://nftstorage.link/ipfs/bafkreidkm4esmc4s4e4q5iqq5ea6k2tr7sgjotznkcbit3lczzieryhvvi", 
          "decimals": 0
        }
      }
    ];
  }

  Future<List<MInventoryItem>> getInventoryItems() async {
    List tokens = await getAllTokens();
    List nfts = await getAllNFTs();
    List<MInventoryItem> items = [];

    for (var element in tokens) {
      items.add(
        MInventoryItem(
          id: element["address"],
          image: element["info"]["image"],
          amount: element["balance"],
          name: element["info"]["name"],
          tokenAddress: element["address"],
          type: "token"
        )
      );
    }

    for (var element in nfts) {
      items.add(
        MInventoryItem(
          id: element["mint"],
          image: element["image_uri"],
          amount: 1,
          name: element["name"],
          tokenAddress: element["mint"],
          type: "nft"
        )
      );
    }

    return items;
  }
}
import 'package:bonfire/bonfire.dart';

class MInventoryItem {
  late String id;
  late String image;
  late int amount;
  late String name;
  late String tokenAddress;
  String? type;
  String? spriteSrc;
  Vector2? spriteSize;

  MInventoryItem({ 
    this.id = "", 
    this.image = "", 
    this.amount = 0, 
    this.name = "", 
    this.tokenAddress = "",
    this.type,
    this.spriteSrc,
    this.spriteSize
  });

  Map toMap() {
    return {
      "id": id,
      "image": image,
      "amount": amount,
      "name": name,
      "tokenAddress": tokenAddress,
      "type": type,
      "spriteSrc": spriteSrc,
      "spriteSize": spriteSize
    };
  }
}
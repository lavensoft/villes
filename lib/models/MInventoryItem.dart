class MInventoryItem {
  late String id;
  late String image;
  late int amount;
  late String name;
  late String tokenAddress;
  String? type;

  MInventoryItem({ 
    this.id = "", 
    this.image = "", 
    this.amount = 0, 
    this.name = "", 
    this.tokenAddress = "",
    this.type
  });

  Map toMap() {
    return {
      "id": id,
      "image": image,
      "amount": amount,
      "name": name,
      "tokenAddress": tokenAddress,
      "type": type
    };
  }
}
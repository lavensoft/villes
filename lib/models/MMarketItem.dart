class MMarketItem {
  String? marketId;
  String? seller;
  String? tokenAddress;
  int? amount;
  bool? billBoard;
  int? price;
  String? image;
  String? type;

  MMarketItem({
    this.marketId,
    this.seller,
    this.tokenAddress,
    this.amount,
    this.billBoard,
    this.price,
    this.image,
    this.type
  });

  Map toMap() {
    return {
      "marketId": marketId,
      "seller": seller,
      "tokenAddress": tokenAddress,
      "amount": amount,
      "billBoard": billBoard,
      "price": price,
      "image": image,
      "type": type
    };
  }
}
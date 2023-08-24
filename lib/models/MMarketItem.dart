class MMarketItem {
  String? seller;
  String? tokenAddress;
  int? amount;
  bool? billBoard;
  int? price;
  String? image;

  MMarketItem({
    this.seller,
    this.tokenAddress,
    this.amount,
    this.billBoard,
    this.price,
    this.image
  });

  Map toMap() {
    return {
      "seller": seller,
      "tokenAddress": tokenAddress,
      "amount": amount,
      "billBoard": billBoard,
      "price": price,
      "image": image
    };
  }
}
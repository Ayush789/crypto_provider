class WalletCoin {
  String Id, ImageUrl, Name, Symbol;
  List<double> priceHistory;
  double Price, Amount, PriceChange;

  WalletCoin({
    this.Id,
    this.ImageUrl,
    this.Price,
    this.priceHistory,
    this.Amount,
    this.Name,
    this.PriceChange,
    this.Symbol,
  });

  WalletCoin fromJson(dynamic data, double amount) {
    return WalletCoin(
      Symbol: data["symbol"] as String,
      priceHistory: // [1000, 2000, 3000, 4000, 5000, 2300],
          (data["market_data"]["sparkline_7d"]["price"] as List)
              .map((i) => i as double)
              .toList(),
      Id: data["id"] as String,
      Name: data["name"] as String,
      Price: data["market_data"]["current_price"]["usd"] as double,
      ImageUrl: data["image"]["small"] as String,
      PriceChange: data["market_data"]["price_change_percentage_7d"] as double,
      Amount: amount,
    );
  }

  @override
  String toString() {
    return "Id: $Id Name: $Name Symbol: $Symbol ImgUrl: $ImageUrl Price: $Price Histroy: $priceHistory Amount: $Amount\n";
  }
}

WalletCoin democoin = WalletCoin(
  Id: "bitcoin",
  Amount: 0.0,
  ImageUrl:
      "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png?1547033579",
  Name: "Bitcoin",
  Price: 100.0,
  PriceChange: 0.2,
  priceHistory: [100, 200, 300, 200, 500],
  Symbol: "BTC",
);

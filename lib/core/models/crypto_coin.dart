class CryptoCoin {
  String Id, Name, Symbol;

  CryptoCoin({
    this.Name,
    this.Id,
    this.Symbol,
  });

  CryptoCoin fromJson(dynamic data) {
    return CryptoCoin(
      Id: data["id"] as String,
      Name: data["name"] as String,
      Symbol: data["symbol"] as String,
    );
  }

  @override
  String toString() {
    return "Id: $Id Name: $Name Symbol: $Symbol\n";
  }
}

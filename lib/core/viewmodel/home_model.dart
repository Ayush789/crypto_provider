import 'package:crypto_provider/core/enums/viewstates.dart';
import 'package:crypto_provider/core/models/coin.dart';
import 'package:crypto_provider/core/services/api.dart';

import '../../locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  API _api = locator<API>();

  List<WalletCoin> coins = [
    WalletCoin(
      Id: "bitcoin",
      Amount: 0.0,
      ImageUrl:
          "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png?1547033579",
      Name: "Bitcoin",
      Price: 100.0,
      PriceChange: 0.2,
      priceHistory: [100, 200, 300, 200, 500],
      Symbol: "BTC",
    ),
  ];

  List<CryptoCoin> allcoins;

  double Balance = 0.0, Increment = 0.0;

  Future getPrices() async {
    setState(ViewState.Busy);
    for (int i = 0; i < coins.length; i++) {
      coins[i] = await _api.getPrice(coins[i].Id);
    }
    setState(ViewState.Idle);
  }
  Future getAllCoins() async {
    setState(ViewState.Busy);
    allcoins = await _api.getAllCoins();
    setState(ViewState.Idle);
  }

  Future addCoin(CryptoCoin coin) async{
    setState(ViewState.Busy);
    coins.add(await _api.getPrice(coin.Id));
    print("Added Coin");
    print(coins.length);
    setState(ViewState.Idle);
  }

}

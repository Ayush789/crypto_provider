import 'package:crypto_provider/core/enums/viewstates.dart';
import 'package:crypto_provider/core/models/crypto_coin.dart';
import 'package:crypto_provider/core/models/wallet_coin.dart';
import 'package:crypto_provider/core/services/api.dart';
import 'package:crypto_provider/core/sharedmodel/all_coins.dart';

import '../../locator.dart';
import 'base_model.dart';

class AddCoinModel extends BaseModel {
  AllCoins _allCoins = locator<AllCoins>();
  API _api = locator<API>();

  List<CryptoCoin> get allcoins => _allCoins.allcoins;

  Future addCoin(CryptoCoin coin, double amt) async {
    setState(ViewState.Busy);
    WalletCoin newcoin = await _api.getPrice(coin.Id, amt);
    _allCoins.coins.add(newcoin);
    _allCoins.Balance += newcoin.Amount * newcoin.Price;
    print("Added Coin");
    print(_allCoins.coins.length);
    setState(ViewState.Idle);
  }

  Future getAllCoins() async {
    setState(ViewState.Busy);
    _allCoins.allcoins = await _api.getAllCoins();
    setState(ViewState.Idle);
  }
}

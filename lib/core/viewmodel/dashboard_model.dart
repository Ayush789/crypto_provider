import 'package:crypto_provider/core/enums/viewstates.dart';
import 'package:crypto_provider/core/models/crypto_coin.dart';
import 'package:crypto_provider/core/models/wallet_coin.dart';
import 'package:crypto_provider/core/services/api.dart';
import 'package:crypto_provider/core/sharedmodel/all_coins.dart';

import '../../locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  API _api = locator<API>();
  AllCoins _allCoins = locator<AllCoins>();

  List<WalletCoin> get coins => _allCoins.coins;

  List<CryptoCoin> get allcoins => _allCoins.allcoins;

  double get Balance => _allCoins.Balance;

  double get Increment => _allCoins.Increment;

  Future getPrices() async {
    setState(ViewState.Busy);
    double bal = 0;
    for (int i = 0; i < _allCoins.coins.length; i++) {
      _allCoins.coins[i] =
          await _api.getPrice(_allCoins.coins[i].Id, _allCoins.coins[i].Amount);
      bal += _allCoins.coins[i].Amount * _allCoins.coins[i].Price;
    }
    setState(ViewState.Idle);
  }
}

import 'dart:convert';
import 'package:crypto_provider/core/models/coin.dart';
import 'package:http/http.dart';

class API {
  String baseUrl = "https://api.coingecko.com/api/v3";

  Future<WalletCoin> getPrice(String coinId) async {
    String url = "$baseUrl/coins/${coinId}?sparkline=true";
    var resp = await get(url);
    var data = jsonDecode(resp.body);
    return WalletCoin().fromJson(data, 0.1);
  }

  Future<List<CryptoCoin>> getAllCoins() async {
    String url = "$baseUrl/coins/";
    var resp = await get(url);
    var data = jsonDecode(resp.body);
    List<CryptoCoin> curlist = [];
    for (int i = 0; i < data.length; i++) {
      curlist.add(
        CryptoCoin().fromJson(data[i]),
      );
    }
    return curlist;
  }
}

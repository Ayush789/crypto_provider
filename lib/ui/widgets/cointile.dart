
import 'package:crypto_provider/core/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class CoinListBox extends StatefulWidget {
  WalletCoin coin;

  CoinListBox({
    @required this.coin,
  });

  @override
  _CoinListBoxState createState() => _CoinListBoxState();
}

class _CoinListBoxState extends State<CoinListBox> {

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: 9.0, left: w * 0.044, right: w * 0.044),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: w * 0.91),
        child: Container(
          height: w * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xFF546E79),
          ),
          width: w * 0.91,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  //"https://www.coinbase.com/assets/assets/1-8022fd53c251f18cb39cefede445f1c78a3b265989232f0bb46b9c4622e55a9e.png",
                  widget.coin.ImageUrl,
                  height: w * 0.15,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    //"BTC",
                    widget.coin.Symbol,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                      "\$${widget.coin.Price.toStringAsFixed(2)}"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "\$${(widget.coin.Price * widget.coin.Amount).toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    //"\$6,544.44",
                    "\$${widget.coin.Price.toStringAsFixed(2)}",
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 8.0),
                width: w * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                      child: Sparkline(
                        data: widget.coin.priceHistory,
                        lineColor: Color(0xFF76FF03),
                        fillMode: FillMode.below,
                        fillGradient: LinearGradient(
                          colors: [
                            Color(0xFF3D7F36),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      constraints:
                      BoxConstraints(maxWidth: w * 0.2, maxHeight: w * .10),
                    ),
                    (widget.coin.priceHistory != null)
                        ? Stack(
                      children: <Widget>[
                        Container(
                          height: w * 0.05,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF3D7F36),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              //"+08.56%",
                              widget.coin.PriceChange.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_upward,
                              size: 14.0,
                              color: Color(0xFF76FF03),
                            ),
                          ],
                        ),
                      ],
                    )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
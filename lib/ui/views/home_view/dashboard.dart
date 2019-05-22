import 'package:crypto_provider/core/viewmodel/home_model.dart';
import 'package:crypto_provider/ui/widgets/cointile.dart';
import 'package:flutter/material.dart';

import '../base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return BaseView<HomeModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text("Wallet"),
          ),
          drawer: Drawer(),
          body: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: w,
                      height: w * 0.63,
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            "assets/back.png",
                            height: w * 0.55,
                          ),
                          Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.autorenew,
                                        color: Color(0xFF2095F3),
                                      ),
                                      onPressed: () {
                                        model.getPrices();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "\$${model.Balance}",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          (model.Increment >= 0) ? "+" : "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          (model.Balance *
                                                  model.Increment *
                                                  0.01)
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          "(${model.Increment}%)",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Icon(
                                          (model.Increment >= 0.0)
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward,
                                          color: (model.Increment >= 0.0)
                                              ? Colors.green
                                              : Colors.red,
                                          size: 18.0,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "My Wallet",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "\$${model.Balance}(${model.Increment}%)",
                                    style: TextStyle(color: Color(0xFF78909C)),
                                  ),
                                  Icon(
                                    (model.Increment >= 0.0)
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: (model.Increment >= 0.0)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 18.0,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text(
                            "ADD COIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF40C4FF),
                                fontSize: 16.0),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/add');
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => CoinListBox(
                          coin: model.coins[index],
                        ),
                    itemCount: model.coins.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

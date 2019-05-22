import 'package:crypto_provider/core/enums/viewstates.dart';
import 'package:crypto_provider/core/models/crypto_coin.dart';
import 'package:crypto_provider/core/viewmodel/add_coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'base_view.dart';

class AddCoinPage extends StatefulWidget {
  @override
  _AddCoinPageState createState() => _AddCoinPageState();
}

class _AddCoinPageState extends State<AddCoinPage> {
  TextEditingController coinController = TextEditingController(),
      amountController =
          TextEditingController.fromValue(TextEditingValue(text: "1.0"));
  bool selected = false;
  CryptoCoin selectedCoin;

  @override
  Widget build(BuildContext context) {
    return BaseView<AddCoinModel>(
      onModelReady: (model) => model.getAllCoins(),
      builder: (context, model, child) => Scaffold(
            appBar: AppBar(),
        body: (model.state == ViewState.Busy)
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Search A Coin To Add",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TypeAheadField<CryptoCoin>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: coinController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (selected) {
                                setState(() {
                                  coinController.text = "";
                                  selected = false;
                                  selectedCoin = null;
                                });
                              }
                            },
                            icon: Icon(
                              selected ? Icons.clear : Icons.search,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                          ),
                        ),
                        cursorColor: Colors.white,
                      ),
                      onSuggestionSelected: (CryptoCoin suggestion) {
                        print("Selected $suggestion");
                        setState(() {
                          selected = true;
                          selectedCoin = suggestion;
                          coinController.text =
                          "${suggestion.Name} (${suggestion.Symbol
                              .toUpperCase()})";
                        });
                      },
                      suggestionsCallback: (pattern) =>
                          model.allcoins
                              .where((s) =>
                          s.Name.toString()
                              .toLowerCase()
                              .contains(pattern) ||
                              s.Symbol.toString()
                                  .toLowerCase()
                                  .contains(pattern))
                              .toList(),
                      itemBuilder: (BuildContext context, itemData) =>
                          ListTile(
                            title: Text(
                                "${itemData.Name} (${itemData.Symbol
                                    .toUpperCase()})"),
                          ),
                      getImmediateSuggestions: true,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    Text(
                      "Amount",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                            flex: 1,
                            child: FlatButton(
                                onPressed: () {
                                  setState(
                                        () {
                                      amountController.text =
                                          (double.tryParse(
                                              amountController
                                                  .text) -
                                              1)
                                              .toString();
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ))),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .primaryColor),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            validator: (val) {
                              if (double.tryParse(val) == null) {
                                return "Value has to be a number";
                              }
                              return null;
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FlatButton(
                              onPressed: () {
                                setState(
                                      () {
                                    amountController.text =
                                        (double.tryParse(
                                            amountController
                                                .text) +
                                            1)
                                            .toString();
                                  },
                                );
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.green,
                              )),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    MaterialButton(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: (model.state != ViewState.Busy)
                          ? Text(
                        "Add Coin",
                        style: TextStyle(color: Colors.white),
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      disabledColor: Colors.grey,
                      color: Colors.blue,
                      onPressed: (selectedCoin != null)
                          ? () async {
                        if (selectedCoin != null) {
                          await model.addCoin(
                              selectedCoin,
                              double.tryParse(
                                  amountController.text));
                          Navigator.pop(context);
                        }
                      }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
          ),
    );
  }
}

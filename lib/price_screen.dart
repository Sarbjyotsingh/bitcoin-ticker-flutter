import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_Price.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton dropdownButtonAndroid() {
    List<DropdownMenuItem<String>> dropDownMenu = new List();
    for (String currency in currenciesList) {
      dropDownMenu.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropDownMenu,
      onChanged: (value) {
        setState(() {
          getCoinPrice();
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker cupertinoPickerIOS() {
    List<Widget> pickerItems = new List();
    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
        getCoinPrice();
      },
      children: pickerItems,
    );
  }

  void getCoinPrice() async {
    String bitPrice = await CoinPrice.getBitCoinPrice(selectedCurrency);
    String ethPrice = await CoinPrice.getETHCoinPrice(selectedCurrency);
    String ltcPrice = await CoinPrice.getLTCCoinPrice(selectedCurrency);

    setState(() {
      bitCoinPrice = bitPrice;
      ethCoinPrice = ethPrice;
      ltcCoinPrice = ltcPrice;
    });
  }

  String bitCoinPrice = '?';
  String ethCoinPrice = '?';
  String ltcCoinPrice = '?';
  String selectedCurrency = 'AUD';

  @override
  void initState() {
    getCoinPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: <Widget>[
              CryptoCard(
                price: bitCoinPrice,
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'BTC',
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                price: ethCoinPrice,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                price: ltcCoinPrice,
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? dropdownButtonAndroid()
                : cupertinoPickerIOS(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.price,
    @required this.selectedCurrency,
    @required this.cryptoCurrency,
  }) : super(key: key);
  final String cryptoCurrency;
  final String price;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $price $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

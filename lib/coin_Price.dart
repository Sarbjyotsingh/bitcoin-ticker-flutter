import 'package:bitcoin_ticker/network.dart';

class CoinPrice {
  static String url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';
  static dynamic getBitCoinPrice(String currency) async {
    String price = await Network().getPriceOfCurrency('${url}BTC$currency');
    return price;
  }

  static dynamic getETHCoinPrice(String currency) async {
    String price = await Network().getPriceOfCurrency('${url}ETH$currency');
    return price;
  }

  static dynamic getLTCCoinPrice(String currency) async {
    String price = await Network().getPriceOfCurrency('${url}LTC$currency');
    return price;
  }
}

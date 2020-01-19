import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  dynamic getPriceOfCurrency(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic responseBody = jsonDecode(response.body);
        return responseBody['last'].toInt().toString();
      } else {
        print(response.statusCode);
        throw 'ERROR GETTING DATA';
      }
    } catch (e) {
      print(e);
    }
  }
}

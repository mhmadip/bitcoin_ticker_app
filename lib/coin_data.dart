import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CurrencyRate {
  double rate;

  Future<dynamic> getData(String coin, String base) async {
    // http://example.org/path?q=dart.
    //"https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=93811603-9BE1-4976-94B8-0000000000";
    Uri url = Uri.https("rest.coinapi.io", "/v1/exchangerate/$base/$coin",
        {"apikey": "F39749A9-BD46-46D2-BB5F-000000000000"});
    //Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      rate = jsonResponse['rate'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print('BTC TO USD RATE: $rate.');
    print(rate.runtimeType);
    return rate;
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

//class CoinData {}

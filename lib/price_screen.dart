import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  String selectedBase = cryptoList[0];
  int currencyDataBTC = 0, currencyDataETH = 0, currencyDataLTC = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyData();
  }

  void getCurrencyData() async {
    CurrencyRate currencyRate = CurrencyRate();
    double currency =
        await currencyRate.getData(selectedCurrency, selectedBase);
    double currency1 =
        await currencyRate.getData(selectedCurrency, cryptoList[1]);
    double currency2 =
        await currencyRate.getData(selectedCurrency, cryptoList[2]);
    setState(() {
      currencyDataBTC = currency.round();
      currencyDataETH = currency1.round();
      currencyDataLTC = currency2.round();
    });

    print(currencyDataBTC);
    print(currencyDataETH);
    print(currencyDataLTC);
  }

  DropdownButton androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownList.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownList,
        onChanged: (value) {
          setState(() {
            getCurrencyData();
            selectedCurrency = value;
            print(selectedCurrency);
            print(currencyDataBTC);
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerList.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightGreen,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          getCurrencyData();

          selectedCurrency = currenciesList[selectedIndex];
          print(currenciesList[selectedIndex]);
        });
      },
      children: pickerList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('💰 BitCoin Ticker'),
        ),
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightGreen,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[0]} =$currencyDataBTC  $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightGreen,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[1]} =$currencyDataETH $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightGreen,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[2]} =$currencyDataLTC $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightGreen,
                  child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
                )
              ]),
        ));
  }
}

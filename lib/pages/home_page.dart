import 'dart:convert';

import 'package:coincapp/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;

  HTTPService? _http;

  @override
  void initState() {
    _http = GetIt.instance.get<HTTPService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            _selectedCoincDropdown(),
            _dataWidgets(),
          ],
        ),
      )),
    );
  }

  Widget _selectedCoincDropdown() {
    List<String> _coins = ["bitcoin"];
    List<DropdownMenuItem<String>> _items = _coins.map((_item) {
      return DropdownMenuItem(
        value: _item,
        child: Text(
          _item,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }).toList();

    return DropdownButton(
      value: _coins.first,
      items: _items,
      onChanged: (_value) {},
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      underline: Container(),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
        future: _http!.get("/coins/bitcoin"),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            Map _data = jsonDecode(_snapshot.data.toString());
            num _usdPrice = _data["market_data"]["current_price"]["usd"];
            num _eurPrice = _data["market_data"]["current_price"]["eur"];
            num _change24 = _data["market_data"]["price_change_percentage_24h"];
            String _image = _data["image"]["large"];
            String _description = _data["description"]["en"];

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _coinImageWidget(_image),
                _currentPriceWidget(_usdPrice, _eurPrice),
                _percentageChangeWidget(_change24),
                _coinDescriptionCardWidget(_description),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }

  Widget _currentPriceWidget(num _usd, num _eur) {
    return Text(
      "${_usd.toStringAsFixed(2)} USD | ${_eur.toStringAsFixed(2)} EUR",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _percentageChangeWidget(num _change) {
    return Text(
      "${_change.toString()} %",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImageWidget(String _imgUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration:
          BoxDecoration(image: DecorationImage(image: NetworkImage(_imgUrl))),
    );
  }

  Widget _coinDescriptionCardWidget(String _description) {
    return Container(
        height: _deviceHeight! * 0.45,
        width: _deviceWidth! * 0.90,
        margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.05),
        padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.01,
          horizontal: _deviceHeight! * 0.01,
        ),
        color: const Color.fromRGBO(83, 88, 206, 0.5),
        child: Text(_description,
            style: const TextStyle(
              color: Colors.white,
            )));
  }
}

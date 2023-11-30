import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  Map coinData = {};

  DetailsPage({super.key, required this.coinData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView.builder(itemBuilder: ((context, index) {
        final _entry = this.coinData.entries.elementAt(index);
        final _key = _entry.key;
        final _value = _entry.value;

        return ListTile(
          title: Text(
            "$_key : $_value",
            style: const TextStyle(color: Colors.white),
          ),
        );
      }))),
    );
  }
}

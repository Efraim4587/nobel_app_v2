import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobel/types/country.dart';

class WinnersByCountryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;

    // Cast the 'country' argument to the 'Country' type
    final Country country = arguments['country'] as Country;

    return Scaffold(
      appBar: AppBar(
        title: Text('Winners from ${country.name}'),
      ),
      body: Center(
        child: Text('Winners from ${country.name}'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllWinnersByYearRangePage extends StatelessWidget {
  const AllWinnersByYearRangePage({super.key});



  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;

    final int startYear = arguments['startYear'];
    final int endYear = arguments['endYear'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Winners from $startYear to $endYear'),
      ),
      body: Center(
        child: Text('Winners from $startYear to $endYear'),
      ),
    );
  }
}

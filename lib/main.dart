import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nobel/types/country.dart';
import 'api/api_service.dart';
import 'widgets/winners_by_country.dart';
import 'widgets/all_winners_by_year_range.dart';
import 'widgets/all_winning_countries.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyHomePage(),
      getPages: [
        GetPage(name: '/winners_by_country/:countryCode', page: () => WinnersByCountryPage()),
        GetPage(name: '/all_winners_by_year_range/:startYear/:endYear', page: () => AllWinnersByYearRangePage()),
        GetPage(name: '/all_winning_countries', page: () => AllWinningCountriesPage()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // The logo animation
  //LottieAnimationController? _logoAnimationController;

  // The first button
  String _countrySelection = '';
  bool _showCountrySelection = false;
  List<Country> _countries = [];

  // The second button
  int _startYear = 1901;
  int _endYear = DateTime.now().year;
  bool _showFirstYearSelection = false;
  bool _showSecondYearSelection = false;


  // The third button

  // Fetch the countries list
  Future<void> _fetchCountries() async {
    final apiService = ApiService.getApi();
    final countryResponse = await apiService.fetchCountries();

    setState(() {
      _countries = countryResponse.countries;
    });
  }

  void resetVariables(){
    setState(() {
      _startYear = 1901;
      _endYear = DateTime.now().year;
      _countrySelection = '';
    });
  }

  @override
  void initState() {
    super.initState();

    // Start the logo animation
    // _logoAnimationController = LottieAnimationController(
    //   vsync: this,
    //   composition: LottieComposition.asset('assets/nobel_prize_logo.json'),
    // );
    // _logoAnimationController!.play();

    // Fetch the countries list
    _fetchCountries();
  }

  @override
  void dispose() {
    //_logoAnimationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noble'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // The logo animation
          //   LottieAnimationView(
          //   controller: _logoAnimationController,
          //   height: 200,
          //   width: 200,
          // ),

          // The first button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showCountrySelection = !_showCountrySelection;
                _showFirstYearSelection = false;
                _showSecondYearSelection = false;
                resetVariables();
              });
            },
            child: const Text('Winners by Country'),
          ),

          // The first button selection list
              if (_showCountrySelection)
                DropdownButton<Country>(
                  value: null,
                  hint: const Text('Select a Country'),
                  items: _countries.map((country) {
                    return DropdownMenuItem<Country>(
                      value: country,
                      child: Row(
                        children: [
                          SvgPicture.asset('lib/assets/flags/${country.code?.toLowerCase()}.svg', width: 24, height: 24),
                          SizedBox(width: 8), // Add spacing between flag and text
                          Text(country.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (country) {
                    setState(() {
                      _countrySelection = country!.name;
                      // Navigate to the winners by country screen
                      Get.toNamed('/winners_by_country/${country.code}', arguments: {
                        'country': country,
                      });
                    });
                  },
                ),

    // The second button
    ElevatedButton(
    onPressed: () {
    setState(() {
    _showFirstYearSelection = !_showFirstYearSelection;
    if(_showSecondYearSelection) {
      _showFirstYearSelection = false;
      _showSecondYearSelection = false;
    }
    _showCountrySelection = false;
    resetVariables();
    });
    },
    child: Text('Winners by Year Range'),
    ),

    // The second button year selection lists
    Column(
    children: [
      if (_showFirstYearSelection )
    DropdownButton<int>(
    value: _startYear,
    hint: const Text('Select Start Year'),
      items: List.generate(DateTime.now().year - 1900 + 1, (index) => 1901 + index)
          .map((year) => DropdownMenuItem<int>(value: year, child: Text(year.toString())))
          .toList(),
      onChanged: (year) {
        setState(() {
          _showSecondYearSelection = true;
          _showFirstYearSelection = false;
          _startYear = year!;
        });
      },
    ),
      if(_showSecondYearSelection)
        DropdownButton<int>(
          value: _endYear,
          hint: Text('Select End Year'),
          items: List.generate(_endYear - _startYear + 1, (index) => _startYear + index)
              .map((year) => DropdownMenuItem<int>(value: year, child: Text(year.toString())))
              .toList(),
          onChanged: (year) {
            setState(() {
              _endYear = year!;
              Get.toNamed('/all_winners_by_year_range/$_startYear/$_endYear', arguments: {
                'startYear': _startYear,
                'endYear': _endYear,
              });
            });
          },
        ),
    ],
    ),

              // The third button
              ElevatedButton(
                onPressed: () {
                  _showCountrySelection = false;
                  _showFirstYearSelection = false;
                  _showSecondYearSelection = false;
                  resetVariables();
                  // Navigate to the all winning countries screen
                  Get.toNamed('/all_winning_countries');
                },
                child: Text('Winning Countries'),
              ),
            ],
          ),
      ),
    );
  }
}

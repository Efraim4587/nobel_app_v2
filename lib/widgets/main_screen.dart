// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// import '../api/api_service.dart';
// import '../types/country.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nobel App',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF1565C0), // Dark blue primary color
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         fontFamily: 'Roboto', // Use a readable font
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late Dio dio;
//   late ApiService apiService;
//   final api = ApiService.getApi();
//
//   bool showCountrySelection = false;
//   bool showYearSelection = false;
//   String selectedCountry = 'Select a country';
//   String? selectedStartYear;
//   String selectedEndYear = 'Select an end year';
//   late List<Country> countries;
//
//   void resetSelections() {
//     setState(() {
//       selectedStartYear = null;
//       selectedEndYear = 'Select an end year';
//       selectedCountry = 'Select a country'; // Set selectedCountry to null as the default value
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     dio = Dio();
//     apiService = ApiService(dio);
//     resetSelections();
//   }
//
//   void toggleCountrySelection() {
//     setState(() {
//       if (showCountrySelection) {
//         // Hide the selection list if it's already shown
//         showCountrySelection = false;
//       } else {
//         showCountrySelection = true;
//         showYearSelection = false;
//         selectedStartYear = null;
//         selectedEndYear = 'Select an end year';
//       }
//     });
//   }
//
//   void toggleYearSelection() {
//     setState(() {
//       if (showYearSelection) {
//         // Hide the selection list if it's already shown
//         showYearSelection = false;
//       } else {
//         showYearSelection = true;
//         showCountrySelection = false;
//         selectedCountry = 'Select a country';
//       }
//     });
//   }
//
//   void hideAllSelection() {
//     setState(() {
//       showCountrySelection = false;
//       showYearSelection = false;
//       resetSelections();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nobel App'),
//         backgroundColor: const Color(0xFF1565C0), // Dark blue app bar
//       ),
//       backgroundColor: Colors.white, // White background
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 150), // Added space
//               Image.asset(
//                 'assets/nobel_prize_logo.png',
//                 width: 100,
//                 height: 100,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Welcome to Nobel App!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Color(0xFF1565C0), // Dark blue text
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: 250,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     hideAllSelection();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => AllWinningCountriesScreen(apiService: apiService,),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: const Color(0xFF1565C0), // White text
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0), // Rounded corners
//                     ),
//                   ),
//                   child: const Text('Winning Countries'),
//                 ),
//               ),
//               SizedBox(
//                 width: 250,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final countriesResponse = await api.fetchCountries();
//                     countries = countriesResponse.countries;
//                     toggleCountrySelection();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: const Color(0xFF1565C0), // White text
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0), // Rounded corners
//                     ),
//                   ),
//                   child: const Text('Winners by Country'),
//                 ),
//               ),
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 500),
//                 height: showCountrySelection ? null : 0,
//                 child: showCountrySelection
//                     ? Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     FutureBuilder<List<Country>>(
//                       future: Future.value(countries),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         } else if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         } else if (!snapshot.hasData ||
//                             snapshot.data!.isEmpty) {
//                           return const Text('No countries available.');
//                         } else {
//                           return DropdownButton<String>(
//                             hint: const Text('Select a country', style: TextStyle(color: Colors.grey)),
//                             value: selectedCountry,
//                             onChanged: (newValue) {
//                               if (newValue != null &&
//                                   newValue != 'Select a country') {
//                                 setState(() {
//                                   selectedCountry = newValue;
//                                 });
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         WinnersByCountryScreen(
//                                           country: selectedCountry,
//                                           apiService: apiService, selectedCountry: '', // Pass ApiService instance
//                                         ),
//                                   ),
//                                 );
//                               }
//                             },
//                             items: [
//                               const DropdownMenuItem<String>(
//                                 value: 'Select a country',
//                                 child: Text('Select a country'),
//                               ),
//                               ...snapshot.data!.map((country) {
//                                 return DropdownMenuItem<String>(
//                                   value: country.name,
//                                   child: Text(country.name),
//                                 );
//                               }).toList(),
//                             ],
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 )
//                     : null,
//               ),
//               Container(
//                 width: 250,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     toggleYearSelection();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: const Color(0xFF1565C0), // Dark blue button
//                     onPrimary: Colors.white, // White text
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0), // Rounded corners
//                     ),
//                   ),
//                   child: const Text('Winners by Year Range'),
//                 ),
//               ),
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 500),
//                 height: showYearSelection ? null : 0,
//                 child: showYearSelection
//                     ? Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     if (!showCountrySelection)
//                       DropdownButton<String>(
//                         hint: const Text('Select a start year', style: TextStyle(color: Colors.grey)),
//                         value: selectedStartYear,
//                         onChanged: (newValue) {
//                           if (newValue != null &&
//                               newValue != 'Select a start year') {
//                             setState(() {
//                               selectedStartYear = newValue;
//                               selectedEndYear = 'Select an end year';
//                             });
//                           }
//                         },
//                         items: [
//                           const DropdownMenuItem<String>(
//                             value: 'Select a start year',
//                             child: Text('Select a start year'),
//                           ),
//                           ...List.generate(
//                             DateTime.now().year - 1900,
//                                 (index) =>
//                                 (DateTime.now().year - index)
//                                     .toString(),
//                           ).map((year) {
//                             return DropdownMenuItem<String>(
//                               value: year,
//                               child: Text(year),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     const SizedBox(height: 20),
//                     if (selectedStartYear != null)
//                       Column(
//                         children: [
//                           DropdownButton<String>(
//                             hint: const Text('Select an end year', style: TextStyle(color: Colors.grey)),
//                             value: selectedEndYear,
//                             onChanged: (newValue) {
//                               if (newValue != null &&
//                                   newValue != 'Select an end year') {
//                                 setState(() {
//                                   selectedEndYear = newValue;
//                                 });
//                                 if (selectedStartYear != null &&
//                                     selectedEndYear !=
//                                         'Select an end year') {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           AllWinnersByYearRangeScreen(
//                                             startYear: int.parse(selectedStartYear!),
//                                             endYear: int.parse(selectedEndYear),
//                                             apiService: apiService, // Pass ApiService instance
//                                           ),
//                                     ),
//                                   );
//                                 }
//                               }
//                             },
//                             items: [
//                               const DropdownMenuItem<String>(
//                                 value: 'Select an end year',
//                                 child: Text('Select an end year'),
//                               ),
//                               ...List.generate(
//                                 DateTime.now().year -
//                                     int.parse(selectedStartYear!) +
//                                     1,
//                                     (index) =>
//                                     (int.parse(selectedStartYear!) +
//                                         index)
//                                         .toString(),
//                               ).map((year) {
//                                 return DropdownMenuItem<String>(
//                                   value: year.toString(),
//                                   child: Text(year.toString()),
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ],
//                       ),
//                   ],
//                 )
//                     : null,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

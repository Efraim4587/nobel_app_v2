import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobel/api/api_service.dart';
import 'package:nobel/types/country.dart';
import 'package:nobel/types/laureate.dart';

class AllWinningCountriesPage extends StatefulWidget {
  const AllWinningCountriesPage({super.key});

  @override
  _AllWinningCountriesPageState createState() => _AllWinningCountriesPageState();
}

class _AllWinningCountriesPageState extends State<AllWinningCountriesPage> {
  List<Laureate> laureates = [];
  List<Country> countries = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLaureatesAndCountries();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchLaureatesAndCountries() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final apiService = ApiService.getApi();
        final laureateResponse = await apiService.fetchLaureates();
        final countryResponse = await apiService.fetchCountries();

        setState(() {
          laureates.addAll(laureateResponse.laureates);
          countries = countryResponse.countries;
          isLoading = false;
        });
      } catch (e) {
        // Handle errors here
        print('Error fetching data: $e');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 500) {
      _fetchLaureatesAndCountries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Winning Countries'),
      ),
      body: ListView.builder(
        itemCount: laureates.length + (isLoading ? 1 : 0),
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < laureates.length) {
            final laureate = laureates[index];
            final countryCode = laureate.bornCountryCode;
            final country = countries.firstWhere(
                  (c) => c.code == countryCode,
              orElse: () => Country(name: 'Unknown', code: countryCode),
            );

            return ListTile(
              leading: SvgPicture.asset(
                'lib/assets/flags/${countryCode?.toLowerCase()}.svg',
                width: 24,
                height: 24,
              ),
              title: Text(laureate.firstname),
              subtitle: Text('Country: ${country.name}'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Year: ${laureate.prizes.first.year}'),
                  Text('Category: ${laureate.prizes.first.category}'),
                ],
              ),
            );
          } else if (isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(); // Placeholder for the loading indicator
          }
        },
      ),
    );
  }
}

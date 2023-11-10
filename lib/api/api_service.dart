import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../types/country.dart';
import '../types/laureate.dart';
import '../types/prize.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://api.nobelprize.org/v1")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService getApi() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    ApiService apiService = ApiService(dio);
    return apiService;
  }

  @GET("/prize.json")
  Future<PrizeResponse> fetchPrizesByYearRange(
      @Query("year") int year,
      @Query("yearTo") int yearTo,
      );

  @GET("/laureate.json")
  Future<LaureateResponse> fetchLaureates();

  @GET("/country.json")
  Future<CountryResponse> fetchCountries();
}

class PrizeResponse {
  final List<Prize> prizes;

  PrizeResponse({required this.prizes});

  factory PrizeResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> prizesList = json['prizes'];

    final prizes = prizesList.map((prizeJson) {
      return Prize.fromJson(prizeJson);
    }).toList();

    return PrizeResponse(prizes: prizes);
  }
}

class LaureateResponse {
  final List<Laureate> laureates;

  LaureateResponse({
    required this.laureates,
  });

  factory LaureateResponse.fromJson(Map<String, dynamic> json) => LaureateResponse(
    laureates: (json['laureates'] as List<dynamic>)
        .map((dynamic laureate) => Laureate.fromJson(laureate))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'laureates': laureates.map((laureate) => laureate.toJson()).toList(),
  };
}


class CountryResponse {
  final List<Country> countries;

  CountryResponse({required this.countries});

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> countriesList = json['countries'];

    final countries = countriesList.map((countryJson) {
      return Country.fromJson(countryJson);
    }).toList();

    return CountryResponse(countries: countries);
  }
}

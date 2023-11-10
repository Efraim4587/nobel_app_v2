import 'dart:convert';

class Laureate {
  Laureate({
    required this.id,
    required this.firstname,
    required this.surname,
    required this.born,
    required this.died,
    required this.bornCountry,
    required this.bornCountryCode,
    required this.bornCity,
    required this.diedCountry,
    required this.diedCountryCode,
    required this.diedCity,
    required this.gender,
    required this.prizes,
  });

  final String id;
  final String firstname;
  final String surname;
  final String born;
  final String died;
  final String bornCountry;
  final String bornCountryCode;
  final String bornCity;
  final String diedCountry;
  final String diedCountryCode;
  final String diedCity;
  final String gender;
  final List<Prize> prizes;

  factory Laureate.fromJson(Map<String, dynamic> json) => Laureate(
    id: json['id'] as String ?? "",
    firstname: json['firstname'] as String ?? "",
    surname: json['surname'] as String ?? "",
    born: json['born'] as String ?? "",
    died: json['died'] as String ?? "",
    bornCountry: json['bornCountry'] as String ?? "",
    bornCountryCode: json['bornCountryCode'] as String ?? "",
    bornCity: json['bornCity'] as String ?? "",
    diedCountry: json['diedCountry'] as String ?? "",
    diedCountryCode: json['diedCountryCode'] as String ?? "",
    diedCity: json['diedCity'] as String ?? "",
    gender: json['gender'] as String ?? "",
    prizes: (json['prizes'] as List<dynamic>  ?? [])
        .map((dynamic prize) => Prize.fromJson(prize))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'surname': surname,
    'born': born,
    'died': died,
    'bornCountry': bornCountry,
    'bornCountryCode': bornCountryCode,
    'bornCity': bornCity,
    'diedCountry': diedCountry,
    'diedCountryCode': diedCountryCode,
    'diedCity': diedCity,
    'gender': gender,
    'prizes': prizes.map((prize) => prize.toJson()).toList(),
  };
}

class Prize {
  Prize({
    required this.year,
    required this.category,
    required this.share,
    required this.motivation,
    required this.affiliations,
  });

  final String year;
  final String category;
  final String share;
  final String motivation;
  final List<Affiliation> affiliations;

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
    year: json['year'] as String ?? "",
    category: json['category'] as String ?? "",
    share: json['share'] as String ?? "",
    motivation: json['motivation'] as String ?? "",
    affiliations: (json['affiliations'] as List<dynamic> ?? [])
        .map((dynamic affiliation) => Affiliation.fromJson(affiliation))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'year': year,
    'category': category,
    'share': share,
    'motivation': motivation,
    'affiliations': affiliations.map((affiliation) => affiliation.toJson()).toList(),
  };
}

class Affiliation {
  Affiliation({
    required this.name,
    required this.city,
    required this.country,
  });

  final String name;
  final String city;
  final String country;

  factory Affiliation.fromJson(Map<String, dynamic> json) => Affiliation(
    name: json['name'] as String ?? "",
    city: json['city'] as String ?? "",
    country: json['country'] as String ?? "",
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'city': city,
    'country': country,
  };
}



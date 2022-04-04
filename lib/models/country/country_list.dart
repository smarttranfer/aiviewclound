import 'country.dart';

class CountryList {
  final List<Country>? coutries;

  CountryList({
    this.coutries,
  });

  factory CountryList.fromJson(List<dynamic> json) {
    List<Country> coutries = <Country>[];
    coutries = json.map((country) => Country.fromJson(country)).toList();

    return CountryList(
      coutries: coutries,
    );
  }
}

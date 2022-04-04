import "package:equatable/equatable.dart";
import "package:mobx/mobx.dart";

class Country extends Equatable {
  final String? code;
  final String? name;
  final String? fullName;
  final String? iso3;
  final int? number;
  final String? continentCode;
  final dynamic areaCode;

  @observable
  final bool selected;

  const Country(
      {this.code,
      this.name,
      this.fullName,
      this.iso3,
      this.number,
      this.continentCode,
      this.areaCode,
      this.selected = false});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      code: json["Code"] as String?,
      name: json["Name"] as String?,
      fullName: json["FullName"] as String?,
      iso3: json["Iso3"] as String?,
      number: json["Number"] as int?,
      continentCode: json["Continent_Code"] as String?,
      areaCode: json["AreaCode"],
      selected: false);

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Name": name,
        "FullName": fullName,
        "Iso3": iso3,
        "Number": number,
        "Continent_Code": continentCode,
        "AreaCode": areaCode,
      };

  Country copyWith({
    String? code,
    String? name,
    String? fullName,
    String? iso3,
    int? number,
    String? continentCode,
    dynamic areaCode,
  }) {
    return Country(
      code: code ?? this.code,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      iso3: iso3 ?? this.iso3,
      number: number ?? this.number,
      continentCode: continentCode ?? this.continentCode,
      areaCode: areaCode ?? this.areaCode,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      code,
      name,
      fullName,
      iso3,
      number,
      continentCode,
      areaCode,
    ];
  }
}

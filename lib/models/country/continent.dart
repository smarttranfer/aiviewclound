import 'package:equatable/equatable.dart';
import 'package:mobx/mobx.dart';

class Contient extends Equatable {
  final String code;
  final String nameEn;
  late final String nameVi;

  @observable
  bool expanded;

  Contient(
      {required this.code,
      required this.nameEn,
      required this.nameVi,
      this.expanded = false});

  factory Contient.fromJson(Map<String, dynamic> json) => Contient(
        code: json['Code'] as String,
        nameEn: json['Name_en'] as String,
        nameVi: json['Name_vi'] as String,
        expanded: json['expanded'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'Code': code,
        'Name_en': nameEn,
        'Name_vi': nameVi,
        'expanded': expanded
      };

  Contient copyWith(
      {String? code, String? nameEn, String? nameVi, bool? expanded}) {
    return Contient(
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameVi: nameVi ?? this.nameVi,
      expanded: expanded ?? this.expanded,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [code, nameEn, nameVi, expanded];
}

import 'package:aiviewcloud/models/country/continent.dart';
import 'package:mobx/mobx.dart';

class ContientList {
  @observable
  final ObservableList<Contient>? continents;

  ContientList({
    this.continents,
  });

  factory ContientList.fromJson(List<dynamic> json) {
    ObservableList<Contient> continents = <Contient>[].asObservable();
    continents = ObservableList<Contient>.of(
        json.map((country) => Contient.fromJson(country)).toList());

    return ContientList(
      continents: continents,
    );
  }
}

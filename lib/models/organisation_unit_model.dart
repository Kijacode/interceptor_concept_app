class Dhis2OrganisationUnit {
  String? id;
  String? name;

  Dhis2OrganisationUnit({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  Dhis2OrganisationUnit.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
  }

  factory Dhis2OrganisationUnit.fromJson(
    dynamic json,
  ) {
    return Dhis2OrganisationUnit(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return '<$id : $name>';
  }
}
class Region {
  Region(
      {required this.regionId,
      this.regionCode,
      required this.regionName,
      required this.level,
      required this.parentId,
      this.description,
      this.active,
      this.ownerByUserId,
      required this.objectGuid,
      this.childRegion = const []});

  int regionId;
  String? regionCode;
  String regionName;
  int? level;
  int? parentId;
  String? description;
  bool? active;
  int? ownerByUserId;
  String objectGuid;
  List<Region> childRegion;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionId: json["RegionId"] as int,
        regionCode: json["RegionCode"] as String?,
        regionName: json["RegionName"] as String,
        level: json["Level"] as int?,
        parentId: json["ParentId"] as int?,
        description: json["Description"] as String?,
        active: json["Active"] as bool?,
        ownerByUserId: json["OwnerByUserId"] as int?,
        objectGuid: json["ObjectGuid"] as String,
      );

  Map<String, dynamic> toJson() => {
        "RegionId": regionId,
        "RegionCode": regionCode,
        "RegionName": regionName,
        "Level": level,
        "ParentId": parentId,
        "Description": description,
        "Active": active,
        "OwnerByUserId": ownerByUserId,
        "ObjectGuid": objectGuid,
      };
}

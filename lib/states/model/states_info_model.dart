import 'dart:convert';

List<StateInfoModel> statesInfoModelFromJson(String str) =>
    List<StateInfoModel>.from(
        json.decode(str).map((x) => StateInfoModel.fromJson(x)));

class StateInfoModel {
  String state;
  String notes;
  String covid19Site;
  String? covid19SiteSecondary;
  String? covid19SiteTertiary;
  String? covid19SiteQuaternary;
  String? covid19SiteQuinary;
  String? twitter;
  String covid19SiteOld;
  String covidTrackingProjectPreferredTotalTestUnits;
  String covidTrackingProjectPreferredTotalTestField;
  String totalTestResultsField;
  String pui;
  bool pum;
  String name;
  String fips;

  StateInfoModel({
    required this.state,
    required this.notes,
    required this.covid19Site,
    required this.covid19SiteSecondary,
    required this.covid19SiteTertiary,
    required this.covid19SiteQuaternary,
    required this.covid19SiteQuinary,
    required this.twitter,
    required this.covid19SiteOld,
    required this.covidTrackingProjectPreferredTotalTestUnits,
    required this.covidTrackingProjectPreferredTotalTestField,
    required this.totalTestResultsField,
    required this.pui,
    required this.pum,
    required this.name,
    required this.fips,
  });

  factory StateInfoModel.fromJson(Map<String, dynamic> json) => StateInfoModel(
        state: json["state"],
        notes: json["notes"],
        covid19Site: json["covid19Site"],
        covid19SiteSecondary: json["covid19SiteSecondary"],
        covid19SiteTertiary: json["covid19SiteTertiary"],
        covid19SiteQuaternary: json["covid19SiteQuaternary"],
        covid19SiteQuinary: json["covid19SiteQuinary"],
        twitter: json["twitter"],
        covid19SiteOld: json["covid19SiteOld"],
        covidTrackingProjectPreferredTotalTestUnits:
            json["covidTrackingProjectPreferredTotalTestUnits"],
        covidTrackingProjectPreferredTotalTestField:
            json["covidTrackingProjectPreferredTotalTestField"],
        totalTestResultsField: json["totalTestResultsField"],
        pui: json["pui"],
        pum: json["pum"],
        name: json["name"],
        fips: json["fips"],
      );
}

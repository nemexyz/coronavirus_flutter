import 'dart:convert';

List<StateCurrentModel> statesCurrentModelFromJson(String str) =>
    List<StateCurrentModel>.from(
        json.decode(str).map((x) => StateCurrentModel.fromJson(x)));

class StateCurrentModel {
  int date;
  String state;
  int positive;
  int? probableCases;
  int? negative;
  int? pending;
  String totalTestResultsSource;
  int totalTestResults;
  int? hospitalizedCurrently;
  int? hospitalizedCumulative;
  int? inIcuCurrently;
  int? inIcuCumulative;
  int? onVentilatorCurrently;
  int? onVentilatorCumulative;
  int? recovered;
  String? lastUpdateEt;
  DateTime? dateModified;
  String? checkTimeEt;
  int death;
  int? hospitalized;
  int? hospitalizedDischarged;
  DateTime? dateChecked;
  int? totalTestsViral;
  int? positiveTestsViral;
  int? negativeTestsViral;
  int? positiveCasesViral;
  int? deathConfirmed;
  int? deathProbable;
  int? totalTestEncountersViral;
  int? totalTestsPeopleViral;
  int? totalTestsAntibody;
  int? positiveTestsAntibody;
  int? negativeTestsAntibody;
  int? totalTestsPeopleAntibody;
  int? positiveTestsPeopleAntibody;
  int? negativeTestsPeopleAntibody;
  int? totalTestsPeopleAntigen;
  int? positiveTestsPeopleAntigen;
  int? totalTestsAntigen;
  int? positiveTestsAntigen;
  String fips;
  int positiveIncrease;
  int negativeIncrease;
  int total;
  int totalTestResultsIncrease;
  int posNeg;
  dynamic dataQualityGrade;
  int deathIncrease;
  int hospitalizedIncrease;
  String hash;
  int commercialScore;
  int negativeRegularScore;
  int negativeScore;
  int positiveScore;
  int score;
  String grade;

  StateCurrentModel({
    required this.date,
    required this.state,
    required this.positive,
    required this.probableCases,
    required this.negative,
    required this.pending,
    required this.totalTestResultsSource,
    required this.totalTestResults,
    required this.hospitalizedCurrently,
    required this.hospitalizedCumulative,
    required this.inIcuCurrently,
    required this.inIcuCumulative,
    required this.onVentilatorCurrently,
    required this.onVentilatorCumulative,
    required this.recovered,
    required this.lastUpdateEt,
    required this.dateModified,
    required this.checkTimeEt,
    required this.death,
    required this.hospitalized,
    required this.hospitalizedDischarged,
    required this.dateChecked,
    required this.totalTestsViral,
    required this.positiveTestsViral,
    required this.negativeTestsViral,
    required this.positiveCasesViral,
    required this.deathConfirmed,
    required this.deathProbable,
    required this.totalTestEncountersViral,
    required this.totalTestsPeopleViral,
    required this.totalTestsAntibody,
    required this.positiveTestsAntibody,
    required this.negativeTestsAntibody,
    required this.totalTestsPeopleAntibody,
    required this.positiveTestsPeopleAntibody,
    required this.negativeTestsPeopleAntibody,
    required this.totalTestsPeopleAntigen,
    required this.positiveTestsPeopleAntigen,
    required this.totalTestsAntigen,
    required this.positiveTestsAntigen,
    required this.fips,
    required this.positiveIncrease,
    required this.negativeIncrease,
    required this.total,
    required this.totalTestResultsIncrease,
    required this.posNeg,
    required this.dataQualityGrade,
    required this.deathIncrease,
    required this.hospitalizedIncrease,
    required this.hash,
    required this.commercialScore,
    required this.negativeRegularScore,
    required this.negativeScore,
    required this.positiveScore,
    required this.score,
    required this.grade,
  });

  factory StateCurrentModel.fromJson(Map<String, dynamic> json) =>
      StateCurrentModel(
        date: json["date"],
        state: json["state"],
        positive: json["positive"],
        probableCases: json["probableCases"],
        negative: json["negative"],
        pending: json["pending"],
        totalTestResultsSource: json["totalTestResultsSource"],
        totalTestResults: json["totalTestResults"],
        hospitalizedCurrently: json["hospitalizedCurrently"],
        hospitalizedCumulative: json["hospitalizedCumulative"],
        inIcuCurrently: json["inIcuCurrently"],
        inIcuCumulative: json["inIcuCumulative"],
        onVentilatorCurrently: json["onVentilatorCurrently"],
        onVentilatorCumulative: json["onVentilatorCumulative"],
        recovered: json["recovered"],
        lastUpdateEt: json["lastUpdateEt"],
        dateModified: json["dateModified"] == null
            ? null
            : DateTime.parse(json["dateModified"]),
        checkTimeEt: json["checkTimeEt"],
        death: json["death"],
        hospitalized: json["hospitalized"],
        hospitalizedDischarged: json["hospitalizedDischarged"],
        dateChecked: json["dateChecked"] == null
            ? null
            : DateTime.parse(json["dateChecked"]),
        totalTestsViral: json["totalTestsViral"],
        positiveTestsViral: json["positiveTestsViral"],
        negativeTestsViral: json["negativeTestsViral"],
        positiveCasesViral: json["positiveCasesViral"],
        deathConfirmed: json["deathConfirmed"],
        deathProbable: json["deathProbable"],
        totalTestEncountersViral: json["totalTestEncountersViral"],
        totalTestsPeopleViral: json["totalTestsPeopleViral"],
        totalTestsAntibody: json["totalTestsAntibody"],
        positiveTestsAntibody: json["positiveTestsAntibody"],
        negativeTestsAntibody: json["negativeTestsAntibody"],
        totalTestsPeopleAntibody: json["totalTestsPeopleAntibody"],
        positiveTestsPeopleAntibody: json["positiveTestsPeopleAntibody"],
        negativeTestsPeopleAntibody: json["negativeTestsPeopleAntibody"],
        totalTestsPeopleAntigen: json["totalTestsPeopleAntigen"],
        positiveTestsPeopleAntigen: json["positiveTestsPeopleAntigen"],
        totalTestsAntigen: json["totalTestsAntigen"],
        positiveTestsAntigen: json["positiveTestsAntigen"],
        fips: json["fips"],
        positiveIncrease: json["positiveIncrease"],
        negativeIncrease: json["negativeIncrease"],
        total: json["total"],
        totalTestResultsIncrease: json["totalTestResultsIncrease"],
        posNeg: json["posNeg"],
        dataQualityGrade: json["dataQualityGrade"],
        deathIncrease: json["deathIncrease"],
        hospitalizedIncrease: json["hospitalizedIncrease"],
        hash: json["hash"],
        commercialScore: json["commercialScore"],
        negativeRegularScore: json["negativeRegularScore"],
        negativeScore: json["negativeScore"],
        positiveScore: json["positiveScore"],
        score: json["score"],
        grade: json["grade"],
      );
}
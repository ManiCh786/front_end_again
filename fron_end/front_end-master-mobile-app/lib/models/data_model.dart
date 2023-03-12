class DataModel {
  int questionNumber;
  String assessmentType;
  String bloomTaxonomyLevel;
  int ploId;
  String objective;

  DataModel({
    required this.questionNumber,
    required this.assessmentType,
    required this.bloomTaxonomyLevel,
    required this.ploId,
    required this.objective,
  });

  Map<String, dynamic> toJson() => {
        "questionNumber": questionNumber,
        "assessmentType": assessmentType,
        "bloomTaxonomyLevel": bloomTaxonomyLevel,
        "ploId": ploId,
        "objective": objective,
      };
}

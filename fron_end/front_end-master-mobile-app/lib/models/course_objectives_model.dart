class CourseObjectivesModel {
  int? obId;
  int? objId;
  int? quiz;
  int? assignment;
  int? presentation;
  int? project;
  String? courseName;
  String? objName;
  String? outcome;
  int? courseId;
  int? addedBy;
  String? outcomeBtLevel;
  int? objWeightage;
  String? createdAt;
  String? updatedAt;
  CourseObjectivesModel({
    this.objId,
    this.quiz,
    this.assignment,
    this.presentation,
    this.project,
    this.courseName,
    this.objName,
    this.outcome,
    this.courseId,
    this.addedBy,
    this.outcomeBtLevel,
    this.objWeightage,
    this.createdAt,
    this.updatedAt,
  });
  CourseObjectivesModel.fromJson(Map<String, dynamic> json) {
    quiz = json["quiz"];
    assignment = json["assignment"];
    presentation = json["presentation"];
    project = json["project"];
    courseName = json["courseName"];
    objId = json["objId"];
    objName = json["objName"];
    outcome = json["outcome"];
    courseId = json["courseId"];
    addedBy = json["added_by"];
    outcomeBtLevel = json["outcomeBtLevel"];
    objWeightage = json['weightage'];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() => {
        "quiz": quiz,
        "assignment": assignment,
        "presentation": presentation,
        "project": project,
        "courseName": courseName,
        "objId": objId,
        "objName": objName,
        "outcome": outcome,
        "outcomeBtLevel": outcomeBtLevel,
        "courseId": courseId,
        "added_by": addedBy,
        "objWeightage": objWeightage,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

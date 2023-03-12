class CoursesModel {
  int? courseId;
  String? courseName;
  String? courseCode;
  String? courseCrHr;
  String? courseDesc;
  String? createdAt;
  String? updatedAt;
  int? ciId;
  int? instructorUserId;
  int? assignedBy;
  int? semester;
  String? session;
  String? department;
  String? fName;
  String? lName;
  int? userId;

  CoursesModel({
    this.courseId,
    this.courseName,
    this.courseCode,
    this.courseCrHr,
    this.courseDesc,
    this.createdAt,
    this.updatedAt,
    this.ciId,
    this.instructorUserId,
    this.assignedBy,
    this.semester,
    this.session,
    this.department,
    this.fName,
    this.lName,
    this.userId,
  });

  CoursesModel.fromJson(Map<String, dynamic> json) {
    courseId = json["courseId"];
    courseName = json["courseName"];
    courseCode = json["courseCode"];
    courseCrHr = json["courseCrHr"];
    courseDesc = json["courseDesc"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    ciId = json["ciId"];
    instructorUserId = json["userId"];
    assignedBy = json["assigned_by"];
    semester = json["semester"];
    session = json["session"];
    department = json["department"];
    fName = json["fName"];
    lName = json["lName"];
    userId = json["userId"];
  }
  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "courseCode": courseCode,
        "courseCrHr": courseCrHr,
        "courseDesc": courseDesc,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "ciId": ciId,
        "userId": instructorUserId,
        "assigned_by": assignedBy,
        "semester": semester,
        "session": session,
        "department": department,
      };
}
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['courseId'] = courseId;
  //   data['courseName'] = courseName;
  //   data['courseName'] = courseCode;
  //
  //   data['courseCrHr'] = courseCrHr;
  //   data['courseDesc'] = courseDesc;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   "courseId": courseId,
  //   "courseName": courseName,
  //   "courseCode": courseCode,
  //   "courseCrHr": courseCrHr,
  //   "courseDesc": courseDesc,
  //   "created_at": createdAt.toIso8601String(),
  //   "updated_at": updatedAt.toIso8601String(),
  //   "ciId": ciId,
  //   "instructor_userId": instructorUserId,
  //   "assigned_by": assignedBy,
  //   "semester": semester,
  //   "department": department,
  //   return data;
  // }



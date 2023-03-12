class EnrolledStudentsModel {
  int? eId;
  int? userId;
  int? courseId;
  String? session;
  int? enrolledBy;
  String? createdAt;
  String? updatedAt;
  int? regId;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? password;
  int? roleId;
  String? addedBy;
  String? registeredAt;
  String? courseName;
  String? courseCode;
  String? courseCrHr;
  String? courseDesc;
  String? startDate;
  String? endDate;

  EnrolledStudentsModel(
      {this.eId,
      this.userId,
      this.courseId,
      this.session,
      this.enrolledBy,
      this.createdAt,
      this.updatedAt,
      this.regId,
      this.fName,
      this.lName,
      this.email,
      this.phone,
      this.password,
      this.roleId,
      this.addedBy,
      this.registeredAt,
      this.courseName,
      this.courseCode,
      this.courseCrHr,
      this.courseDesc,
      this.startDate,
      this.endDate
      });

  EnrolledStudentsModel.fromJson(Map<String, dynamic> json) {
    eId = json['eId'];
    userId = json['userId'];
    courseId = json['courseId'];
    session = json['session'];
    enrolledBy = json['enrolled_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    regId = json['regId'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['roleId'];
    addedBy = json['added_by'];
    registeredAt = json['registered_at'];
    courseName = json['courseName'];
    courseCode = json['courseCode'];
    courseCrHr = json['courseCrHr'];
    courseDesc = json['courseDesc'];
    startDate = json['startDate'];
    endDate = json['completionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eId'] = this.eId;
    data['userId'] = this.userId;
    data['courseId'] = this.courseId;
    data['session'] = this.session;
    data['enrolled_by'] = this.enrolledBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['regId'] = this.regId;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['roleId'] = this.roleId;
    data['added_by'] = this.addedBy;
    data['registered_at'] = this.registeredAt;
    data['courseName'] = this.courseName;
    data['courseCode'] = this.courseCode;
    data['courseCrHr'] = this.courseCrHr;
    data['courseDesc'] = this.courseDesc;
    data['startDate'] = this.startDate;
    data['completionDate'] = this.endDate;
    return data;
  }
}

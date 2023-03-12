class AssessmentsMarksModel {
  int? userId;
  int? regId;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? password;
  int? roleId;
  int? addedBy;
  Null? emailVerifiedAt;
  Null? rememberToken;
  String? registeredAt;
  String? createdAt;
  String? updatedAt;
  int? asId;
  int? outlineId;
  String? assessmentType;
  String? assFileName;
  int? assAddedBy;
  String? senttoHod;
  int? asMarksId;
  int? assessmentId;
  int? qno;
  int? obtmarks;
  int? totalMarks;
  String? objName;
  int? studentId;
  int? lecNo;
  int? weekNo;
  String? session;
  String? subject;
  String? fileName;
  String? relatedTopic;
  String? objectives;
  String? btLevel;
  int? outlineAddedBy;
  String? approved;
  int? approvedBy;

  AssessmentsMarksModel(
      {this.userId,
      this.regId,
      this.fName,
      this.lName,
      this.email,
      this.phone,
      this.password,
      this.roleId,
      this.addedBy,
      this.emailVerifiedAt,
      this.rememberToken,
      this.registeredAt,
      this.createdAt,
      this.updatedAt,
      this.asId,
      this.outlineId,
      this.assessmentType,
      this.assFileName,
      this.assAddedBy,
      this.senttoHod,
      this.asMarksId,
      this.assessmentId,
      this.qno,
      this.obtmarks,
      this.totalMarks,
      this.objName,
      this.studentId,
      this.lecNo,
      this.weekNo,
      this.session,
      this.subject,
      this.fileName,
      this.relatedTopic,
      this.objectives,
      this.btLevel,
      this.outlineAddedBy,
      this.approved,
      this.approvedBy});

  AssessmentsMarksModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    regId = json['regId'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['roleId'];
    addedBy = json['added_by'];
    emailVerifiedAt = json['email_verified_at'];
    rememberToken = json['remember_token'];
    registeredAt = json['registered_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    asId = json['asId'];
    outlineId = json['outlineId'];
    assessmentType = json['assessmentType'];
    assFileName = json['assFileName'];
    assAddedBy = json['ass_added_by'];
    senttoHod = json['senttoHod'];
    asMarksId = json['as_marks_id'];
    assessmentId = json['assessment_id'];
    qno = json['qno'];
    obtmarks = json['obtmarks'];
    totalMarks = json['total_marks'];
    objName = json['objName'];
    studentId = json['student_id'];
    lecNo = json['lecNo'];
    weekNo = json['weekNo'];
    session = json['session'];
    subject = json['subject'];
    fileName = json['fileName'];
    relatedTopic = json['relatedTopic'];
    objectives = json['objectives'];
    btLevel = json['btLevel'];
    outlineAddedBy = json['outline_added_by'];
    approved = json['approved'];
    approvedBy = json['approved_by'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['regId'] = this.regId;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['roleId'] = this.roleId;
    data['added_by'] = this.addedBy;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['registered_at'] = this.registeredAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['asId'] = this.asId;
    data['outlineId'] = this.outlineId;
    data['assessmentType'] = this.assessmentType;
    data['assFileName'] = this.assFileName;
    data['ass_added_by'] = this.assAddedBy;
    data['senttoHod'] = this.senttoHod;
    data['as_marks_id'] = this.asMarksId;
    data['assessment_id'] = this.assessmentId;
    data['qno'] = this.qno;
    data['obtmarks'] = this.obtmarks;
    data['total_marks'] = this.totalMarks;
    data['objName'] = this.objName;
    data['student_id'] = this.studentId;
    data['lecNo'] = this.lecNo;
    data['weekNo'] = this.weekNo;
    data['session'] = this.session;
    data['subject'] = this.subject;
    data['fileName'] = this.fileName;
    data['relatedTopic'] = this.relatedTopic;
    data['objectives'] = this.objectives;
    data['btLevel'] = this.btLevel;
    data['outline_added_by'] = this.outlineAddedBy;
    data['approved'] = this.approved;
    data['approved_by'] = this.approvedBy;
    return data;
  }
}

// class AssessmentsMarksModel {
//   int? userId;
//   int? regId;
//   String? fName;
//   String? lName;
//   String? email;
//   String? phone;
//   String? password;
//   int? roleId;
//   int? addedBy;
//   String? registeredAt;
//   String? createdAt;
//   String? updatedAt;
//   int? asId;
//   int? outlineId;
//   String? assessmentType;
//   String? assFileName;
//   int? assAddedBy;
//   int? asMarksId;
//   int? assessmentId;
//   int? qno;
//   int? obtmarks;
//   String? objName;
//   int? totalMarks;
//   int? studentId;

//   AssessmentsMarksModel(
//       {this.userId,
//       this.regId,
//       this.fName,
//       this.lName,
//       this.email,
//       this.phone,
//       this.password,
//       this.roleId,
//       this.addedBy,
//       this.registeredAt,
//       this.createdAt,
//       this.updatedAt,
//       this.asId,
//       this.outlineId,
//       this.assessmentType,
//       this.assFileName,
//       this.assAddedBy,
//       this.asMarksId,
//       this.assessmentId,
//       this.qno,
//       this.obtmarks,
//       this.objName,
//       this.totalMarks,
//       this.studentId});

//   AssessmentsMarksModel.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     regId = json['regId'];
//     fName = json['fName'];
//     lName = json['lName'];
//     email = json['email'];
//     phone = json['phone'];
//     password = json['password'];
//     roleId = json['roleId'];
//     addedBy = json['added_by'];
//     registeredAt = json['registered_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     asId = json['asId'];
//     outlineId = json['outlineId'];
//     assessmentType = json['assessmentType'];
//     assFileName = json['assFileName'];
//     assAddedBy = json['ass_added_by'];
//     asMarksId = json['as_marks_id'];
//     assessmentId = json['assessment_id'];
//     qno = json['qno'];
//     obtmarks = json['obtmarks'];
//     objName = json['objName'];
//     totalMarks = json['total_marks'];
//     studentId = json['student_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userId'] = userId;
//     data['regId'] = regId;
//     data['fName'] = fName;
//     data['lName'] = lName;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['password'] = password;
//     data['roleId'] = roleId;
//     data['added_by'] = addedBy;
//     data['registered_at'] = registeredAt;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['asId'] = asId;
//     data['outlineId'] = outlineId;
//     data['assessmentType'] = assessmentType;
//     data['assFileName'] = assFileName;
//     data['ass_added_by'] = assAddedBy;
//     data['as_marks_id'] = asMarksId;
//     data['assessment_id'] = assessmentId;
//     data['qno'] = qno;
//     data['obtmarks'] = obtmarks;
//     data['objName'] = objName;
//     data['total_marks'] = totalMarks;
//     data['student_id'] = studentId;
//     return data;
//   }
// }

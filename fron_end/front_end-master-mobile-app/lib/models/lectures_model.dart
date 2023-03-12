class LecturesModel {
  int? outlineId;
  int? weeks;
  int? lectNo;
  String? session;
  int? addedBy;
  String? subject;
  String? file;
  String? file1;
  String? file2;
  String? file3;
  String? file4;

  String? relatedTopic;
  String? btLevel;
  String? courseObj;
  String? approved;
  int? approved_by;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? regId;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  LecturesModel({
    this.outlineId,
    this.weeks,
    this.lectNo,
    this.session,
    this.addedBy,
    this.subject,
    this.file,
    this.file1,
    this.file2,
    this.file3,
    this.file4,
    this.relatedTopic,
    this.btLevel,
    this.courseObj,
    this.approved,
    this.approved_by,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.regId,
    this.fName,
    this.lName,
    this.email,
    this.phone,
  });

  LecturesModel.fromJson(Map<String, dynamic> json) {
    outlineId = json['outlineId'];
    weeks = json['weekNo'];
    lectNo = json['lecNo'];
    session = json['session'];
    addedBy = json['outline_added_by'];
    subject = json['subject'];
    file = json['fileName'];
    file1 = json['fileName1'];
    file2 = json['fileName2'];
    file3 = json['fileName3'];
    file4 = json['fileName4'];

    relatedTopic = json['relatedTopic'];
    btLevel = json['btLevel'];
    approved = json['approved'];
    approved_by = json['approved_by'];

    courseObj = json['objectives'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['userId'];
    regId = json['regId'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['outlineId'] = outlineId;
    data['weeks'] = weeks;
    data['outlineId'] = outlineId;
    data['lectNo'] = lectNo;
    data['session'] = session;
    // data['outline_added_by'] = addedBy;
    data['subject'] = subject;
    data['file'] = file;
    data['file1'] = file1;
    data['file2'] = file2;
    data['file3'] = file3;
    data['file4'] = file4;

    data['relatedTopic'] = relatedTopic;
    data['btLevel'] = btLevel;
    data['approved'] = approved;
    data['approved_by'] = approved_by;
    data['courseObj'] = courseObj;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['userId'] = userId;
    data['regId'] = regId;
    data['fName'] = fName;
    data['lName'] = lName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

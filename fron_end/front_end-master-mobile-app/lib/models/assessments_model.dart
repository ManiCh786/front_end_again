class AssessmentsModel {
  int? asId;
  int? outlineId;
  String? assessmentType;
  String? assFileName;
  int? assAddedBy;
  String? senttoHod;
  String? createdAt;
  String? updatedAt;
  int? lecNo;
  int? weekNo;
  String? session;
  String? subject;
  String? fileName;
  String? relatedTopic;
  String? btLevel;
  int? outlineAddedBy;

  AssessmentsModel(
      {this.asId,
      this.outlineId,
      this.assessmentType,
      this.assFileName,
      this.senttoHod,
      this.assAddedBy,
      this.createdAt,
      this.updatedAt,
      this.lecNo,
      this.weekNo,
      this.session,
      this.subject,
      this.fileName,
      this.relatedTopic,
      this.btLevel,
      this.outlineAddedBy});

  AssessmentsModel.fromJson(Map<String, dynamic> json) {
    asId = json['asId'];
    outlineId = json['outlineId'];
    assessmentType = json['assessmentType'];
    assFileName = json['assFileName'];
    assAddedBy = json['ass_added_by'];
    senttoHod = json['senttoHod'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lecNo = json['lecNo'];
    weekNo = json['weekNo'];
    session = json['session'];
    subject = json['subject'];
    fileName = json['fileName'];
    relatedTopic = json['relatedTopic'];
    btLevel = json['btLevel'];
    outlineAddedBy = json['outline_added_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asId'] = asId;
    data['outlineId'] = outlineId;
    data['assessmentType'] = assessmentType;
    data['assFileName'] = assFileName;
    data['ass_added_by'] = assAddedBy;
    data['senttoHod'] = senttoHod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['lecNo'] = lecNo;
    data['weekNo'] = weekNo;
    data['session'] = session;
    data['subject'] = subject;
    data['fileName'] = fileName;
    data['relatedTopic'] = relatedTopic;
    data['btLevel'] = btLevel;
    data['outline_added_by'] = outlineAddedBy;
    return data;
  }
}

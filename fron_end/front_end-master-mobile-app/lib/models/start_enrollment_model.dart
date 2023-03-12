class StartEnrollmentModel {
  int? seId;
  String? session;
  String? startDate;
  String? endDate;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? regId;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? password;
  int? roleId;
  String? registeredAt;
  String? roleName;
  String? roleDesc;

  StartEnrollmentModel(
      {this.seId,
      this.session,
      this.startDate,
      this.endDate,
      this.addedBy,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.regId,
      this.fName,
      this.lName,
      this.email,
      this.phone,
      this.password,
      this.roleId,
      this.registeredAt,
      this.roleName,
      this.roleDesc});

  StartEnrollmentModel.fromJson(Map<String, dynamic> json) {
    seId = json['seId'];
    session = json['session'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['userId'];
    regId = json['regId'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    roleId = json['roleId'];
    ;
    registeredAt = json['registered_at'];
    roleName = json['roleName'];
    roleDesc = json['roleDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seId'] = seId;
    data['session'] = session;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['added_by'] = addedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['userId'] = userId;
    data['regId'] = regId;
    data['fName'] = fName;
    data['lName'] = lName;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['roleId'] = roleId;
    data['registered_at'] = registeredAt;
    data['roleName'] = roleName;
    data['roleDesc'] = roleDesc;
    return data;
  }
}

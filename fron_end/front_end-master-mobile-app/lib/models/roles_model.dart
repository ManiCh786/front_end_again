class RolesModel {
  int? roleId;
  String? roleName;
  String? roleDesc;
  String? createdAt;
  String? updatedAt;

  RolesModel({
    this.roleId,
    this.roleName,
    this.roleDesc,
    this.createdAt,
    this.updatedAt,
  });

  RolesModel.fromJson(Map<String, dynamic> json) {
    roleId= json['roleId'];
    roleName= json['roleName'];
    roleDesc= json['roleDesc'];
    createdAt= json['created_at'];
    updatedAt= json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleId'] = roleId;
    data['roleName'] = roleName;
    data['roleDesc'] = roleDesc;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

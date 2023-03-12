
class RegistrationModel{
  int? regId;
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? password;
  String? createdAt;
  String? updatedAt;
  RegistrationModel({
    this.regId,
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.password,
    this.createdAt,
    this.updatedAt,
});
  RegistrationModel.fromJson(Map<String, dynamic> json){
    regId = json['regId'];
    fName = json['fName'];
    lName = json['lName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }
  Map<String,dynamic> toJson(){
   final Map<String,dynamic> data = <String,dynamic>{};
    data['regId'] = regId;
    data['fName'] = fName;
     data['lName']= lName;
     data['email']=email;
     data['phone']=phone;
     data['password']=password;
     data['created_at']=createdAt;
     data['updated_at']=updatedAt;
     return data;
  }
}
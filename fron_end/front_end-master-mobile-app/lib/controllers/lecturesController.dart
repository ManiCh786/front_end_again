// addNewLecture
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../data/repository/lectures_repo.dart';
import '../models/models.dart';

import '../utils/utils.dart';
import 'controller.dart';

class LecturesController extends GetxController {
  LecturesController({
    required this.lecRepo,
  });
  List<String> assesmentOptions = [
    "Quiz",
    "Assignment",
    "Viva",
    "Presentation",
    "Mid Term",
    "Final Term",
    "Other"
  ];
  final LecturesRepo lecRepo;
  bool _isLoading = false;
  RxList<dynamic> _myLecturesOutline = <dynamic>[].obs;

  RxList<LecturesModel> _myLecturesOutlineObx = RxList<LecturesModel>();
  get isLoading => _isLoading;

  final _fileName = ("Select a File (.pdf or .docx)").obs;
  String get fileName => _fileName.value;
  set fileName(String newValue) => _fileName.value = newValue;
  // actual FIle to be Uploaded

  List<dynamic> get myLecturesOutline => _myLecturesOutline;
  RxList<LecturesModel> get myLecturesOutlineObx => _myLecturesOutlineObx;

  // DropDowns
  // Weeks Drop Down variables start
  String _weekDropDownPlaceholder = "1";
  get weekDropDownPlaceholder => _weekDropDownPlaceholder;
  set weekDropDownPlaceholder(value) {
    _weekDropDownPlaceholder = value;
    update();
  }

  String selectedWeek = "1";
  setWeek(String value) {
    selectedWeek = value;
  }
  // Weeks Drop Down variables Ends
// Lecture 1or2 DropDown Starts

  String _lecDropDownPlaceholder = "1";
  get lecDropDownPlaceholder => _lecDropDownPlaceholder;
  set lecDropDownPlaceholder(value) {
    _lecDropDownPlaceholder = value;
    update();
  }

  String selectedLec = "1";
  setLec(String value) {
    selectedLec = value;
  }
// Lecture 1or2 DropDown Ends
// Assessments Drop DownStart

  var _selectAssessmentObsPlaceholder = ("Select Assessment Level").obs;
  String get selectAssessmentObsPlaceholder =>
      _selectAssessmentObsPlaceholder.value;
  set setselectAssessmentObsPlaceholder(String newValue) {
    _selectAssessmentObsPlaceholder.value = newValue;
    update();
  }

  List<String> selectedValuesForAssessmentDropDown = List.filled(7, "Quiz");

  String getSelectedDropDownValue(int i) {
    return selectedValuesForAssessmentDropDown[i];
  }

  void setSelectedValues(index, newValue) {
    selectedValuesForAssessmentDropDown[index] = newValue;
    update();
  }

// Assessment DropDown End
  downloadFileFromUrl(url) {
    //Perfect for viewing a pdf  file
    AnchorElement anchorElement = new AnchorElement(href: url);
    // anchorElement.download = "Flutter Logo";
    anchorElement.download = url;
    anchorElement.click();
  }

  downloadOutlineFile(String fileName,int currentUserId) async {
    // final currentUserId = Get.find<UserAuthController>().getUserId();

    _isLoading = true;
    update();
    final response = await lecRepo.getMyOutlineFile(fileName, currentUserId);
    if (response.statusCode == 200) {
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }
  // void downloadPdfVersionInfinity(String fileName) async {
  //   final url =
  //       "http://127.0.0.1:8000/api/routes/users/lectures/downloadOutlineFile/";
  //   http
  //       .post(Uri.parse(url),
  //           headers: {
  //             'Content-type': 'application/json',
  //             'Authorization':
  //                 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODZjZjc4ODljMjFiZTUwZTI3YmUyM2U0YWM1NWMzZTExMWMyNTY0YmExN2I2OWE1NjRlODc0ZWFjYjkyNWM5MmVmZjJiMTA1YWYxYjk4OWEiLCJpYXQiOjE2NzQ5OTMzMjIuNDU3ODQ2LCJuYmYiOjE2NzQ5OTMzMjIuNDU3ODUxLCJleHAiOjE3MDY1MjkzMjIuMTcyNzUxLCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.jaUhlZTb4U8Pa80CYb4ab6HOVm-RJ0O4bGoXerxu7ionMlQwF6Q0LZPznmU84DkQRSoV6r5SrueVh0hv5UDm-PHtsoDgYW0QiV3QB85fdWZNAlgD1Pm21MWhLPYd4oVvFrWMp8bsEI4L1Ud6oqR8R2vhBpmmMNzmHnULbVLgFfaXxnNqLRVSi42peBhbK0MLYsOdBdPO9UEx2gTecKwZKQikL4tTmwcrDXctlRMFMYxdMdqazb9RP4Enb_7wd_vNTJdbUprBJS5NDvcuMsXgUSXvqvIXgkzbK9PjBmU2_SPAiSYu5cR8JXz6ZltrPXI3ndmSECawwMqn-ZDZcAT1D8eKyKN2t89jrybRj7fMr9SlimoRGE6b8nZrefSIvUJMIhZmES8-MR7gA0DFwdxI8FKSUdECbRO37CsKBmEBRIqSsQ5Xio4gNYpUZQ2ke5K80-vyYVJV9gPnIl6566TkBDVQeHukcDjMdS84frzGfewlkfIfdROB-saDgZReQnPDoLrtUFBt71pCY9p3ABvHmmbmCnbsETtytffcOFpOxhxF3pUSgBJVdtVNJCBsd_2yIJfwqazmluD0Emg88EAubSBiaKeX6DmtacWg-PetbpMsGKv-9yYzOYRCVv_RNi9P8W0cmXNmY1qCEFYH8USnl3M892kBXHsoFqNGB_iRU64',
  //           },
  //           body: json.encode(
  //             {"fileName": fileName},
  //           ))
  //       .then((response) async {
  //     final blob = Blob([response.bodyBytes]);
  //     final url = Url.createObjectUrl(blob);
  //     final link = AnchorElement(href: url)..setAttribute('download', fileName);
  //     link.click();
  //     Url.revokeObjectUrl(url);
  //   });
  // }

  // void downloadPdfVersion(String fileName) async {
  //   var data = {'fileName': fileName};
  //   final response = await lecRepo.getMyOutlineFile(data);
  //   print(response.statusCode);
  //   // if (response.statusCode == 200) {
  //   //   // var file = json.decode(response.body);
  //   //   // Uint8List compressed = base64.decode(response.body);
  //   // print(response.body['file']);
  //   //   print(response.body['message']);
  //   // } else {
  //   //   print(response.body['success']);
  //   //   print(response.body['message']);
  //   // }
  //   // print("response.body");
  //   // print(response.statusCode);

  //   // final convertToBytes = await convertToList(response.bodyBytes!);
  //   // final blob = Blob([response.bodyBytes]);
  //   // final url = Url.createObjectUrl(blob);
  //   // final link = AnchorElement(href: url)..setAttribute('download', fileName);
  //   // link.click();
  //   // Url.revokeObjectUrl(url);
  // }

  Future<void> getMyLecturesOutline(String yearFilter) async {
    // int year = 2023;
    try {
      _isLoading = true;
      update();
      Response response = await lecRepo.getMyLecturesOutline();
      if (response.body != null) {
        final responseBody = response.body;
        _myLecturesOutlineObx = RxList<LecturesModel>();
        final RxList<dynamic> list = [].obs;
        list.addAll(responseBody.map((e) => LecturesModel.fromJson(e)));
        _myLecturesOutline = list
            // .where((e) =>
            //     e.createdAt.toString().toLowerCase().contains(year.toString()))
            .toList()
            .obs;
        _isLoading = false;
        update();
      }
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
      // Get.back();
      // Get.back();
      print(e);
    }
  }

  Future<void> getMyLecturesOutlineStream() async {
    try {
      _isLoading = true;
      update();
      Response response = await lecRepo.getMyLecturesOutline();
      if (response.statusCode == 200) {
        final responseBody = response.body;
        _myLecturesOutlineObx = RxList<LecturesModel>();
        _myLecturesOutlineObx.addAll((responseBody as List)
            .map((e) => LecturesModel.fromJson(e))
            .toList());
        _isLoading = false;
        update();
      }
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();

      Get.back();
      Get.back();
    }
  }

  Future<ResponseModel> uploadNewLecFile(lecDocFile) async {
    _isLoading = true;
    update();
    Response response = await lecRepo.uploadNewLecFile(lecDocFile);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateLectureOutline(LecturesModel lecInfo) async {
    _isLoading = true;
    update();
    Response response = await lecRepo.updateLectureOutline(lecInfo);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> approveOrRejectOutline(LecturesModel lecInfo) async {
    _isLoading = true;
    update();
    Response response = await lecRepo.approveOrRejectOutline(lecInfo);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> uploadFileRecToDB(LecturesModel lecInfo) async {
    _isLoading = true;
    update();
    Response response = await lecRepo.uploadFileRecToDB(lecInfo);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> uploadMoreLecFile(LecturesModel lecInfo) async {
    _isLoading = true;
    update();
    Response response = await lecRepo.uploadMoreLecFile(lecInfo);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(
          response.body['success'], response.body['message'].toString());
    } else {
      responseModel = ResponseModel(false, "OOPS! Server Error Occurred ");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}

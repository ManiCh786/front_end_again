class AppConstants {
  static const String APP_NAME = "FYP";
  static const int APP_VERSION = 1;
  // http://127.0.0.1:8000/api/getRoles

  static const String BASE_URL = "http://127.0.0.1:8000/api/";
  //User Registration

  static const String REGISTER_NEW_USER = "routes/registration/registerNewUser";
  static const String GET_REGISTERD_USERS = "routes/users/getRegisterdUsers";
  static const String DELETE_REG_USER = "routes/users/deleteRegUser";
  static const String ASSIGN_ROLE_TO_REG_USER =
      "routes/users/assignRoletoRegUser";
  static const String GET_LOGGED_IN_USER_INFO =
      "routes/users/getLoggedInUserInfo";
  static const String GET_USERS_INFO = "routes/users/getVerifiedUsers";
  static const String GET_FACULTY_MEMBERS_URL =
      "routes/users/getFacultyMembers";
  //USer Auth
  static const String USER_LOGIN = "routes/registration/login";
  static const String VERIFY_EMAIL = "routes/registration/email/verify-email";

  //Roles
  // static const String GET_ROLES_URL = "routes/roles/getRoles";
  static const String GET_ROLES_URL = "routes/users/roles/getRoles";
  static const String ADD_ROLES_URL = "routes/users/roles/addRoles";
  static const String DELETE_ROLE_URL = "routes/users/roles/deleteTheRole";

  //Courses
  static const String ADD_COURSE_URL = "routes/users/courses/addCourse";
  static const String GET_MY_COURSES_URL = "routes/users/courses/getMyCourses";
  static const String GET_ALL_COURSES_URL = "routes/users/courses/allCourses";
  static const String GET_ALL_ASSIGNED_COURSES_URL =
      "routes/users/courses/allAssignedCourses";
  static const String ASSIGN_COURSE_TO_INSTRUCTOR =
      "routes/users/courses/assignCourse";

  //Objectives
  static const String GET_COURSE_OBJECTIVES =
      "routes/users/courses/getCourseObjectives";
  static const String ADD_COURSE_OBJECTIVES =
      "routes/users/courses/addCourseObjectives";
  static const String ADD_OBJECTIVE_BREAKDOWN =
      "routes/users/courses/addBreakdownStructure";
// OutCOmes
  static const String ADD_COURSE_OUTCOMES =
      "routes/users/courses/addCourseOutcomes";
// Lectures
  static const String ADD_NEW_LECTURE_FILE_TO_SERVER =
      "routes/users/lectures/uploadNewLecFileToServer";
  static const String ADD_NEW_LECTURE_INFO_TO_DB =
      "routes/users/lectures/uploadFileRecordToDatabase";
  static const String UPLOAD_MORE_LEC_FILE =
      "routes/users/lectures/uploadMoreLecFile";
  static const String APPROVE_OR_REJECT_OUTLINE =
      "routes/users/lectures/approveOrRejectOutline";
  static const String UPDATE_OUTLINE_FILE =
      "routes/users/lectures/updateLectureOutline";

  static const String GET_MY_LECTURE_OUTLINE =
      "routes/users/lectures/getCourseOutline";
  static const String DOWNLOAD_MY_OUTLINE =
      "routes/users/lectures/downloadOutlineFile/";
// Assessments
  static const String GET_ASSESSMENTS_URI =
      "routes/users/assessments/getAssessments";
  static const String ADD_NEW_ASSESSMENTS_INFO_TO_DB =
      "routes/users/assessments/addAssessmentsToDatabase";

  static const String ADD_NEW_ASSESSMENTS_FILE_TO_SERVER =
      "routes/users/assessments/uploadAssessmentFiletoServer";
  static const String GET_ASSESSMENTS_FILE =
      "routes/users/assessments/downloadAssessmentsFile";
  static const String SEND_RESULT_TO_HOD =
      "routes/users/assessments/sendResultToHod";
  static const String ASSESSMENT_BREAKDOWN_STRUCTURE =
      "routes/users/assessments/addAssessmentBreakdown";

// Enrollments
  static const String GET_ENROLLED_STUDENTS =
      "routes/users/enrolledstudents/getAllEnrolledStudents";
  static const String ENROLL_NEW_STUDENT =
      "routes/users/enrolledstudents/enrollNewCourse";
// Assessments Gradesget
  static const String ADD_ASSESSMENTS_GRADES =
      "routes/users/assessmentsMarks/addAssessmentMarks";
  static const String GET_ASSESSMENTS_GRADES =
      "routes/users/assessmentsMarks/getAssessmentsMarks";
  static const String GET_EVERYINFOWITHMARKS =
      "routes/users/assessmentsMarks/getEveryInfoWithMarks";
  static const String GET_ACCOMPLISHED_OBJECTIVES =
      "routes/users/assessmentsMarks/getAccomplishedObjectives";

// Start Enrollment Schedules
  static const String ADD_NEW_ENROLLMENT_SCHEDULE =
      "routes/users/startenrollment/addNewStartEnrollmentSchedule";
  static const String UPDATE_ENROLLMENT_SCHEDULE =
      "routes/users/startenrollment/updateStartEnrollmentSchedule";
  static const String GET_ENROLLMENT_SCHEDULES =
      "routes/users/startenrollment/getAllStartEnrollments";

  static const String TOKEN = "AppToken";
  static const String USER_EMAIL = "USER EMAIL";
  static const String ACCOUNT_TYPE = "ACCOUNT TYPE";
  static const int USER_ID = 1;
}

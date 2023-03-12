import 'package:get/get.dart';
import '../bindings/bindings.dart';
import '../middlewares/middlwares.dart';
import '../screens/admin/screens/main/main_screen.dart';
import '../screens/hod/hod panel/dashbaord/screens/hoddashboard.dart';
import '../screens/hod/logged_in_user_info.dart';
import '../screens/screens.dart';
import '../screens/student/dashboard/screens/dashboard.dart';
import '../screens/student/dashboard/screens/view_course_desc_screen.dart';
import '../screens/student/dashboard/screens/view_grades_screen.dart';

var routes = [
  //homePage
  GetPage(name: "/", page: () => CheckAuth(), bindings: [UserAuthBinding()]),
  //user auth
  GetPage(
      name: "/authMenu",
      page: () => SignupLoginMenu(),
      bindings: [UserAuthBinding(), RegistrationBinding()]),
  GetPage(
      name: "/signup",
      page: () => SignupLoginMenu(),
      bindings: [UserAuthBinding(), RegistrationBinding()]),
  GetPage(
      name: "/login",
      page: () => SignupLoginMenu(),
      bindings: [UserAuthBinding(), RegistrationBinding()]),

  //Registered Users
  // GetPage(name: "/viewAllRegisteredUsers", page: ()=>ViewAllRegisteredUsers(),bindings: [RegistrationBinding(),RolesBinding()]),
  // dashboards
  GetPage(name: "/adminDashboard", page: () => MainScreen(), middlewares: [
    AdminMiddleWare()
  ], bindings: [
    UserAuthBinding(),
    RegistrationBinding(),
    RolesBinding(),
    CourseBinding(),
  ], children: [
    //UsersViewCourseDescriptionScreen
    GetPage(
        name: "/viewAllRegisteredUsers",
        page: () => ViewAllRegisteredUsers(),
        bindings: [RegistrationBinding(), RolesBinding()]),

    GetPage(
      name: "/loggedInUserInfo",
      page: () => LoggedInUserInfo(),
    ),
    // Roles
    GetPage(
        name: "/viewRoles",
        page: () => ViewRoles(),
        bindings: [RolesBinding()]),
    GetPage(
        name: "/addRole", page: () => AddRole(), bindings: [RolesBinding()]),
    //courses
    GetPage(
        name: "/addCourses",
        page: () => AddCourses(),
        bindings: [CourseBinding()]),
    GetPage(
        name: "/assignCourse",
        page: () => AssignCourseToInstructor(),
        bindings: [RegistrationBinding(), CourseBinding(), UserAuthBinding()]),
    GetPage(
        name: "/assignedCourses",
        page: () => ViewAssignedCourses(),
        bindings: [RegistrationBinding(), CourseBinding(), UserAuthBinding()])
  ]),
  GetPage(name: "/studentDashboard", page: () => StudentDashboard(), bindings: [
    UserAuthBinding(),
    StudentsBindings(),
  ], middlewares: [
    UserMiddleWare()
  ], children: [
    GetPage(
      bindings: [
        StudentsBindings(),
      ],
      name: "/viewCourseDescriptionScreen",
      page: () => ViewCourseDescriptionScreen(),
    ),
    GetPage(
      
      bindings: [UserAuthBinding(), StudentsBindings(),],
      name: "/grades",
      page:()=> CourseGrade(),
    ),
    GetPage(
      name: "/loggedInUserInfo",
      page: () => LoggedInUserInfo(),
    ),
  ]),
  GetPage(name: "/HOD_Dashboard", page: () => HodDashboard(), bindings: [
    UserAuthBinding(),StudentsBindings(),
  ], middlewares: [
    HodMiddleware()
  ], children: [
    GetPage(
      name: "/loggedInUserInfo",
      page: () => HodLoggedInUserInfo(),
    ),
  ]),
  GetPage(
      name: "/faculty-dashboard",
      page: () => FacultyDashboard(),
      bindings: [
        UserAuthBinding(),
        CourseBinding(),
        ObjectiveScreenBindings(),
      ],
      middlewares: [
        FacultyMiddleWare()
      ],
      children: [
        GetPage(
            name: "/objectivesMenu",
            page: () {
              return ObjectivesMenu();
            },
            bindings: [
              CourseBinding(),
            ]),
        GetPage(
          name: "/loggedInUserInfo",
          page: () => LoggedInUserInfo(),
        ),
      ]),
  //user Roles
];

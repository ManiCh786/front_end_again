import 'package:flutter/material.dart';
import 'package:front_end/routes/routes.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // builder: ((context, child) => ResponsiveWrapper.builder(
      //       BouncingScrollWrapper.builder(context, child!),
      //       maxWidth: 1400,
      //       minWidth: 600,
      //       defaultScale: true,
      //       breakpoints: [
      //         const ResponsiveBreakpoint.resize(600, name: MOBILE),
      //         const ResponsiveBreakpoint.resize(800, name: TABLET),
      //         const ResponsiveBreakpoint.resize(1000, name: TABLET),
      //         const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
      //         const ResponsiveBreakpoint.resize(2460, name: "4K"),
      //       ],
      //     )),
      
      getPages: routes,
      debugShowCheckedModeBanner: false,
      title: 'OBL ',
      initialRoute: "/",
      // initialRoute: "/adminDashboard",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/controller.dart';
import '../../constants.dart';
import '../../responsive.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);
  final scaffoldStateController =
      Get.put<ScaffoldController>(ScaffoldController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: scaffoldStateController.controlMenu,
          ),
        if (!Responsive.isMobile(context))
          const Text(
            "OBL DASHBOARD",
            style: TextStyle(
                color: Colors.deepPurple,
                fontFamily: 'Poppins',
                fontSize: 25,
                fontWeight: FontWeight.bold),
            // style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);
  final userController = Get.find<UserAuthController>();
  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<UserAuthController>().isUserLoggedIn();
    return GetBuilder<UserAuthController>(initState: (_) {
      Future.delayed(Duration.zero).then((value) {
        if (userLoggedIn) {
          Get.find<UserAuthController>().getLoggedInUserInfo();
          // Future.delayed(Duration.zero).then((value) => Get.find<UserAuthController>().getLoggedInUserInfo(),);
        } else {
          Get.offAllNamed("authMenu");
        }
      });
    }, builder: (controller) {
      return controller.loggedInUserInfo.fName.toString().isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(left: defaultPadding),
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  // Image.asset(
                  //   "assets/images/profile_pic.png",
                  //   height: 38,
                  // ),
                  if (!Responsive.isMobile(context))
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        // child: Text(controller.loggedInUserInfo.userId.toString()!.isEmpty ? "" : controller.loggedInUserInfo.fName.toString()!),),
                        child: controller.loggedInUserInfo.userId
                                .toString()
                                .isEmpty
                            ? Text("")
                            : RichText(
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
                                softWrap: true,
                                maxLines: 1,
                                textScaleFactor: 1,
                                text: TextSpan(
                                  text: controller.loggedInUserInfo.fName
                                          .toString()
                                          .isEmpty
                                      ? "User"
                                      : controller.loggedInUserInfo.fName
                                          .toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                  children: <TextSpan>[
                                    // TextSpan(
                                    // text: controller.loggedInUserInfo.lName!.toString().isEmpty  ? "Name" : controller.loggedInUserInfo.lName.toString()  ,
                                    //  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )),

                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: Colors.black,
                  ),
                ],
              ),
            );
    });
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            // child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}

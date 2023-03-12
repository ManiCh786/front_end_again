import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import 'auth_screens.dart';

class SignupLoginMenu extends StatelessWidget {
  const SignupLoginMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.deepPurple,
            // extendBodyBehindAppBar: true,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0.0,
            //   centerTitle: true,
            //   title: const Text(
            //     'OBL System',
            //     style: TextStyle(fontFamily: 'Dongle', fontSize: 38),
            //   ),
            // ),
            body: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:32.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width*0.35,
                        height: MediaQuery.of(context).size.height*0.9,
                        decoration:  BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(10,),
                        boxShadow: [
                          BoxShadow(
                          color: Colors.amber.shade300, //New
                          blurRadius: 25.0,
                          offset: Offset(0, -1))
                          ],
                            ),
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:32.0),
                              child: Container(
                                height: 145,
                                width: 145,
                                  decoration:  BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/uoc.jpg'),
                                  fit: BoxFit.contain),
                              ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:25.0),
                              child: Container(
                                height: 60,
                                width: 370,
                                decoration:  BoxDecoration(
                                  color: Colors.amber.shade300,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: const TabBar(
                                  indicator: BoxDecoration(
                                    color: Colors.deepPurple,
                                  ),
                                  labelColor: Colors.white,
                                   unselectedLabelColor: Colors.black,
                                   tabs: [
                                     UserTypeRegisterTab(
                                    title: 'Log In', icn: Icons.login),
                                    UserTypeRegisterTab(
                                         title: 'Sign Up', icn: Icons.app_registration),
                                   ],
                                ),
                              ),
                            ),
                            Expanded(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 35.0),
                               child: TabBarView(children: [
                                 Login(),
                                 SignUp(),
                               ]),
                             ),
                           ),
                          ],
                        )
                        //  Column(children: [
                           // Container(
                           //   height: 70,
                           //   width: 420,
                             // decoration: const BoxDecoration(
                             //   color: Colors.white,
                             // ),
                             // child:  const TabBar(
                             //     indicator:  BoxDecoration(
                             //       color: Colors.amber,
                             //     ),
                             //     labelColor: Colors.white,
                             //     unselectedLabelColor: Colors.black,
                             //     tabs: [
                             //       UserTypeRegisterTab(
                             //           title: 'Log In', icn: Icons.login),
                             //       UserTypeRegisterTab(
                             //           title: 'Sign Up', icn: Icons.app_registration),
                             //     ]),
                                 
                           // ),
                           // Expanded(
                           //   child: Padding(
                           //     padding: const EdgeInsets.only(top: 35.0),
                           //     child: TabBarView(children: [
                           //       Login(),
                           //       SignUp(),
                           //     ]),
                           //   ),
                           // ),
                        //  ])
                        ),
                  ),
                ),
              ],
            )
                )
                );
  }
}


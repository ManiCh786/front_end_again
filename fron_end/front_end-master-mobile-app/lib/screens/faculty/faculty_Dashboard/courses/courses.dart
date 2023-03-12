import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import '/controllers/controller.dart';
import 'package:get/get.dart';

class CoursesTab extends StatelessWidget {
  CoursesTab({
    Key? key,
  }) : super(key: key);
  final _itemsYear = List<DateTime>.generate(
      10,
      (i) => DateTime.utc(
            DateTime.now().year - i,
          ).add(Duration(days: i)));
  final List<String> _session = ["Fall", "Spring", "Summer"];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursesController>(initState: (_) async {
      Future.delayed(Duration.zero).then(
        (value) => Get.find<CoursesController>().getMyCourses(),
      );
    }, builder: (courseController) {
      return courseController.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.amber,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        GetBuilder<CoursesController>(
                            builder: (courseController) {
                          return Container(
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.5)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  courseController.yearFilterDropDownPlaceholder,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 16),
                                ),
                                value: courseController.yearFilter.value,
                                items: _itemsYear.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.year.toString(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:14.0),
                                      child: Text(
                                        value.year.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    onTap: () {
                                      courseController
                                              .yearFilterDropDownPlaceholder =
                                          value.year.toString();
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  courseController.yearFilter.value =
                                      value!.toString().toLowerCase();
                                  courseController.getMyCourses();
                                },
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          width: 50,
                        ),
                        GetBuilder<CoursesController>(
                            builder: (courseController) {
                          return Container(
                             height: 40,
                            width: 160,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1.5)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  courseController.sessionFilterDropDownPlaceholder,
                                  style: const TextStyle(
                                      color: Colors.black, fontFamily: 'Poppins'),
                                ),
                                value: courseController
                                    .sessionFilter.value.capitalizeFirst,
                                dropdownColor: Colors.white,
                                items: _session.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:14.0),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    onTap: () {
                                      courseController
                                          .sessionFilterDropDownPlaceholder = value;
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  courseController.sessionFilter.value =
                                      value!.toLowerCase();
                                  courseController.getMyCourses();
                                  // print(courseController.sessionFilter.value);
                                },
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          width: 70,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => courseController.myCourses.isNotEmpty
                        ? Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 300,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemCount: courseController.myCourses.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // var subject = courseController.myCourses[index];
                                      final courseId = courseController
                                          .myCourses[index].courseId;
                                      final course =
                                          courseController.myCourses[index];

                                      // var args = {'courses':subject};
                                      Map<String, String> param = {
                                        'courseId': courseId.toString()
                                      };

                                      Get.toNamed(
                                        '/faculty-dashboard/objectivesMenu',
                                        parameters: param,
                                      );

                                      // var args = {'courses': subject};
                                      // subject != null
                                      //     ? Get.toNamed('/faculty-dashboard/objectivesMenu',
                                      //     arguments: args )
                                      //     : Get.snackbar("Subject Name is Empty",
                                      //     "Subject Name is Required ");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:18.0),
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: BlurryContainer(
                                         color: Colors.deepPurple.withOpacity(0.8),
                                         blur: 6,
                                         elevation: 18,
                                         borderRadius: BorderRadius.circular(8),
                                         child: Column(
                                           crossAxisAlignment:
                                               CrossAxisAlignment.center,
                                           children: [
                                           const Icon(Icons.school,color: Colors.white,size: 60,),
                                             Padding(
                                               padding: const EdgeInsets.only(top:8.0),
                                               child: Text(
                                                 courseController
                                                     .myCourses[index].courseName,
                                                 style: const TextStyle(
                                                     fontFamily: 'Poppins',
                                                     fontWeight: FontWeight.bold,
                                                     color: Colors.white,
                                                     fontSize: 20),
                                               ),
                                             ),
                                            const SizedBox(height: 10,),
                                             Text(
                                               "Department:  ${courseController.myCourses[index].department}",
                                               style: const TextStyle(
                                                   color: Colors.black,
                                                   fontFamily: 'Poppins',
                                                   fontSize: 18),
                                             ),
                                             Text(
                                               "Semester:  ${courseController.myCourses[index].semester.toString()}",
                                               style: const TextStyle(
                                                   color: Colors.black,
                                                   fontFamily: 'Poppins',
                                                   fontSize: 18),
                                             ),
                                           ],
                                         ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: Text(
                                "No Course Assigned to You !",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                    color: Colors.black, fontSize: 22),
                              ),
                            ),
                          ),
                  ),
                ],
              ));
    });
  }
}

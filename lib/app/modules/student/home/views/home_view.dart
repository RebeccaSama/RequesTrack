import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/common/contest_admin_template.dart';
import 'package:request_track/app/common/contest_reject.dart';
import 'package:request_track/app/common/contest_result_template.dart';
import 'package:request_track/app/common/contest_template.dart';
import 'package:blur/blur.dart';
import 'package:request_track/app/common/contest_treatment_template.dart';
import 'package:request_track/app/models/user.dart';
import 'package:request_track/app/modules/chief_department/widgets/contest_assignment_department.dart';
import 'package:request_track/app/modules/chief_department/widgets/contest_treatment_department.dart';
import 'package:request_track/app/modules/chief_department/widgets/contest_verify_department.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/home/controllers/home_controller.dart';
import 'package:request_track/app/modules/student/home/widgets/drawer_tile.dart';
import 'package:request_track/app/modules/student/home/widgets/header.dart';
import 'package:request_track/app/modules/student/home/widgets/state_request.dart';
import 'package:request_track/app/modules/student/home/widgets/welcome.dart';
import 'package:request_track/app/modules/student/request_list/views/request_list_view.dart';
import 'package:request_track/app/utils/init_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tuple/tuple.dart';

class HomeView extends StatefulWidget {
  final String name, email;

  const HomeView({Key? key, required this.name, required this.email})
      : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();
  var controller = Get.put(HomeController());

  var tabs = [
    const Tuple3("Tableau de bord", Icons.home, false),
    const Tuple3("Requêtes en 2021-2022", Icons.copy_sharp, true),
    const Tuple3("Notifications", Icons.notifications, true),
    const Tuple3("Profil utilisateur", Icons.person, false),
  ];

  int? selectedIndex;

  late SharedPreferences prefs;

  var preferences = Get.find<InitPreferences>().prefs;

  @override
  void initState() {
    super.initState();

    initializePreferences();
  }

  void initializePreferences() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString("theme") != null) {
      Get.changeThemeMode(prefs.getString("theme") == "light"
          ? ThemeMode.light
          : ThemeMode.dark);
    }

    print("We are in dark mode: ${Get.isDarkMode}");

    controller.light.value = prefs.getString("theme") == "light";
  }

  @override
  Widget build(BuildContext context) {
    controller.light.value = !Get.isDarkMode;

    return Obx(() => WillPopScope(
          onWillPop: () async {
            if (controller.drawerVisible.value) {
              controller.drawerVisible.value = false;
              controller.enableScroll.value = controller.enableScroll.value ==
                      const AlwaysScrollableScrollPhysics()
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics();

              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    physics: controller.enableScroll.value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Header(
                            controller: scrollController,
                            email: widget.email,
                            name: widget.name,
                          ),
                          const SizedBox(height: 24),
                          User.fromJson(preferences.getString("user") ?? "")
                                      .role ==
                                  Role.STUDENT
                              ? const Welcome()
                              : const SizedBox(),
                          const SizedBox(
                            height: 26,
                          ),
                          const StateRequest(),
                          const SizedBox(
                            height: 32,
                          ),
                          FutureBuilder<dynamic>(
                              future: dio
                                  .get(startApi + "request",
                                      options: Options(headers: {
                                        "Authorization":
                                            "Bearer ${Get.find<InitPreferences>().prefs.getString("token")}"
                                      }))
                                  .then((value) {
                                controller.listRequest.value =
                                    List.from(value.data).reversed.toList();

                                return List.from(value.data).reversed.toList();
                              }).catchError((e) {
                                print(e);
                              }),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Obx(() => ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        if (User.fromJson(preferences
                                                        .getString("user") ??
                                                    "")
                                                .role ==
                                            Role.STUDENT) {
                                          switch (controller.listRequest
                                              .value[index]["status"]) {
                                            case RequestStatus.DRAFT:
                                              return ContestTemplate(
                                                save: false,
                                                snapshot: controller
                                                    .listRequest.value[index],
                                              );
                                            case RequestStatus.SUBMITTED:
                                              return ContestTemplate(
                                                snapshot: controller
                                                    .listRequest.value[index],
                                              );
                                            case RequestStatus.REJECTED:
                                              return ContestReject(
                                                snapshot: controller
                                                    .listRequest.value[index],
                                              );
                                            case RequestStatus
                                                .TREATMENT_PENDING:
                                              return ContestTreatmentTemplate(
                                                status: RequestStatus
                                                    .TREATMENT_IN_PROGRESS,
                                                snapshot: controller
                                                    .listRequest.value[index],
                                              );
                                            case RequestStatus
                                                .TREATMENT_ASSIGNED:
                                              return ContestTreatmentTemplate(
                                                status: RequestStatus
                                                    .TREATMENT_IN_PROGRESS,
                                                snapshot: controller
                                                    .listRequest.value[index],
                                                color: const Color(0xff4285F4),
                                              );
                                            case RequestStatus
                                                .TREATMENT_AT_VERIFY:
                                              return ContestTreatmentTemplate(
                                                status: RequestStatus
                                                    .TREATMENT_IN_PROGRESS,
                                                snapshot: controller
                                                    .listRequest.value[index],
                                                color: const Color(0xff42E9F4),
                                              );
                                            case RequestStatus
                                                .DELIBERATION_PENDING:
                                              return ContestTreatmentTemplate(
                                                status: RequestStatus
                                                    .DELIBERATION_PENDING,
                                                snapshot: controller
                                                    .listRequest.value[index],
                                                color: const Color(0xffFBBC05),
                                              );
                                            case RequestStatus
                                                .PUBLISHING_PENDING:
                                              return ContestTreatmentTemplate(
                                                status: RequestStatus
                                                    .PUBLISHING_PENDING,
                                                snapshot: controller
                                                    .listRequest.value[index],
                                                color: const Color(0xffACFB05),
                                              );
                                            case RequestStatus
                                                .PUBLISHING_AND_FAIL:
                                              return ContestResultTemplate(
                                                snapshot: controller
                                                    .listRequest.value[index],
                                              );
                                            case RequestStatus
                                                .PUBLISHING_AND_SUCCESS:
                                              return ContestResultTemplate(
                                                snapshot: controller
                                                    .listRequest.value[index],
                                              );
                                            default:
                                              return const SizedBox();
                                          }
                                        } else if (User.fromJson(
                                                        preferences.getString(
                                                                "user") ??
                                                            "")
                                                    .role ==
                                                Role.SECRETARY &&
                                            controller.listRequest.value[index]
                                                    ["status"] ==
                                                RequestStatus.SUBMITTED) {
                                          return ContestAdminTemplate(
                                            id: index,
                                            snapshot: controller
                                                .listRequest.value[index],
                                          );
                                        } else if (User.fromJson(preferences
                                                        .getString("user") ??
                                                    "")
                                                .role ==
                                            Role.HEAD_OF_DEPARTMENT) {
                                          switch (controller.listRequest
                                              .value[index]["status"]) {
                                            case RequestStatus
                                                .TREATMENT_PENDING:
                                              return ContestTreatmentDepartment(
                                                id: index,
                                              );
                                            case RequestStatus
                                                .TREATMENT_AT_VERIFY:
                                              return const ContestVerifyDepartment();
                                            case RequestStatus
                                                .TREATMENT_ASSIGNED:
                                              return const ContestAssignmentDepartment();
                                            default:
                                              return const SizedBox();
                                          }
                                        } else if (User.fromJson(
                                                        preferences.getString(
                                                                "user") ??
                                                            "")
                                                    .role ==
                                                Role.TEACHER) {
                                          return const ContestAssignmentDepartment();
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                      separatorBuilder: (context, _) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      itemCount:
                                          controller.listRequest.value.length));
                                } else {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, _) =>
                                          SkeletonAvatar(
                                            style: SkeletonAvatarStyle(
                                                width: double.infinity,
                                                height: 100,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),
                                      separatorBuilder: (context, _) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: 5);
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => RequestListView()));
                            },
                            child: Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xffA709AA))),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("Voir toutes mes requêtes",
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: const Color(0xffA709AA),
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.east,
                                        color: Color(0xffA709AA),
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                      top: 57,
                      left: controller.drawerVisible.value
                          ? 0
                          : MediaQuery.of(context).size.width,
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height -
                            57 -
                            MediaQuery.of(context).padding.top,
                      ).blurred(
                          blur: 4,
                          blurColor: controller.light.value
                              ? Colors.white
                              : Colors.black,
                          colorOpacity: 0.85,
                          overlay: Padding(
                            padding: const EdgeInsets.only(
                                top: 32, left: 16, right: 16, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, _) =>
                                      const SizedBox(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (index == 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      RequestListView()));
                                        }
                                      },
                                      child: DrawerTile(
                                        selected: selectedIndex == index,
                                        title: tabs[index].item1,
                                        icon: tabs[index].item2,
                                        visibleTrailing: tabs[index].item3,
                                      ),
                                    );
                                  },
                                  itemCount: tabs.length,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.settings),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      Text(
                                        "Configurations",
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 30,
                                  color: Colors.black.withOpacity(0.72),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.help_outline,
                                        color: Colors.black26,
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      Text(
                                        "Changer le thème",
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: Colors.black26,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ToggleSwitch(
                                    minWidth: 90.0,
                                    cornerRadius: 20.0,
                                    initialLabelIndex:
                                        controller.light.value ? 0 : 1,
                                    activeBgColors: const [
                                      [Color(0xff979797)],
                                      [Color(0xff979797)]
                                    ],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: const Color(0xffEEEEEE),
                                    inactiveFgColor: Colors.black,
                                    totalSwitches: 2,
                                    icons: const [
                                      Icons.sunny,
                                      Icons.nightlight_outlined
                                    ],
                                    customTextStyles: [
                                      GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: controller.light.value
                                              ? Colors.white
                                              : Colors.black),
                                      GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: controller.light.value
                                              ? Colors.black
                                              : Colors.white)
                                    ],
                                    labels: const ['Light', 'Dark'],
                                    radiusStyle: true,
                                    onToggle: (index) {
                                      index != 0
                                          ? controller.light.value = false
                                          : controller.light.value = true;

                                      Get.changeThemeMode(
                                        controller.light.value
                                            ? ThemeMode.light
                                            : ThemeMode.dark,
                                      );

                                      print(
                                          "We are in dark mode: ${Get.isDarkMode}");

                                      prefs.setString(
                                          "theme",
                                          controller.light.value
                                              ? "light"
                                              : "dark");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )))
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';
import 'package:request_track/app/models/claim.dart';
import 'package:request_track/app/models/course.dart';
import 'package:request_track/app/models/student.dart';
import 'package:request_track/app/models/user.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/add_request/widgets/implement_file.dart';
import 'package:request_track/app/modules/student/add_request/widgets/info_student.dart';
import 'package:request_track/app/modules/student/add_request/widgets/reason_request.dart';
import 'package:request_track/app/modules/student/add_request/widgets/supporting_document.dart';
import 'package:request_track/app/modules/student/home/controllers/home_controller.dart';
import 'package:request_track/app/utils/init_preferences.dart';

class AddRequestView extends StatefulWidget {
  @override
  State<AddRequestView> createState() => _AddRequestViewState();
}

class _AddRequestViewState extends State<AddRequestView> {
  Claim? claim;
  Course? course;

  String? claimNote;
  String? disputeNote;

  String object = "";
  String description = "";

  SendMethod method = SendMethod.electronique;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                customBorder: const CircleBorder(),
                child: const Icon(Icons.arrow_back_ios)),
            title: Text(
              "Nouvelle requête",
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            actions: [
              InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const Icon(
                  Icons.notifications_none,
                  size: 24,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {},
                customBorder: const CircleBorder(),
                child: const Icon(
                  Remix.menu_5_fill,
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  InfoStudent(),
                  const Divider(
                    height: 48,
                  ),
                  ReasonRequest(
                    claim: claim,
                    course: course,
                    onClaimChange: (value) {
                      setState(() {
                        claim = value;
                      });
                    },
                    onCourseChange: (value) {
                      setState(() {
                        course = value;
                      });
                    },
                    onChangedClaim: (value) {
                      setState(() {
                        claimNote = value;
                      });
                    },
                    onChangedDispute: (value) {
                      setState(() {
                        disputeNote = value;
                      });
                    },
                  ),
                  const Divider(
                    height: 48,
                  ),
                  ImplementFile(
                    method: method,
                    switchElectronic: () {
                      setState(() {
                        method = SendMethod.electronique;
                      });
                    },
                    switchManuscrite: () {
                      setState(() {
                        method = SendMethod.manuscrite;
                      });
                    },
                    onObjectChange: (value) {
                      setState(() {
                        object = value;
                      });
                    },
                    onDescriptionChange: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                  const Divider(
                    height: 48,
                  ),
                  const SupportingDocument(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextButton(
                        onPressed: () {
                          dio.post(startApi + 'request',
                              options: Options(
                                headers: {
                                  "Authorization":
                                      "Bearer ${Get.find<InitPreferences>().prefs.getString("token")}"
                                },
                              ),
                              data: {
                                "student_id": User.fromJson(
                                        Get.find<InitPreferences>()
                                                .prefs
                                                .getString("user") ??
                                            "")
                                    .id,
                                "claim_id": claim!.id,
                                "course_id": course!.id,
                                "dispute_note": double.parse(disputeNote!),
                                "claim_note": double.parse(claimNote!),
                                "letter": {
                                  "letter_type":
                                      method == SendMethod.electronique
                                          ? "électronique"
                                          : "manuscrite",
                                  "object": object,
                                  "description": description,
                                  "file": []
                                },
                                "supporting_documents": [
                                  {"name": "", "description": "", "file": []}
                                ],
                                "submit_state": RequestSubmitState.SAVE
                              }).then((response) {
                            Get.find<HomeController>()
                                .listRequest
                                .value
                                .insert(0, response.data);

                            Get.find<HomeController>().listRequest.refresh();
                            Navigator.pop(context);
                          });
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 12, left: 15),
                            backgroundColor:
                                const Color.fromRGBO(167, 9, 170, 0.06),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    color: Color(0xffA709AA)))),
                        child: Row(
                          children: const [
                            Icon(Icons.save),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Enregistrer et soumettre la requête",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600))
                          ],
                        )),
                  ),
                  TextButton(
                      onPressed: () {
                        dio.post(startApi + 'request', data: {
                          "student_id": User.fromJson(
                                  Get.find<InitPreferences>()
                                          .prefs
                                          .getString("student") ??
                                      "")
                              .id,
                          "claim_id": claim!.id,
                          "course_id": course!.id,
                          "dispute_note": double.parse(disputeNote!),
                          "claim_note": double.parse(claimNote!),
                          "letter": {
                            "letter_type": method == SendMethod.electronique
                                ? "électronique"
                                : "manuscrite",
                            "object": object,
                            "description": description,
                            "file": []
                          },
                          "supporting_documents": [
                            {"name": "", "description": "", "file": []}
                          ],
                          "submit_state": RequestSubmitState.DRAFT
                        }).then((response) {
                          Get.find<HomeController>()
                              .listRequest
                              .value
                              .insert(0, response.data);

                          Get.find<HomeController>().listRequest.refresh();
                          Navigator.pop(context);
                        });
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 15),
                          backgroundColor:
                              const Color.fromRGBO(167, 9, 170, 0.06),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side:
                                  const BorderSide(color: Color(0xffA709AA)))),
                      child: Row(
                        children: const [
                          Icon(Icons.note),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Enregistrer comme brouillon",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600))
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}

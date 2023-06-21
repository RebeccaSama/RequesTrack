import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:request_track/app/common/profil_request.dart';
import 'package:request_track/app/models/school.dart';
import 'package:request_track/app/models/teacher.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/home/controllers/home_controller.dart';
import 'package:request_track/app/utils/init_preferences.dart';

class BottomSheetAssignDepartment extends StatefulWidget {
  final int id;
  const BottomSheetAssignDepartment({Key? key, required this.id})
      : super(key: key);

  @override
  State<BottomSheetAssignDepartment> createState() =>
      _BottomSheetAssignDepartmentState();
}

class _BottomSheetAssignDepartmentState
    extends State<BottomSheetAssignDepartment> {
  DateTime? date;

  Teacher? teacher;

  var description = TextEditingController();
  var homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assignation de la requête",
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16,
          ),
          ProfilRequest(color: const Color(0xffA708AA)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xffEEEEEE))),
              child: Container(
                width: double.infinity,
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enseignant",
                      style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                          color: Colors.black38),
                    ),
                    SizedBox(
                      height: 20,
                      child: FutureBuilder<List<Teacher>>(
                        future: dio
                            .get(startApi + "personnel/school/teacher")
                            .then((response) => (response.data as List)
                                .map((e) => Teacher.fromMap(e))
                                .toList()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<Teacher>(
                                items: snapshot.data!
                                    .map((Teacher value) =>
                                        DropdownMenuItem<Teacher>(
                                          value: value,
                                          child: Text(
                                            value.first_name +
                                                " " +
                                                value.last_name,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                    .toList(),
                                value: teacher,
                                dropdownColor: Colors.white,
                                iconEnabledColor: Colors.black,
                                hint: Text(
                                  "Sélectionner un enseignant",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    teacher = value;
                                  });
                                },
                              ),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: <String>[]
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                          ),
                                        ))
                                    .toList(),
                                value: null,
                                dropdownColor: Colors.white,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.black26,
                                hint: Text(
                                  "Sélectionner un enseignant",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                onChanged: null,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Material(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xffEEEEEE))),
            child: Container(
              width: double.infinity,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date limite",
                        style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                            color: Colors.black38),
                      ),
                      Text(
                        date == null
                            ? ""
                            : DateFormat('EEEE d MMMM yyyy').format(date!),
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  InkWell(
                      onTap: () async {
                        date = await showRoundedDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          borderRadius: 16,
                        );

                        setState(() {
                          date = date;
                        });
                      },
                      child: const Icon(Icons.today))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Stack(
            children: [
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xffEEEEEE))),
                child: Container(
                  height: 180,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextField(
                      controller: description,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      minLines: 1,
                      maxLines: 10,
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: "Message de description",
                          hintStyle: GoogleFonts.inter(color: Colors.black38),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          contentPadding: EdgeInsets.zero)),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Transform.rotate(
                    angle: -pi / 4,
                    child:
                        const Icon(Icons.filter_list, color: Colors.black38)),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xffEEEEEE)))),
                    child: Text("Annuler",
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600))),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      dio.post(
                          startApi +
                              "request/assign/${homeController.listRequest.value[widget.id]["_id"]}",
                          options: Options(
                            headers: {
                              "Authorization":
                                  "Bearer ${Get.find<InitPreferences>().prefs.getString("token")}"
                            },
                          ),
                          data: {
                            "teacher_id": teacher!.id,
                            "limit_date":
                                DateFormat('EEEE d MMMM yyyy').format(date!),
                            "description": description.text
                          }).then((value) {
                        homeController.listRequest.value.removeAt(widget.id);
                        homeController.listRequest.refresh();
                        Navigator.pop(context);
                      });
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xffEEEEEE)))),
                    child: Text(
                      "Assigner",
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}

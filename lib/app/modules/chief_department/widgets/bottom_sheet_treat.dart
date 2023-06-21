import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/common/profil_request.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/add_request/widgets/number_input.dart';
import 'package:request_track/app/modules/student/home/controllers/home_controller.dart';
import 'package:request_track/app/utils/init_preferences.dart';

class BottomSheetTreat extends StatefulWidget {
  final int id;

  const BottomSheetTreat({Key? key, required this.id}) : super(key: key);

  @override
  State<BottomSheetTreat> createState() => _BottomSheetTreatState();
}

class _BottomSheetTreatState extends State<BottomSheetTreat> {
  String decision = "Favorable";
  var note = "";
  var descriptionController = TextEditingController();

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
            "Traitement de la requête",
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16,
          ),
          ProfilRequest(color: const Color(0xffA708AA)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xffEEEEEE))),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Décision",
                            style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w300,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            height: 20,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                items: ["Favorable", "Non favorable"]
                                    .map((String value) =>
                                        DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                    .toList(),
                                value: decision,
                                hint: Text(
                                  "Sélectionner une décision",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  setState(() {
                                    decision = value!;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: NumberInput(
                  title: "Note finale",
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });

                    print(note);
                  },
                ))
              ],
            ),
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
                      controller: descriptionController,
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
                              "request/treat/${homeController.listRequest.value[widget.id]["_id"]}",
                          options: Options(
                            headers: {
                              "Authorization":
                                  "Bearer ${Get.find<InitPreferences>().prefs.getString("token")}"
                            },
                          ),
                          data: {
                            "decision": decision,
                            "final_note": double.parse(note),
                            "description": descriptionController.text
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
                      "Enregistrer",
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

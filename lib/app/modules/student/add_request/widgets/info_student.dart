import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/models/user.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/utils/init_preferences.dart';

class InfoStudent extends StatelessWidget {
  InfoStudent({Key? key}) : super(key: key);

  var preferences = Get.find<InitPreferences>().prefs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: dio
          .get(startApi +
              "student/${User.fromJson(preferences.getString("user") ?? "").userData}")
          .then((value) => value.data),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffEEEEEE))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Etudiant(e)",
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        snapshot.data["first_name"] +
                            " " +
                            snapshot.data["last_name"],
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffEEEEEE))),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    snapshot.data["department"]["name"],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xffEEEEEE))),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data["speciality"]["name"],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xffEEEEEE))),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data["classroom"]["level"].toString() +
                              "ième année",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        } else {
          return Container(
            height: 30,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}

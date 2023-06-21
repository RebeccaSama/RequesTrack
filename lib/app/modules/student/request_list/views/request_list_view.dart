import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/common/contest_admin_template.dart';
import 'package:request_track/app/common/contest_result_template.dart';
import 'package:request_track/app/common/contest_template.dart';
import 'package:request_track/app/common/contest_treatment_template.dart';
import 'package:request_track/app/modules/chief_department/widgets/contest_assignment_department.dart';
import 'package:request_track/app/modules/chief_department/widgets/contest_treatment_department.dart';
import 'package:request_track/app/modules/chief_department/widgets/contest_verify_department.dart';

class RequestListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                "Requêtes soumises",
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w500),
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
                  width: 16,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xffEEEEEE))),
                        child: TextField(
                          cursorColor: Colors.black,
                          scrollPadding: EdgeInsets.zero,
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          decoration: const InputDecoration(
                              hintText: "Rechercher par mots clés",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              contentPadding: EdgeInsets.zero),
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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xffEEEEEE))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: ["Identité", "Note de CC"]
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
                                  value: null,
                                  hint: Text(
                                    "Type de requête",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {},
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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xffEEEEEE))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: [
                                    "Brouillon",
                                    "Attente de validation",
                                  ]
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
                                  value: null,
                                  hint: Text(
                                    "Status",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  isExpanded: true,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

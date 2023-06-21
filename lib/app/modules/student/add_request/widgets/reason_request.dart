import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/models/claim.dart';
import 'package:request_track/app/models/course.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/add_request/widgets/number_input.dart';

class ReasonRequest extends StatefulWidget {
  Claim? claim;
  Course? course;
  final Function(Claim?) onClaimChange;
  final Function(Course?) onCourseChange;
  final Function(String)? onChangedClaim;
  final Function(String)? onChangedDispute;
  ReasonRequest(
      {Key? key,
      required this.onClaimChange,
      required this.onCourseChange,
      required this.onChangedClaim,
      required this.onChangedDispute,
      this.claim,
      this.course})
      : super(key: key);

  @override
  State<ReasonRequest> createState() => _ReasonRequestState();
}

class _ReasonRequestState extends State<ReasonRequest> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: FutureBuilder<List<Claim>>(
              future: dio.get(startApi + "claim").then((response) =>
                  (response.data as List)
                      .map((e) => Claim.fromMap(e))
                      .toList()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<Claim>(
                      items: snapshot.data!
                          .map((Claim value) => DropdownMenuItem<Claim>(
                                value: value,
                                child: Text(
                                  value.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                          .toList(),
                      value: widget.claim,
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.black,
                      hint: Text(
                        "Sélectionner le type de revendication",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400),
                      ),
                      isExpanded: true,
                      onChanged: widget.onClaimChange,
                    ),
                  );
                } else {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: <String>[]
                          .map((String value) => DropdownMenuItem<String>(
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
                        "Sélectionner le type de revendication",
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xffEEEEEE))),
            child: FutureBuilder<List<Course>>(
              future: dio.get(startApi + "course").then((response) =>
                  (response.data as List)
                      .map((e) => Course.fromMap(e))
                      .toList()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<Course>(
                      items: snapshot.data!
                          .map((Course value) => DropdownMenuItem<Course>(
                                value: value,
                                child: Text(
                                  value.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ))
                          .toList(),
                      value: widget.course,
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.black,
                      hint: Text(
                        "Sélectionner la matière concernée",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400),
                      ),
                      isExpanded: true,
                      onChanged: widget.onCourseChange,
                    ),
                  );
                } else {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: <String>[]
                          .map((String value) => DropdownMenuItem<String>(
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
                        "Sélectionner la matière concernée",
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
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: NumberInput(
                title: "Note contestée",
                onChanged: widget.onChangedClaim,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: NumberInput(
                title: "Note revendiquée",
                onChanged: widget.onChangedDispute,
              ),
            )
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/details_request/widgets/row_info.dart';

class UserDetails extends StatefulWidget {
  final dynamic snapshot;
  const UserDetails({Key? key, this.snapshot}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.21)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/profil.png"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.snapshot["student"]["first_name"] +
                              " " +
                              widget.snapshot["student"]["last_name"],
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.snapshot["student"]["email"],
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Container(
              constraints: BoxConstraints(maxHeight: isExpanded ? 700 : 0),
              padding: const EdgeInsets.only(
                  bottom: 16, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RowInfo(
                    item: "Nom & Prénoms :",
                    value: widget.snapshot["student"]["first_name"] +
                        " " +
                        widget.snapshot["student"]["last_name"],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RowInfo(
                    item: "Matricule :",
                    value: widget.snapshot["student"]["registration_number"],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FutureBuilder<dynamic>(
                    future: dio
                        .get(startApi +
                            "department/${widget.snapshot["student"]["department"]}")
                        .then((value) => value.data),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RowInfo(
                          item: "Département :",
                          value: snapshot.data!["name"],
                        );
                      } else {
                        return const Text("...");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<dynamic>(
                    future: dio
                        .get(startApi +
                            "speciality/${widget.snapshot["student"]["speciality"]}")
                        .then((value) => value.data),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RowInfo(
                          item: "Spécialité :",
                          value: snapshot.data!["name"],
                        );
                      } else {
                        return const Text("...");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<dynamic>(
                    future: dio
                        .get(startApi +
                            "classroom/${widget.snapshot["student"]["classroom"]}")
                        .then((value) => value.data),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RowInfo(
                          item: "Niveau :",
                          value: snapshot.data!["level"].toString(),
                        );
                      } else {
                        return const Text("...");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RowInfo(
                    item: "Téléphone :",
                    value: widget.snapshot["student"]["department"],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RowInfo(
                    item: "Email :",
                    value: widget.snapshot["student"]["email"],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

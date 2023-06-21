import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/student/add_request/widgets/add_prof.dart';

enum SendMethod { electronique, manuscrite }

class ImplementFile extends StatefulWidget {
  SendMethod method;
  final Function() switchElectronic;
  final Function() switchManuscrite;
  final Function(String)? onObjectChange;
  final Function(String)? onDescriptionChange;
  ImplementFile(
      {Key? key,
      required this.method,
      required this.onObjectChange,
      required this.onDescriptionChange,
      required this.switchElectronic,
      required this.switchManuscrite})
      : super(key: key);

  @override
  State<ImplementFile> createState() => _ImplementFileState();
}

class _ImplementFileState extends State<ImplementFile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: widget.switchElectronic,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Radio(
                      value: SendMethod.electronique,
                      groupValue: widget.method,
                      onChanged: (SendMethod? value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Lettre électronique',
                    style: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: widget.switchManuscrite,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Radio(
                      value: SendMethod.manuscrite,
                      groupValue: widget.method,
                      onChanged: (SendMethod? value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Lettre manuscrite',
                    style: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Material(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xffEEEEEE))),
            child: Container(
              width: double.infinity,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Objet",
                    style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                        color: Colors.black38),
                  ),
                  SizedBox(
                    height: 20,
                    child: TextField(
                      cursorColor: Colors.black,
                      scrollPadding: EdgeInsets.zero,
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w400),
                      onChanged: widget.onObjectChange,
                      decoration: const InputDecoration(
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
                  )
                ],
              ),
            ),
          ),
        ),
        widget.method == SendMethod.manuscrite
            ? Stack(
                children: [
                  Material(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xffEEEEEE))),
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          minLines: 1,
                          maxLines: 10,
                          style: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.w400),
                          cursorColor: Colors.black,
                          onChanged: widget.onDescriptionChange,
                          decoration: InputDecoration(
                              hintText: "Details",
                              hintStyle:
                                  GoogleFonts.inter(color: Colors.black38),
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
                        child: const Icon(Icons.filter_list,
                            color: Colors.black38)),
                  )
                ],
              )
            : AddProof(
                leading: Transform.rotate(
                    angle: pi / 4, child: const Icon(Icons.attach_file)),
              )
      ],
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/student/add_request/widgets/add_prof.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SupportingDocument extends StatefulWidget {
  const SupportingDocument({Key? key}) : super(key: key);

  @override
  State<SupportingDocument> createState() => _SupportingDocumentState();
}

class _SupportingDocumentState extends State<SupportingDocument> {
  bool disposeDocument = false;

  var documentName = "Copie corrigée par l’enseignant";

  List<String> documents = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              disposeDocument = !disposeDocument;
            });
          },
          child: Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Switch.adaptive(
                    value: disposeDocument,
                    activeColor: const Color(0xffA709AA),
                    onChanged: (value) {
                      setState(() {
                        disposeDocument = !disposeDocument;
                      });
                    }),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "Je dispose de documents justificatifs",
                style: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Visibility(
            visible: disposeDocument,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AddProof(
                        leading: InkWell(
                          onTap: () {
                            setState(() {
                              documents.removeAt(index);
                            });
                          },
                          child: const Icon(
                            Icons.remove_circle_outline,
                            color: Color.fromRGBO(170, 9, 9, 0.72),
                          ),
                        ),
                        title: documents[index],
                      );
                    },
                    separatorBuilder: (context, _) => const SizedBox(
                          height: 30,
                        ),
                    itemCount: documents.length),
                SizedBox(
                  height: documents.isNotEmpty ? 40 : 0,
                ),
                InkWell(
                  onTap: () {
                    showSlidingBottomSheet(context, builder: (builder) {
                      return SlidingSheetDialog(
                        padding: const EdgeInsets.all(16),
                        snapSpec:
                            const SnapSpec(initialSnap: 1, snappings: [1]),
                        cornerRadius: 8,
                        builder: (context, state) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nouveau document type",
                              style: GoogleFonts.inter(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Material(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: Color(0xffEEEEEE))),
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type de document",
                                        style: GoogleFonts.inter(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black38),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: TextFormField(
                                          initialValue:
                                              "Copie corrigée par l’enseignant",
                                          onChanged: (String value) {
                                            setState(() {
                                              documentName = value;
                                            });
                                          },
                                          cursorColor: Colors.black,
                                          scrollPadding: EdgeInsets.zero,
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                              contentPadding: EdgeInsets.zero),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Material(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: Color(0xffEEEEEE))),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                            hintText: "Description du document",
                                            hintStyle: GoogleFonts.inter(
                                                color: Colors.black38),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent)),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent)),
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  color: Color(0xffEEEEEE)))),
                                      child: Text("Annuler",
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          documents.add(documentName);

                                          documents =
                                              documents.toSet().toList();

                                          documentName =
                                              "Copie corrigée par l’enseignant";
                                        });

                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  color: Color(0xffEEEEEE)))),
                                      child: Text(
                                        "Enregistrer",
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add_circle_outline),
                      SizedBox(width: 10),
                      Text(
                        "Ajouter un document type comme justificatif",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}

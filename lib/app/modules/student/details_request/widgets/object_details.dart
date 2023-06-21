import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/student/details_request/widgets/row_info.dart';

class ObjectDetails extends StatefulWidget {
  dynamic snapshot;
  ObjectDetails({Key? key, this.snapshot}) : super(key: key);

  @override
  State<ObjectDetails> createState() => _ObjectDetailsState();
}

class _ObjectDetailsState extends State<ObjectDetails> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffA709AA)),
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
                  const Icon(
                    Icons.file_copy,
                    color: Color(0xffA709AA),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                      child: Text.rich(
                    TextSpan(
                        text: "Objet: ",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1.8,
                        ),
                        children: [
                          TextSpan(
                              text: widget.snapshot["letter"]["object"],
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500))
                        ]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
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
                    item: "Type :",
                    value: widget.snapshot["claim"]["name"],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RowInfo(
                    item: "Unité de valeur :",
                    value: widget.snapshot["course"]["name"],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RowInfo(
                    item: "Note contestée :",
                    value: widget.snapshot["dispute_note"].toString() + "/20",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RowInfo(
                    item: "Note revendiquée :",
                    value: widget.snapshot["claim_note"].toString() + "/20",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RowInfo(
                      item: "Status :",
                      value: widget.snapshot["status"],
                      color: const Color(0xffA709AA)),
                  const SizedBox(
                    height: 20,
                  ),
                  RowInfo(
                    item: "Etape :",
                    value:
                        widget.snapshot["request_step"].toString() + " sur 6",
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

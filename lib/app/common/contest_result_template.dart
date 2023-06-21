import 'package:flutter/material.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/home/widgets/coupon.dart';
import 'package:request_track/app/modules/student/home/widgets/list_puce.dart';
import 'package:request_track/app/modules/student/home/widgets/mark.dart';

class ContestResultTemplate extends StatefulWidget {
  final dynamic snapshot;
  const ContestResultTemplate({Key? key, this.snapshot}) : super(key: key);

  @override
  State<ContestResultTemplate> createState() => _ContestResultTemplateState();
}

class _ContestResultTemplateState extends State<ContestResultTemplate> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    widget.snapshot["treat"]["decision"] == Decision.FAVORABLE
                        ? const Color(0xff04792C)
                        : const Color(0xffAA0909)),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: double.infinity,
                  color:
                      widget.snapshot["treat"]["decision"] == Decision.FAVORABLE
                          ? const Color(0xff04792C)
                          : const Color(0xffAA0909),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: widget.snapshot["treat"]["decision"] ==
                                      Decision.FAVORABLE
                                  ? const Color(0xff04792C)
                                  : const Color(0xffAA0909),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                widget.snapshot["letter"]["object"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Coupon(
                                itemLeft: "Type",
                                itemRight: widget.snapshot["claim"]["name"],
                                color: Colors.black),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text("/"),
                            ),
                            Coupon(
                                itemLeft: "Status",
                                itemRight: widget.snapshot["treat"]
                                            ["decision"] ==
                                        Decision.FAVORABLE
                                    ? "Publiée et favorable"
                                    : "Publiée et non favorable",
                                color: widget.snapshot["treat"]["decision"] ==
                                        Decision.FAVORABLE
                                    ? const Color(0xff04792C)
                                    : const Color(0xffAA0909))
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.snapshot["request_step"].toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              " / 06 étapes prévues",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w300),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                "soumises le " + widget.snapshot["submit_date"],
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  expanded = !expanded;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: widget.snapshot["treat"]
                                                    ["decision"] ==
                                                Decision.FAVORABLE
                                            ? const Color(0xff04792C)
                                            : const Color(0xffAA0909))),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.snapshot["treat"]
                                                  ["decision"] ==
                                              Decision.FAVORABLE
                                          ? const Color(0xff04792C)
                                          : const Color(0xffAA0909)),
                                  child: AnimatedRotation(
                                    turns: expanded ? 0.5 : 0,
                                    duration: const Duration(milliseconds: 200),
                                    child: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          constraints:
                              BoxConstraints(maxHeight: expanded ? 700 : 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Divider(
                                    color: widget.snapshot["treat"]
                                                ["decision"] ==
                                            Decision.FAVORABLE
                                        ? const Color(0xff04792C)
                                        : const Color(0xffAA0909),
                                    thickness: 1.2,
                                    height: 0,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: widget.snapshot["treat"]
                                                  ["decision"] ==
                                              Decision.FAVORABLE
                                          ? const Color(0xff04792C)
                                              .withOpacity(0.06)
                                          : const Color(0xffAA0909)
                                              .withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(children: [
                                    Mark(
                                        title: "Note contestée",
                                        subtitle:
                                            widget.snapshot["dispute_note"].toString() +
                                                "/20",
                                        icon: Icons.document_scanner_outlined),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25),
                                        child: Mark(
                                            title: "Note revendiquée",
                                            subtitle:
                                                widget.snapshot["claim_note"].toString() +
                                                    "/20",
                                            size: 14,
                                            weight: FontWeight.w800,
                                            icon: Icons
                                                .document_scanner_outlined)),
                                    Mark(
                                        title: "Date de soumission",
                                        subtitle:
                                            widget.snapshot["submit_date"],
                                        icon: Icons.date_range),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Mark(
                                        title: "Publiée le",
                                        subtitle: widget.snapshot["publish"]
                                            ["publish_date"],
                                        icon: Icons.send_and_archive_rounded),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListPuce(
                                      title: "Décision",
                                      subtitle: widget.snapshot["treat"]
                                                  ["decision"] ==
                                              Decision.FAVORABLE
                                          ? "Favorable"
                                          : "Non favorable",
                                      color: widget.snapshot["treat"]
                                                  ["decision"] ==
                                              Decision.FAVORABLE
                                          ? const Color(0xff04792C)
                                          : const Color(0xffAA0909),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: ListPuce(
                                        title: "Note finale",
                                        subtitle: widget.snapshot["treat"]
                                                ["final_note"] +
                                            "/20",
                                        size: 16,
                                        color: widget.snapshot["treat"]
                                                    ["decision"] ==
                                                Decision.FAVORABLE
                                            ? const Color(0xff04792C)
                                            : const Color(0xffAA0909),
                                      ),
                                    ),
                                    ListPuce(
                                        title: "Description",
                                        subtitle: widget.snapshot["treat"]
                                            ["description"])
                                  ]),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                side: BorderSide(
                                                    color: widget.snapshot["treat"]
                                                                ["decision"] ==
                                                            Decision.FAVORABLE
                                                        ? const Color(
                                                            0xff04792C)
                                                        : const Color(
                                                            0xffAA0909))),
                                            backgroundColor:
                                                widget.snapshot["treat"]
                                                            ["decision"] ==
                                                        Decision.FAVORABLE
                                                    ? const Color(0xff04792C)
                                                        .withOpacity(0.06)
                                                    : const Color(0xffAA0909)
                                                        .withOpacity(0.06)),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text("Voir tous les détails",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Icon(
                                              Icons.east,
                                              color: Colors.black54,
                                            )
                                          ],
                                        ))),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

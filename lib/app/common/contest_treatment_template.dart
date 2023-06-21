import 'package:flutter/material.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/home/widgets/coupon.dart';
import 'package:request_track/app/modules/student/home/widgets/mark.dart';

class ContestTreatmentTemplate extends StatefulWidget {
  final Color color;
  final dynamic snapshot;
  final String status;
  const ContestTreatmentTemplate(
      {Key? key,
      this.color = const Color(0xff1509AA),
      this.snapshot,
      this.status = RequestStatus.TREATMENT_PENDING})
      : super(key: key);

  @override
  State<ContestTreatmentTemplate> createState() =>
      _ContestTreatmentTemplateState();
}

class _ContestTreatmentTemplateState extends State<ContestTreatmentTemplate> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: widget.color),
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
                  color: widget.color,
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
                              color: widget.color,
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
                                itemRight: widget.status,
                                color: widget.color)
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
                                    border: Border.all(color: widget.color)),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.color),
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
                                    color: widget.color,
                                    thickness: 1.2,
                                    height: 0,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: widget.color.withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(children: [
                                    Mark(
                                        title: "Note contestée",
                                        subtitle: widget
                                                .snapshot["dispute_note"]
                                                .toString() +
                                            "/20",
                                        icon: Icons.document_scanner_outlined),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25),
                                        child: Mark(
                                            title: "Note revendiquée",
                                            subtitle: widget
                                                    .snapshot["claim_note"]
                                                    .toString() +
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
                                        title: widget.status ==
                                                RequestStatus
                                                    .DELIBERATION_PENDING
                                            ? "Traitement accepté le"
                                            : widget.status ==
                                                    RequestStatus
                                                        .PUBLISHING_PENDING
                                                ? "Délibérée le"
                                                : "Réception acceptée le",
                                        subtitle: widget.status ==
                                                RequestStatus
                                                    .DELIBERATION_PENDING
                                            ? widget.snapshot["deliberate"]
                                                ["deliberate_date"]
                                            : widget.status ==
                                                    RequestStatus
                                                        .PUBLISHING_PENDING
                                                ? widget.snapshot["publish"]
                                                    ["publish_date"]
                                                : widget
                                                    .snapshot["submit_date"],
                                        icon: Icons.send_and_archive_rounded)
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
                                                    color: widget.color)),
                                            backgroundColor:
                                                widget.color.withOpacity(0.06)),
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

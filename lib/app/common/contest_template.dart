import 'package:flutter/material.dart';
import 'package:request_track/app/modules/student/details_request/views/details_request_view.dart';
import 'package:request_track/app/modules/student/home/widgets/coupon.dart';
import 'package:request_track/app/modules/student/home/widgets/list_puce.dart';
import 'package:request_track/app/modules/student/home/widgets/mark.dart';

class ContestTemplate extends StatefulWidget {
  final bool save;
  final dynamic snapshot;
  const ContestTemplate({Key? key, this.save = true, this.snapshot})
      : super(key: key);

  @override
  State<ContestTemplate> createState() => _ContestTemplateState();
}

class _ContestTemplateState extends State<ContestTemplate> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.save ? const Color(0xffA708AA) : Colors.grey),
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
                  color: widget.save ? const Color(0xffA708AA) : Colors.grey,
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
                              color: widget.save
                                  ? const Color(0xffA708AA)
                                  : Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  print(widget.snapshot);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              DetailsRequestView(
                                                snapshot: widget.snapshot,
                                              )));
                                },
                                child: Text(
                                  widget.snapshot["letter"]["object"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
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
                                itemRight: widget.snapshot["claim"]["name"].toString(),
                                color: Colors.black),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text("/"),
                            ),
                            Coupon(
                                itemLeft: "Status",
                                itemRight: widget.snapshot["status"],
                                color: widget.save
                                    ? const Color(0xffA708AA)
                                    : Colors.grey)
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
                                        color: widget.save
                                            ? const Color(0xffA708AA)
                                            : Colors.grey)),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.save
                                          ? const Color(0xffA708AA)
                                          : Colors.grey),
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
                                    color: widget.save
                                        ? const Color(0xffA708AA)
                                        : Colors.grey,
                                    thickness: 1.2,
                                    height: 0,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          167, 9, 170, 0.06),
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
                                        title: "Documents joins",
                                        subtitle: (widget.snapshot[
                                                "supporting_documents"] as List)
                                            .map((e) =>
                                                ((e["files"] ?? []) as List)
                                                    .length)
                                            .fold<int>(
                                                0,
                                                (int sum, int item) =>
                                                    sum + item)
                                            .toString(),
                                        size: 14,
                                        weight: FontWeight.w800,
                                        icon: Icons.document_scanner_outlined),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                          (widget.snapshot[
                                                      "supporting_documents"]
                                                  as List)
                                              .length,
                                          (index) => Column(
                                                children: [
                                                  ListPuce(
                                                      title: widget.snapshot[
                                                              "supporting_documents"]
                                                          [index]["name"],
                                                      subtitle: ((widget.snapshot[
                                                                          "supporting_documents"]
                                                                      [index]
                                                                  ["files"] ??
                                                              []) as List)
                                                          .length
                                                          .toString()),
                                                  SizedBox(
                                                    height: index !=
                                                            (widget.snapshot[
                                                                            "supporting_documents"]
                                                                        as List)
                                                                    .length -
                                                                1
                                                        ? 8
                                                        : 0,
                                                  )
                                                ],
                                              )),
                                    )
                                  ]),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: BorderSide(
                                                        color: widget.save
                                                            ? const Color(
                                                                0xffA708AA)
                                                            : Colors.grey)),
                                                backgroundColor: widget.save
                                                    ? const Color(0xffA708AA)
                                                        .withOpacity(0.06)
                                                    : Colors.grey
                                                        .withOpacity(0.06)),
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.black,
                                            ))),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: BorderSide(
                                                          color: widget.save
                                                              ? const Color(
                                                                  0xffA708AA)
                                                              : Colors.grey)),
                                                  backgroundColor: widget.save
                                                      ? const Color(0xffA708AA)
                                                          .withOpacity(0.06)
                                                      : Colors.grey
                                                          .withOpacity(0.06)),
                                              onPressed: () {},
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ))),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                          height: 40,
                                          width: double.infinity,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: BorderSide(
                                                          color: widget.save
                                                              ? const Color(
                                                                  0xffA708AA)
                                                              : Colors.grey)),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          167, 9, 170, 0.06)),
                                              onPressed: () {
                                                print(widget.snapshot);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            DetailsRequestView(
                                                              snapshot: widget
                                                                  .snapshot,
                                                            )));
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                    )
                                  ],
                                ),
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

import 'package:flutter/material.dart';
import 'package:request_track/app/common/profil_request.dart';
import 'package:request_track/app/modules/student/home/widgets/coupon.dart';
import 'package:request_track/app/modules/student/home/widgets/list_puce.dart';
import 'package:request_track/app/modules/student/home/widgets/mark.dart';

class ContestVerifyDepartment extends StatefulWidget {
  final dynamic snapshot;
  const ContestVerifyDepartment({Key? key, this.snapshot}) : super(key: key);

  @override
  State<ContestVerifyDepartment> createState() =>
      _ContestVerifyDepartmentState();
}

class _ContestVerifyDepartmentState extends State<ContestVerifyDepartment> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff42E9F4)),
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
                  color: const Color(0xff42E9F4),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        ProfilRequest(
                          color: const Color(0xff42E9F4),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Coupon(
                                itemLeft: "Type",
                                itemRight: "Note CC",
                                color: Colors.black),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text("/"),
                            ),
                            const Coupon(
                                itemLeft: "Status",
                                itemRight: "Traitement à vérifier",
                                color: Color(0xff42E9F4)),
                            const Spacer(),
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
                                        color: const Color(0xff42E9F4))),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff42E9F4)),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Divider(
                                    color: Color(0xff42E9F4),
                                    thickness: 1.2,
                                    height: 0,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff42E9F4)
                                          .withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(children: const [
                                    Mark(
                                        title: "Note contestée",
                                        subtitle: "7,5/20",
                                        icon: Icons.document_scanner_outlined),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 25),
                                        child: Mark(
                                            title: "Note revendiquée",
                                            subtitle: "7,5/20",
                                            size: 14,
                                            weight: FontWeight.w800,
                                            icon: Icons
                                                .document_scanner_outlined)),
                                    Mark(
                                        title: "Date de soumission",
                                        subtitle: "12/10/2022",
                                        icon: Icons.date_range),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      child: Mark(
                                          title: "Traitée le",
                                          subtitle: "12/10/2022 à 13h41min",
                                          icon: Icons.send_and_archive_rounded),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                      child: ListPuce(
                                          title: "Enseignant",
                                          subtitle: "Junior Temgoua"),
                                    ),
                                    ListPuce(
                                      title: "Décision",
                                      subtitle: "Favorable",
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: ListPuce(
                                        title: "Note proposée",
                                        subtitle: "17/20",
                                        size: 16,
                                      ),
                                    ),
                                    ListPuce(
                                        title: "Description",
                                        subtitle: "Lorem Ipsum")
                                  ]),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
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
                                                      side: const BorderSide(
                                                          color: Color(
                                                              0xff4285F4))),
                                                  backgroundColor:
                                                      const Color(0xff42E9F4)
                                                          .withOpacity(0.06)),
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text("Éditer et terminer",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  Icon(
                                                    Icons.delete,
                                                  ),
                                                ],
                                              ))),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xff42E9F4))),
                                                backgroundColor:
                                                    const Color(0xff42E9F4)
                                                        .withOpacity(0.06)),
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.check,
                                            ))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xff42E9F4))),
                                                backgroundColor:
                                                    const Color(0xff42E9F4)
                                                        .withOpacity(0.06)),
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.person,
                                            ))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xff42E9F4))),
                                                backgroundColor:
                                                    const Color(0xff42E9F4)
                                                        .withOpacity(0.06)),
                                            onPressed: () {},
                                            child: const Icon(
                                              Icons.east,
                                            )))
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

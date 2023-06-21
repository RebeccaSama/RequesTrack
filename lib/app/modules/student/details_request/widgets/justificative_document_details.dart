import 'package:flutter/material.dart';

class JustificativeDocumentDetails extends StatefulWidget {
  dynamic snapshot;
  JustificativeDocumentDetails({Key? key, this.snapshot}) : super(key: key);

  @override
  State<JustificativeDocumentDetails> createState() =>
      _JustificativeDocumentDetailsState();
}

class _JustificativeDocumentDetailsState
    extends State<JustificativeDocumentDetails> {
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
                  const Icon(
                    Icons.file_copy,
                    color: Color.fromRGBO(0, 0, 0, 0.21),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Documents justificatifs",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          (widget.snapshot["supporting_documents"] as List)
                                  .map((e) => (e["files"] as List).length)
                                  .fold<int>(
                                      0, (int sum, int item) => sum + item)
                                  .toString() +
                              " documents",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14))
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
              constraints: BoxConstraints(maxHeight: isExpanded ? 3000 : 0),
              padding: const EdgeInsets.only(
                  bottom: 16, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.snapshot["supporting_documents"]
                                            [index]["name"],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        (widget.snapshot["supporting_documents"]
                                                    [index]["files"] as List)
                                                .length
                                                .toString() +
                                            " documents",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                  const Icon(Icons.info_outline_rounded)
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                crossAxisCount: 4,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                children: List.generate(
                                    (widget.snapshot["supporting_documents"]
                                            [index]["files"] as List)
                                        .length, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.21)),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: 28),
                      itemCount:
                          (widget.snapshot["supporting_documents"] as List)
                              .length)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

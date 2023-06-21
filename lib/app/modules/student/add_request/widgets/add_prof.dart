import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:pdfx/pdfx.dart';

class AddProof extends StatefulWidget {
  String title;
  final Widget leading;
  AddProof(
      {Key? key,
      this.title = "Lettre manuscrite addressée au directeur",
      required this.leading})
      : super(key: key);

  @override
  State<AddProof> createState() => _AddProofState();
}

class _AddProofState extends State<AddProof> {
  var logger = Logger();

  List<String> documentPaths = [];

  int? selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          widget.leading,
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filmer / importer",
                style: GoogleFonts.inter(
                    fontStyle: FontStyle.italic,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                    fontStyle: FontStyle.italic,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const Spacer(),
          Visibility(
            visible: documentPaths.isNotEmpty,
            child: Text(
              documentPaths.length.toString().length == 1
                  ? "0" + documentPaths.length.toString()
                  : documentPaths.length.toString(),
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 35),
        child: IntrinsicHeight(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final ImagePicker picker = ImagePicker();

                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);

                if (image != null) {
                  setState(() {
                    documentPaths.add(image.path);
                  });
                }
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.24))),
                child: Icon(
                  Icons.center_focus_strong,
                  color: Colors.black.withOpacity(0.24),
                  size: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'doc', 'docx'],
                );

                if (result != null) {
                  setState(() {
                    documentPaths.add(result.files.first.path!);

                    documentPaths = documentPaths.toSet().toList();
                  });
                }
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black.withOpacity(0.24))),
                child: Icon(
                  Icons.upload_file,
                  color: Colors.black.withOpacity(0.24),
                  size: 18,
                ),
              ),
            ),
            const VerticalDivider(
              width: 28,
            ),
            Expanded(
                child: SizedBox(
              height: 40,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PopupMenuButton(
                      offset: const Offset(0, -60),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            OpenFile.open(documentPaths[index]);
                          },
                          padding: EdgeInsets.zero,
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ouvrir",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              documentPaths.removeAt(index);
                            });
                          },
                          padding: EdgeInsets.zero,
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Supprimer",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.24))),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: GetUtils.isImage(documentPaths[index])
                                ? Image.file(
                                    File(documentPaths[index]),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  )
                                : documentPaths[index].endsWith(".pdf")
                                    ? FutureBuilder<PdfPageImage>(
                                        future: pdfThumbail(
                                            path: documentPaths[index]),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Image.memory(
                                              snapshot.data!.bytes,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            );
                                          } else {
                                            return const CupertinoActivityIndicator();
                                          }
                                        })
                                    : const Icon(
                                        BootstrapIcons.file_word_fill)),
                      ),
                    );
                  },
                  separatorBuilder: (context, _) => const SizedBox(
                        width: 10,
                      ),
                  itemCount: documentPaths.length),
            ))
          ],
        )),
      )
    ]);
  }

  Future<PdfPageImage> pdfThumbail({required String path}) async {
    final document = await PdfDocument.openFile(path);
    final page = await document.getPage(1);
    final pageImage = await page.render(
      width: 40,
      height: 40,
      format: PdfPageImageFormat.jpeg,
    );

    await page.close();
    await document.close();

    return pageImage!;
  }
}

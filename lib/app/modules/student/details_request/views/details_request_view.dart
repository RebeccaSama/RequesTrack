import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';
import 'package:request_track/app/modules/student/details_request/widgets/justificative_document_details.dart';
import 'package:request_track/app/modules/student/details_request/widgets/letter_request.dart';
import 'package:request_track/app/modules/student/details_request/widgets/object_details.dart';
import 'package:request_track/app/modules/student/details_request/widgets/user_details.dart';

class DetailsRequestView extends StatelessWidget {
  dynamic snapshot;
  DetailsRequestView({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            customBorder: const CircleBorder(),
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          "Détails de la requête",
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: const Icon(
              Icons.edit,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: const Icon(
              Remix.menu_5_fill,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              UserDetails(
                snapshot: snapshot,
              ),
              const SizedBox(
                height: 16,
              ),
              ObjectDetails(
                snapshot: snapshot,
              ),
              const SizedBox(
                height: 16,
              ),
              JustificativeDocumentDetails(
                snapshot: snapshot,
              ),
              const SizedBox(
                height: 16,
              ),
              const LetterRequest(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, left: 15),
                        backgroundColor:
                            const Color.fromRGBO(167, 9, 170, 0.06),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xffA709AA)))),
                    child: Row(
                      children: const [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Modifier et soumettre la requête",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600))
                      ],
                    )),
              ),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding:
                          const EdgeInsets.only(top: 12, bottom: 12, left: 15),
                      backgroundColor: const Color.fromRGBO(167, 9, 170, 0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xffA709AA)))),
                  child: Row(
                    children: const [
                      Icon(Icons.delete_forever),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Supprimer définitivement la requête",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/student/add_request/views/add_request_view.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffF5F5F5)),
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
                alignment: Alignment.topRight,
                image: AssetImage("assets/crown.png"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bienvenue sur RequesTrack",
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 8,
            ),
            Text(
                "Votre plateforme de gestion et de suivi de vos réquêtes académiques",
                style: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 24,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffA709AA),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => AddRequestView()));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("Nouvelle requete".toUpperCase(),
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

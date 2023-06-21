import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/black_student.jpg"),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "S'inscrire",
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 6,
                            sigmaY: 6,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            color: Colors.black.withOpacity(0.24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(TextSpan(
                                    text:
                                        "Sauf erreur, il semble que votre adresse email ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "argentineangue@gmail.com",
                                          style: GoogleFonts.inter(
                                              color: const Color(0xffFBBC05))),
                                      const TextSpan(
                                          text:
                                              " ne soit pas éligible à l’ENSET de Douala.Veillez contacter le service des étudiants pour aquerir une eligibilité valide.")
                                    ])),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: 48,
                                  width: double.infinity,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffFBBC05),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      onPressed: () {},
                                      child: const Text(
                                        "Accepter et continuer",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
                top: 16,
                left: 16,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

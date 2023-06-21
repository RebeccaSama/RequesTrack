import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:request_track/app/modules/authenticate/user_controller.dart';

import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/home/views/home_view.dart';

class SignUpView extends StatefulWidget {
  final String id, name, phone, email, status;
  const SignUpView(
      {Key? key,
      required this.email,
      required this.id,
      required this.name,
      required this.phone,
      required this.status})
      : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool passwordVisible = false;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  var passwordController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                                          "Il semble que n’ayez pas encore de compte et que votre adresse email ",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: widget.email,
                                            style: GoogleFonts.inter(
                                                color:
                                                    const Color(0xffFBBC05))),
                                        const TextSpan(
                                            text:
                                                " soit éligible à l’ENSET de Douala")
                                      ])),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nom",
                                          style: GoogleFonts.inter(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black38),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            scrollPadding: EdgeInsets.zero,
                                            enabled: !loading,
                                            controller: nameController,
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .transparent)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                contentPadding:
                                                    EdgeInsets.zero),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Container(
                                      width: double.infinity,
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Téléphone",
                                            style: GoogleFonts.inter(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black38),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: TextField(
                                              cursorColor: Colors.black,
                                              scrollPadding: EdgeInsets.zero,
                                              enabled: !loading,
                                              controller: phoneController,
                                              style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent)),
                                                  contentPadding:
                                                      EdgeInsets.zero),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mot de passe",
                                          style: GoogleFonts.inter(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black38),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            scrollPadding: EdgeInsets.zero,
                                            enabled: !loading,
                                            controller: passwordController,
                                            obscureText:
                                                passwordVisible ? false : true,
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                            decoration: InputDecoration(
                                                suffix: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      passwordVisible =
                                                          !passwordVisible;
                                                    });
                                                  },
                                                  child: Icon(
                                                    passwordVisible
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                ),
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                contentPadding:
                                                    EdgeInsets.zero),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text.rich(TextSpan(
                                        text:
                                            "En cliquant sur Accepter et continuer ci-dessous, j’accepte toutes les ",
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "Conditions d'utilisation et politique de confidentialité",
                                              style: GoogleFonts.inter(
                                                  color:
                                                      const Color(0xffFBBC05)))
                                        ])),
                                  ),
                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) =>
                                                  states.contains(MaterialState
                                                          .disabled)
                                                      ? const Color(0xffFBBC05)
                                                          .withOpacity(0.8)
                                                      : const Color(0xffFBBC05),
                                            ),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)))),
                                        onPressed: passwordController
                                                    .text.isEmpty ||
                                                nameController.text.isEmpty ||
                                                phoneController.text.isEmpty ||
                                                loading
                                            ? null
                                            : () {
                                                setState(() {
                                                  loading = true;
                                                });

                                                dio.post(
                                                    startApi + 'auth/signUp',
                                                    data: {
                                                      "email": widget.email,
                                                      "phone_number":
                                                          phoneController.text,
                                                      "password":
                                                          passwordController
                                                              .text,
                                                      "user_status":
                                                          widget.status,
                                                      "current_user_id":
                                                          widget.id
                                                    }).then((response) {
                                                  setState(() {
                                                    loading = false;
                                                  });

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              HomeView(
                                                                name:
                                                                    widget.name,
                                                                email: widget
                                                                    .email,
                                                              )));
                                                }).catchError((_) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                });
                                              },
                                        child: !loading
                                            ? const Text(
                                                "Accepter et continuer",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : LoadingAnimationWidget
                                                .fourRotatingDots(
                                                color: Colors.white,
                                                size: 20,
                                              )),
                                  ),
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
      ),
    );
  }
}

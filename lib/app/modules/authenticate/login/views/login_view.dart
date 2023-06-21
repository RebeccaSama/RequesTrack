import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:request_track/app/models/school.dart';
import 'package:request_track/app/models/user.dart';
import 'package:request_track/app/modules/authenticate/connect/views/connect_view.dart';
import 'package:request_track/app/modules/authenticate/sign_up/views/sign_up_view.dart';
import 'package:request_track/app/modules/authenticate/sign_up_error/views/sign_up_error_view.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/utils/init_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;

  School? school;
  TextEditingController emailController = TextEditingController();

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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height -
                      MediaQuery
                          .of(context)
                          .padding
                          .top,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/black_student.jpg"),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello !",
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
                                  Container(
                                    width: double.infinity,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: FutureBuilder<List<School>>(
                                      future: dio.get(startApi + "school").then(
                                              (response) =>
                                              (response.data as List)
                                                  .map((e) => School.fromMap(e))
                                                  .toList()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton<School>(
                                              items: snapshot.data!
                                                  .map((School value) =>
                                                  DropdownMenuItem<School>(
                                                    value: value,
                                                    child: Text(
                                                      value.name,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style:
                                                      GoogleFonts.inter(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                    ),
                                                  ))
                                                  .toList(),
                                              value: school,
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: Colors.black,
                                              hint: Text(
                                                "Ecole",
                                                style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: Colors.black45,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              isExpanded: true,
                                              onChanged: loading
                                                  ? null
                                                  : (School? value) {
                                                setState(() {
                                                  school = value;
                                                });
                                              },
                                            ),
                                          );
                                        } else {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              items: <String>[]
                                                  .map((String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                    ),
                                                  ))
                                                  .toList(),
                                              value: null,
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: Colors.black,
                                              iconDisabledColor: Colors.black26,
                                              hint: Text(
                                                "Ecole",
                                                style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: Colors.black45,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              isExpanded: true,
                                              onChanged: null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
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
                                          "Email / Téléphone",
                                          style: GoogleFonts.inter(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black38),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: TextField(
                                            cursorColor: Colors.black,
                                            controller: emailController,
                                            scrollPadding: EdgeInsets.zero,
                                            enabled: !loading,
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
                                  const SizedBox(
                                    height: 16,
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
                                        onPressed:
                                        school == null ||
                                            emailController
                                                .text.isEmpty ||
                                            loading
                                            ? null
                                            : () {
                                          setState(() {
                                            loading = true;
                                          });

                                          dio.post(
                                              startApi +
                                                  'auth/signUp/checkUsername',
                                              data: {
                                                "school_id": school!.id,
                                                "username": emailController.text
                                              }).then((response) {
                                            print(response);
                                            if (response.data["status"] ==
                                                "user") {
                                              Get
                                                  .find<InitPreferences>()
                                                  .prefs
                                                  .setString(
                                                  "user",
                                                  User(
                                                      id: response
                                                          .data["data"]["student"] ??
                                                          response
                                                              .data["data"]["personnel"],
                                                      name: response
                                                          .data["data"]["last_name"] +
                                                          " " +
                                                          response
                                                              .data["data"]["first_name"],
                                                      phone: response
                                                          .data["data"]["phone_number"],
                                                      email: response
                                                          .data["data"]
                                                      ["email"],
                                                      userData: response
                                                          .data["data"]["student"] ??
                                                          response
                                                              .data["data"]["personnel"],
                                                      role: response
                                                          .data["data"]["role"])
                                                      .toJson());

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (builder) =>
                                                          ConnectView(
                                                            email:
                                                            response
                                                                .data["data"]["email"],
                                                            name: response
                                                                .data["data"]["last_name"] +
                                                                " " +
                                                                response
                                                                    .data["data"]["first_name"],
                                                          )
                                                  )
                                              );
                                            }

                                            if (response
                                                .data["status"] ==
                                                "student") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (builder) =>
                                                          SignUpView(
                                                            id: response
                                                                .data["data"]["_id"],
                                                            name: response
                                                                .data["data"]["last_name"] +
                                                                " " +
                                                                response
                                                                    .data["data"]["first_name"],
                                                            phone:
                                                            response
                                                                .data["data"]["phone_number"],
                                                            email:
                                                            response
                                                                .data["data"]["email"],
                                                            status:
                                                            response
                                                                .data["status"],
                                                          )));
                                            }

                                            setState(() {
                                              loading = false;
                                            });
                                          }).catchError((e) {
                                            setState(() {
                                              loading = false;
                                            });

                                            print(e);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        SignUpErrorView()));
                                          });
                                        },
                                        child: !loading
                                            ? const Text(
                                          "Continuer",
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 55,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            child: Text(
                                              "Ou",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            width: 55,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white)),
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 48,
                                    width: double.infinity,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            padding:
                                            const EdgeInsets.only(left: 12),
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8))),
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            Image.asset("assets/facebook.png"),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            const Text(
                                              "Continuer avec Facebook",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: SizedBox(
                                      height: 48,
                                      width: double.infinity,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8))),
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              Image.asset("assets/google.png"),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              const Text(
                                                "Continuer avec Google",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Vous n’avez pas de compte ? ",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          "Inscrivez-vous",
                                          style: GoogleFonts.inter(
                                              color: const Color(0xffFBBC05),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "Mot de passe oublié ?",
                                      style: GoogleFonts.inter(
                                          color: const Color(0xffFBBC05),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const Positioned(
                  top: 16,
                  left: 16,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

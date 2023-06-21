import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:request_track/app/modules/constants.dart';
import 'package:request_track/app/modules/student/home/views/home_view.dart';
import 'package:request_track/app/utils/init_preferences.dart';

class ConnectView extends StatefulWidget {
  final String name, email;

  const ConnectView({Key? key, required this.name, required this.email})
      : super(key: key);
  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  bool passwordVisible = false;

  var passwordController = TextEditingController();
  bool loading = false;

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
                        "Se connecter",
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
                                  Row(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: const BoxDecoration(
                                              color: Colors.grey),
                                          child: const Icon(Icons.person),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(widget.name,
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            widget.email,
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ],
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
                                          "Mot de passe",
                                          style: GoogleFonts.inter(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black38),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: TextField(
                                            controller: passwordController,
                                            cursorColor: Colors.black,
                                            scrollPadding: EdgeInsets.zero,
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
                                    child: SizedBox(
                                      height: 48,
                                      width: double.infinity,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) =>
                                                    states.contains(
                                                            MaterialState
                                                                .disabled)
                                                        ? const Color(
                                                                0xffFBBC05)
                                                            .withOpacity(0.8)
                                                        : const Color(
                                                            0xffFBBC05),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)))),
                                          onPressed: passwordController
                                                      .text.isEmpty ||
                                                  loading
                                              ? null
                                              : () {
                                                  setState(() {
                                                    loading = true;
                                                  });

                                                  dio.post(
                                                      startApi + 'auth/signIn',
                                                      data: {
                                                        "username":
                                                            widget.email,
                                                        "password":
                                                            passwordController
                                                                .text,
                                                      }).then((response) async {
                                                    setState(() {
                                                      loading = false;
                                                    });

                                                    Get.find<InitPreferences>()
                                                        .prefs
                                                        .setString(
                                                            "token",
                                                            response.data[
                                                                "access_token"]);

                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (builder) =>
                                                                        HomeView(
                                                                          name:
                                                                              widget.name,
                                                                          email:
                                                                              widget.email,
                                                                        )),
                                                            (route) => false);
                                                  }).catchError((e) {
                                                    setState(() {
                                                      loading = false;
                                                    });

                                                    print(e);
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
                                  ),
                                  Text(
                                    "Mot de passe oublié ?",
                                    style: GoogleFonts.inter(
                                        color: const Color(0xffFBBC05),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
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
      ),
    );
  }
}

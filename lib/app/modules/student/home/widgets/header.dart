import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';
import 'package:request_track/app/modules/student/home/controllers/home_controller.dart';

class Header extends StatefulWidget {
  final ScrollController controller;
  final String email, name;

  const Header(
      {Key? key,
      required this.controller,
      required this.email,
      required this.name})
      : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(color: Colors.grey),
            child: const Icon(Icons.person),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name,
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.email,
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          customBorder: const CircleBorder(),
          child: const Icon(
            Icons.notifications_none,
            size: 24,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            widget.controller.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);

            controller.enableScroll.value = controller.enableScroll.value ==
                    const AlwaysScrollableScrollPhysics()
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics();
            controller.drawerVisible.value = !controller.drawerVisible.value;
          },
          customBorder: const CircleBorder(),
          child: Icon(
            controller.drawerVisible.value ? Icons.close : Remix.menu_5_fill,
          ),
        ),
      ],
    );
  }
}

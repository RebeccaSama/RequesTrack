import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool visibleTrailing;
  final bool selected;
  const DrawerTile(
      {Key? key,
      required this.selected,
      required this.title,
      required this.icon,
      required this.visibleTrailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? const Color(0xffEEEEEE) : Colors.transparent),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500),
          ),
          const Spacer(),
          Visibility(
            visible: visibleTrailing,
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xffA709AA)),
              child: Text(
                "02",
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}

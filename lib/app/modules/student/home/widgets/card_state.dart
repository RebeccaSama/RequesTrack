import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardState extends StatelessWidget {
  final String number, text;
  final Color color, backgroundColor;
  const CardState(
      {Key? key,
      required this.number,
      required this.text,
      required this.color,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                number,
                style: GoogleFonts.inter(
                    fontSize: 24, fontWeight: FontWeight.w600, color: color),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 12, fontWeight: FontWeight.w300, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

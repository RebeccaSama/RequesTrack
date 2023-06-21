import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowInfo extends StatelessWidget {
  final String item, value;
  final Color? color;
  const RowInfo({Key? key, required this.item, required this.value, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          item,
          style: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w500, color: color),
          ),
        )
      ],
    );
  }
}

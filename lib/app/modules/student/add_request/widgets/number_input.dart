import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/utils/numeric_range_formatter.dart';

class NumberInput extends StatelessWidget {
  final String title;
  final Function(String)? onChanged;
  const NumberInput({Key? key, required this.title, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xffEEEEEE))),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 55,
              padding:
                  const EdgeInsets.only(left: 8, top: 6, right: 8, bottom: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                        color: Colors.black38,
                        fontSize: 9,
                        fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      scrollPadding: EdgeInsets.zero,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      keyboardType: TextInputType.number,
                      inputFormatters: [NumericRangeFormatter(min: 0, max: 20)],
                      onChanged: onChanged,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          contentPadding: EdgeInsets.zero),
                    ),
                  )
                ],
              ),
            )),
            Container(
              width: 35,
              height: 55,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Text(
                "/ 20",
                style: GoogleFonts.inter(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/modules/student/home/widgets/card_state.dart';

class StateRequest extends StatelessWidget {
  const StateRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Toutes vos requêtes en",
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 120,
                height: 48,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: ["2021 - 2022", "2020 - 2021", "2019 - 2020"]
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ))
                        .toList(),
                    value: "2021 - 2022",
                    hint: const Text("Quartier"),
                    isExpanded: true,
                    onChanged: (String? value) {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              CardState(
                  number: "03",
                  text: "Requêtes en brouillon",
                  color: Colors.black,
                  backgroundColor: Color(0xffDEE14F)),
              SizedBox(
                width: 14,
              ),
              CardState(
                  number: "03",
                  text: "Requêtes en brouillon",
                  color: Colors.white,
                  backgroundColor: Color(0xffC0764C)),
              SizedBox(
                width: 14,
              ),
              CardState(
                  number: "03",
                  text: "Requêtes en brouillon",
                  color: Colors.white,
                  backgroundColor: Color(0xff499D66))
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilRequest extends StatelessWidget {
  Color color;
  ProfilRequest({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/profil.png"))),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Angue Mba  Argentine",
                    style: GoogleFonts.inter(
                        fontSize: 12, fontWeight: FontWeight.w300)),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Genie Info - TIC - Niveau 5",
                  style: GoogleFonts.inter(
                      fontSize: 11, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.upload_file,
                        color: color,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "Contestation de note de CC en Mecanique des fluides",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

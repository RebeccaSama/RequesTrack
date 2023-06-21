import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:request_track/app/common/contest_admin_template.dart';
import 'package:request_track/app/modules/secretary/search_request.dart';

class RequestListSecretary extends StatelessWidget {
  const RequestListSecretary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  customBorder: const CircleBorder(),
                  child: const Icon(Icons.arrow_back_ios)),
              title: Text(
                "Requêtes soumises",
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: const Icon(
                    Icons.notifications_none,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SearchRequest(),
                  const SizedBox(
                    height: 24,
                  ),
                  ListView.separated(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => 
                      const ContestAdminTemplate(),
                      separatorBuilder: (context, _) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: 10),
                ],
              ),
            )),
      ),
    );
  }
}

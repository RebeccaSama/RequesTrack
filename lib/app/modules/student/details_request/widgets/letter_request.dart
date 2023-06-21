import 'package:flutter/material.dart';

class LetterRequest extends StatefulWidget {
  const LetterRequest({Key? key}) : super(key: key);

  @override
  State<LetterRequest> createState() => _LetterRequestState();
}

class _LetterRequestState extends State<LetterRequest> {
  String type = "manuscrit";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.21)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(
                  Icons.file_copy,
                  color: Color.fromRGBO(0, 0, 0, 0.21),
                ),
                const SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          type =
                              type == "manuscrit" ? "electronic" : "manuscrit";
                        });
                      },
                      child: const Text("Lettre de la requête",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        type == "manuscrit"
                            ? "Texte en dur"
                            : "Texte dans 2 documents joins",
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14))
                  ],
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
            child: type == "manuscrit"
                ? const Text(
                    """Aliquip cillum anim do ad magna Lorem et cupidatat consequat aliquip ut. Aute duis ea velit adipisicing enim 
pariatur tempor aliqua officia enim veniam nostrud. Consequat elit duis exercitation consequat. Ea consectetur aliqua 
laboris in reprehenderit. Esse veniam sit eu anim Lorem sunt.Dolore eiusmod esse ea nisi cillum cillum eiusmod tempor 
minim. Adipisicing anim dolore mollit ullamco enim laboris ad duis. Nulla officia magna anim laboris ullamco laboris 
proident eiusmod et duis enim Lorem incididunt. Laborum deserunt in irure quis sunt consectetur aliqua adipisicing 
aute anim aute et. Aliquip adipisicing duis voluptate magna Lorem. Aute duis deserunt nisi id ex laboris fugiat aute 
fugiat ex aliqua.Eu ipsum dolore culpa velit sint nostrud cillum ex aliquip. Pariatur nulla irure excepteur aliquip 
reprehenderit magna eiusmod occaecat. Quis incididunt deserunt deserunt eiusmod quis et labore fugiat adipisicing. 
Laboris officia voluptate esse mollit laboris exercitation. Ut ea eu proident do cupidatat non anim occaecat. Labore 
Lorem eiusmod pariatur adipisicing aute proident aliqua et Lorem duis. Consectetur incididunt non do sit incididunt 
occaecat sit aute.""",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 2,
                        fontStyle: FontStyle.italic),
                  )
                : GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: List.generate(6, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 0.21)),
                        ),
                      );
                    }),
                  ),
          )
        ],
      ),
    );
  }
}

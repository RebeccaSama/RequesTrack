import 'package:flutter/material.dart';

class ListPuce extends StatelessWidget {
  final String title, subtitle;
  final FontWeight fontWeight;
  final double size;
  final Color? color;
  final bool twice;
  const ListPuce(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.fontWeight = FontWeight.w800,
      this.size = 10,
      this.twice = false,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          const Icon(Icons.control_point),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: twice ? color : null,
                    fontStyle: FontStyle.italic),
              )),
          const Spacer(),
          Text(
            subtitle,
            style:
                TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
          )
        ],
      ),
    );
  }
}

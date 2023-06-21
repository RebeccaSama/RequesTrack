import 'package:flutter/material.dart';

class Mark extends StatelessWidget {
  final String title, subtitle;
  final double size;
  final FontWeight weight;
  final IconData icon;
  const Mark(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.size = 12,
      this.weight = FontWeight.w500,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic),
            )),
        const Spacer(),
        Text(
          subtitle,
          style: TextStyle(fontSize: size, fontWeight: weight),
        )
      ],
    );
  }
}

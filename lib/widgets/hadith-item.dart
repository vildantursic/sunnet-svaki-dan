import 'package:flutter/material.dart';
import 'package:sunnet_svaki_dan/models/hadith.dart';

class HadithItem extends StatelessWidget {
  final HadithModel hadith;
  final bool daily;

  const HadithItem({super.key, required this.hadith, this.daily = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'images/decorate-top.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              Text(
                hadith.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                hadith.body,
              ),
              const SizedBox(height: 10),
              Text(
                hadith.carrier,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.teal,
                ),
              )
            ],
          ),
        ),
        Image.asset(
          daily ? 'images/decorate-daily.png' : 'images/decorate-bottom.png',
          width: MediaQuery.of(context).size.width / 1.2,
        ),
      ],
    );
  }
}

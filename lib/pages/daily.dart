import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunnet_svaki_dan/models/hadith.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  HadithModel _hadith = HadithModel("", "", "", "");
  bool isGenerated = false;

  _readJson() async {
    final String response = await rootBundle.loadString('storage/hadith.json');
    final data = await json.decode(response) as List;
    setState(() {
      final list =
          data.map((dataItem) => HadithModel.fromJson(dataItem)).toList();
      _hadith = list[Random().nextInt(list.length - 1)];
      isGenerated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hadis Dana"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/decorate-top.png',
                width: MediaQuery.of(context).size.width / 2),
            !isGenerated
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
                    child: Column(children: <Widget>[
                      Text(
                        'Ucini svoj dan potpunim sa slijedjenjem sunneta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      FloatingActionButton.extended(
                        label: const Text("Moj danasnji sunnet"),
                        onPressed: () {
                          _readJson();
                        },
                      )
                    ]),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          _hadith.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _hadith.body,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _hadith.carrier,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.teal,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
            Image.asset('images/decorate-daily.png',
                width: MediaQuery.of(context).size.width / 1.2),
          ],
        ),
      ),
    );
  }
}

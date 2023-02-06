import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunnet_svaki_dan/models/hadith.dart';
import 'package:sunnet_svaki_dan/widgets/hadith-item.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  HadithModel _hadith = HadithModel("", "", "", "", "");
  bool _isGenerated = false;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _checkDaily();
  }

  _checkDaily() async {
    final prefs = await SharedPreferences.getInstance();
    final List<HadithModel> list = await _getHadith();

    final dailyDate = prefs.getString('dailyDate') ?? "";
    final dailyId = prefs.getString('dailyId') ?? "";

    if (dailyDate != "" && dailyId != "") {
      final daily = DateTime.parse(dailyDate);
      final currentTime = DateTime.now();
      final foundHadith = list.firstWhere((item) => item.id == dailyId);

      setState(() {
        _isGenerated = currentTime.isAfter(daily);
        if (foundHadith.id != "") {
          _hadith = foundHadith;
        }
      });
    }
  }

  _getHadith() async {
    final String response = await rootBundle.loadString('storage/hadith.json');
    final data = await json.decode(response) as List;
    return data.map((dataItem) => HadithModel.fromJson(dataItem)).toList();
  }

  _getDaily() async {
    final prefs = await SharedPreferences.getInstance();
    final list = await _getHadith();

    setState(() {
      _visible = false;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _hadith = list[Random().nextInt(list.length - 1)];
      _isGenerated = true;
      _visible = true;
    });
    prefs.setString("dailyDate", DateTime.now().toString());
    prefs.setString("dailyId", _hadith.id);
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
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: !_isGenerated
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/decorate-top.png',
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Učini svoj dan potpunim slijeđenjem sunneta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 30),
                          FloatingActionButton.extended(
                            label: const Text("Moj današnji sunnet"),
                            onPressed: () {
                              _getDaily();
                            },
                          )
                        ],
                      ),
                    )
                  : HadithItem(
                      hadith: _hadith,
                      daily: true,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

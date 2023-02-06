import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunnet_svaki_dan/models/category.dart';
import 'package:sunnet_svaki_dan/models/hadith.dart';
import 'package:sunnet_svaki_dan/pages/hadith.dart';
import 'package:flutter/services.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.category});

  final CategoryModel category;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<HadithModel> _listOfHadith = [];
  List<String> _likes = [];

  _readJson() async {
    final String response = await rootBundle.loadString('storage/hadith.json');
    final data = await json.decode(response) as List;
    setState(() {
      _listOfHadith = data
          .map((dataItem) => HadithModel.fromJson(dataItem))
          .where((item) => item.category == widget.category.id)
          .toList();
      ;
    });
  }

  _getLikes() async {
    final prefs = await SharedPreferences.getInstance();
    final likes = prefs.getStringList("likes") ?? [];
    setState(() {
      _likes = likes;
    });
  }

  @override
  void initState() {
    super.initState();
    _readJson();
    _getLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Scrollbar(
        child: ListView(
          key: UniqueKey(),
          restorationId: 'hadith_list',
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (var item in _listOfHadith)
              Card(
                key: UniqueKey(),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  leading: Image.asset(
                    _likes.contains(item.id)
                        ? 'images/icons/liked.png'
                        : 'images/icons/unliked.png',
                    width: 30,
                    height: 30,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => HadithPage(
                              category: widget.category,
                              hadith: item,
                            ),
                          ),
                        )
                        .then((val) => {_getLikes()});
                  },
                  title: Text(
                    item.title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

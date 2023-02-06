import 'package:flutter/material.dart';
import 'package:sunnet_svaki_dan/models/category.dart';
import 'package:sunnet_svaki_dan/pages/about.dart';
import 'package:sunnet_svaki_dan/pages/daily.dart';
import 'package:sunnet_svaki_dan/pages/list.dart';
import 'package:sunnet_svaki_dan/pages/practice.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel item;

  const CategoryWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          if (item.type == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DailyPage(),
              ),
            );
          } else if (item.type == 3) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PracticePage(),
              ),
            );
          } else if (item.type == 4) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AboutPage(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListPage(category: item),
              ),
            );
          }
        },
        child: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/icons/${item.id}.png',
                width: 50,
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(item.name),
              )
            ],
          ),
        ),
      ),
    );
  }
}

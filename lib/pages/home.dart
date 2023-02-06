import 'package:flutter/material.dart';
import 'package:sunnet_svaki_dan/models/category.dart';
import 'package:sunnet_svaki_dan/widgets/category-item.dart';

List<CategoryModel> categories = [
  CategoryModel("food", "imageUrl", "Hrana", 1),
  CategoryModel("friends", "imageUrl", "Drustvo", 1),
  CategoryModel("travel", "imageUrl", "Putovanje", 1),
  CategoryModel("clothes", "imageUrl", "Odijevanje", 1),
  CategoryModel("pray", "imageUrl", "Namaz", 1),
  CategoryModel("home", "imageUrl", "Kuca", 1),
  CategoryModel("behavior", "imageUrl", "Ponasanje", 1),
  CategoryModel("daily", "imageUrl", "Hadis dana", 2),
  CategoryModel("practice", "imageUrl", "Praktikuj", 3),
  CategoryModel("about", "imageUrl", "O nama", 4),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 120.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              for (var item in categories)
                Center(
                  child: CategoryWidget(item),
                ),
            ],
          ),
        ),
      )),
    );
  }
}

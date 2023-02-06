import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sunnet_svaki_dan/models/category.dart';
import 'package:sunnet_svaki_dan/models/hadith.dart';
import 'package:flutter_share/flutter_share.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({super.key, required this.category, required this.hadith});

  final HadithModel hadith;
  final CategoryModel category;

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  SMIBool? _bump;

  _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'liking');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('like') as SMIBool;
  }

  void _hitBump() {
    _bump?.change(_bump!.value ? false : true);
  }

  Future<void> share(HadithModel item) async {
    await FlutterShare.share(
        title: item.title,
        text: item.body,
        linkUrl: 'https://sunnet-svaki-dan.com/',
        chooserTitle: item.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/decorate-top.png',
                width: MediaQuery.of(context).size.width / 2),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    Text(
                      widget.hadith.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.hadith.body,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.hadith.carrier,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.teal,
                      ),
                    )
                  ],
                )),
            Image.asset('images/decorate-bottom.png',
                width: MediaQuery.of(context).size.width / 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: _hitBump,
                    child: RiveAnimation.asset(
                      'images/like2.riv',
                      fit: BoxFit.cover,
                      onInit: _onRiveInit,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => share(widget.hadith),
                  child: Image.asset(
                    'images/icons/share.png',
                    width: 40,
                    height: 40,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

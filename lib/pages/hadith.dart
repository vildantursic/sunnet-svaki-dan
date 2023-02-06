import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunnet_svaki_dan/models/category.dart';
import 'package:sunnet_svaki_dan/models/hadith.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sunnet_svaki_dan/widgets/hadith-item.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({super.key, required this.category, required this.hadith});

  final HadithModel hadith;
  final CategoryModel category;

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  SMIBool? _like;
  List<String> _likes = [];

  @override
  void initState() {
    super.initState();
    _getLikes();
  }

  _getLikes() async {
    final prefs = await SharedPreferences.getInstance();
    final likes = prefs.getStringList("likes") ?? [];

    setState(() {
      _likes = likes;
    });
  }

  _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'liking');
    artboard.addController(controller!);
    _like = controller.findInput<bool>('like') as SMIBool;
    if (_likes.contains(widget.hadith.id)) {
      _like?.change(true);
    }
  }

  void _likeHadith(String id) async {
    final prefs = await SharedPreferences.getInstance();

    _like?.change(_like!.value ? false : true);
    if (_likes.contains(id)) {
      setState(() {
        _likes.remove(id);
      });
    } else {
      setState(() {
        _likes.add(id);
      });
    }

    prefs.setStringList("likes", _likes);
  }

  Future<void> share(HadithModel item) async {
    await FlutterShare.share(
      title: item.title,
      text: "${item.title}\n${item.body}",
      linkUrl: 'https://sunnet-svaki-dan.com/',
      chooserTitle: item.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context, true),
        ),
        title: Text(widget.category.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HadithItem(hadith: widget.hadith),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: () => _likeHadith(widget.hadith.id),
                    child: RiveAnimation.asset(
                      'images/like.riv',
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

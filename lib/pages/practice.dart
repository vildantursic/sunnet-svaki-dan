import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  int _counter = 0;
  SMINumber? score;

  _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'stateMachine');
    artboard.addController(controller!);
    score = controller.findSMI('score') as SMINumber;
  }

  void _increaseScore() async {
    for (var i = 0; i < 400; i++) {
      await Future.delayed(const Duration(microseconds: 1000));
      score?.value += 0.1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Praktikuj Hadis"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child: GestureDetector(
                onTap: _increaseScore,
                child: RiveAnimation.asset(
                  'images/level-heart.riv',
                  fit: BoxFit.cover,
                  onInit: _onRiveInit,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 60),
              child: Image.asset('images/decorate-top.png',
                  width: MediaQuery.of(context).size.width / 2),
            ),
            Text(
              'Praktikovao si ukupno ${_counter} hadisa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
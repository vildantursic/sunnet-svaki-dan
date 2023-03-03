import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("O Nama"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/decorate-top.png',
                width: MediaQuery.of(context).size.width / 2),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.teal,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Esselamu Alejkum,\n\n'),
                    TextSpan(
                        text:
                            'Cilj ove aplikacije je da približi sunnet Allahovog poslanika s.a.w.s ljudima i uvede ga u svakodnevni život muslimana.\n'
                            'Kroz aplikaciju možete shvatiti koliko je sunnet već dio vašeg svakodnevnog života ali niste ga svjesni.\n'
                            'Ova aplikacija je tu kako bi vas prisjetila da su to sunneti i povećala vaša dobra djela koja činite u svakodnevnici.\n\n'
                            'Molimo Allaha dž.š. da svakim danom, sljeđenjem sunneta, budemo bliži našem najboljem primjeru Allahovom poslaniku Muhammedu s.a.w.s., Amin.\n\n'),
                    TextSpan(
                      text: '#sunnetsvakidan\n\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'sunnetsvakidan@gmail.com',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'service/surat_service.dart';
import 'model/surat.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'detail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Surat> _surat;

  Future<List<Surat>> loadSurat() async {
    String jsonAddress = await loadSuratAsset();
    final jsonResponse = json.decode(jsonAddress)['daftar_surat'] as List;

    _surat = jsonResponse.map((e) => new Surat.fromJson(e)).toList();
    //  print(_surat);
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: loadSurat(),
          builder: (context, snapshot) {
            if (snapshot == null) {
              return Center(child: new Text("Loading"));
            } else {
              return Center(
                  child: new ListView(
                children:
                    _surat.map((surat) => new SuratWidget(surat)).toList(),
              ));
            }
          }),
    );
  }
}

class SuratWidget extends StatelessWidget {
  final Surat _surat;

  SuratWidget(this._surat);

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new ListTile(
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(_surat.nama, style: new TextStyle(fontSize: 32.0)),
          new Text(_surat.namaArab,
              style: new TextStyle(fontSize: 20.0, fontFamily: 'IsepMisbah')),
        ],
      ),
      subtitle: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(_surat.arti),
          new Text(_surat.jumlahAyat.toString() + ' ayat'),
        ],
      ),
      onTap: () {
        /*
        if (await canLaunch(
            'https://quranku.alfiannaufal.com/index.php?r=site%2Fsurah&noSurah=${_surat.noSurat.toString()}')) {
          launch(
              'https://quranku.alfiannaufal.com/index.php?r=site%2Fsurah&noSurah=${_surat.noSurat.toString()}');
             */
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              surat: _surat,
            ),
          ),
        );
      },
    ));
  }
}

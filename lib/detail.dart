import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/suratdetail.dart';
import 'model/surat.dart';
import 'package:audioplayers/audioplayers.dart';
import 'service/ayat_service.dart';
import 'dart:convert';
import 'service/sharedpref.dart';

class Detail extends StatefulWidget {
  final Surat surat;

  Detail({this.surat});
  _DetailState createState() => _DetailState(this.surat);
}

class _DetailState extends State<Detail> {
  Surat _surat;
  _DetailState(this._surat); //constructor
  List<SuratDetail> _suratdetail = <SuratDetail>[];

  @override
  void initState() {
    super.initState();
    listenForSurat();
  }

  listenForSurat() async {
    var listAyat = await loadAyatAsset(this._surat.noSurat);
    final jsonResponse = json.decode(listAyat)[this._surat.noSurat.toString()];

    for (int i = 1; i <= int.parse(jsonResponse['number_of_ayah']); i++) {
      setState(() {
        _suratdetail.add(new SuratDetail.fromJson(
            jsonResponse, i.toString(), this._surat.noSurat.toString()));
      });
    }

    // stream.listen((surat) => setState(() => _suratdetail.add(surat)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this._surat.nama + ' - ' + this._surat.namaArab + ' '),
      ),
      body: new Center(
          child: new ListView(
        children: _suratdetail.map((surat) => new SuratWidget(surat)).toList(),
      )),
    );
  }
}

class SuratWidget extends StatefulWidget {
  final SuratDetail _suratDetail;

  SuratWidget(this._suratDetail);

  @override
  _SuratWidgetState createState() => _SuratWidgetState(_suratDetail);
}

class _SuratWidgetState extends State<SuratWidget> {
  final SuratDetail _suratDetail;

  double _fontSize;

  _SuratWidgetState(this._suratDetail);

  AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = new AudioPlayer();
    getFontSize().then((value) => setState(() {
          _fontSize = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        elevation: 8,
        child: new ListTile(
            isThreeLine: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: new CircleAvatar(
              child: Text(this._suratDetail.ayat),
            ),

            //POSISI KIRI KITA TAMPILKAN NOMOR AYAT

            title: new Directionality(
              textDirection: TextDirection.rtl,
              child: new Text(
                widget._suratDetail.ayatArab,
                style: new TextStyle(
                    fontSize: _fontSize, fontFamily: 'IsepMisbah'),
                textAlign: TextAlign.right,
              ),
            ),
            subtitle: new Column(children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Terjemahan',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text(
                widget._suratDetail.terjemahan,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.play_arrow_rounded),
                tooltip: 'Play',
                onPressed: () async {
                  await _audioPlayer.play(widget._suratDetail.recitation);
                },
              ),
              /*
              Text(
                'Tafsir',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text(
                widget._suratDetail.tafsir,
                style: TextStyle(fontSize: 18.0),
              ),
              */
            ])));
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:latihan_cpns_dashboard/models/soal.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/dashboard_bloc.dart';
import 'package:latihan_cpns_dashboard/common/common_key.dart';

class DetailSoal2 extends StatefulWidget {
  final String id;
  final String jenis;

  const DetailSoal2({Key key, @required this.id, @required this.jenis})
      : super(key: key);

  @override
  _DetailSoal2State createState() => _DetailSoal2State(id, jenis);
}

class _DetailSoal2State extends State<DetailSoal2> {
  final String id;
  final String jenis;

  _DetailSoal2State(this.id, this.jenis);

  final bloc = DashboardBloc();

  String imgKey;
  Future<File> file;
  String status = '';
  String fileName;
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  bool _isConfirmed = true;
  Soal _unconfirmedSoal = Soal();

  final _controllerSoal = TextEditingController();
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();
  final _controllerD = TextEditingController();
  final _controllerKey = TextEditingController();

  @override
  void initState() {
    print('tes $id');
    bloc.getSoalById(id, jenis);
    super.initState();
  }

  void setTextSoal(Soal soal) {
    _controllerSoal.text = soal.soal;
    _controllerA.text = soal.a;
    _controllerB.text = soal.b;
    _controllerC.text = soal.c;
    _controllerD.text = soal.d;
    _controllerKey.text = soal.jawabanBenar;
    _isConfirmed = soal.isConfirmed == '0' ? true : false;
    imgKey = soal.image;
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  void chooseImage() {
    setState(() {
      // ignore: deprecated_member_use
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget showImage() {
    return Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            chooseImage();
          },
          child: file == null
              ? Image.network(
                  '${common.hostname}/api/image/$imgKey.jpg',
                )
              : FutureBuilder<File>(
                  future: file,
                  builder:
                      (BuildContext context, AsyncSnapshot<File> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        null != snapshot.data) {
                      tmpFile = snapshot.data;
                      base64Image =
                          base64Encode(snapshot.data.readAsBytesSync());
                      return Flexible(
                        child: Image.file(
                          snapshot.data,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (null != snapshot.error) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        width: 250,
                        height: 125,
                        decoration: BoxDecoration(
                            color: Colors.orange[400],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.0, 0.5), //(x,y)
                                blurRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Error Saat Mengambil Gambar',
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(125, 0, 0, 255),
                                  ),
                                ],
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        width: 250,
                        height: 125,
                        decoration: BoxDecoration(
                            color: Colors.orange[400],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.0, 0.5), //(x,y)
                                blurRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Tidak Ada Gambar yang dipilih',
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(125, 0, 0, 255),
                                  ),
                                ],
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      );
                    }
                  },
                ),
        ));
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    fileName = tmpFile.path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DETAIL SOAL'),
        ),
        body: bloc.soalById.isEmpty != null
            ? streamBuilder(bloc.soalById)
            : Container());
  }

  streamBuilder(val) {
    return StreamBuilder(
      stream: val,
      builder: (context, snapshot) {
        _unconfirmedSoal = snapshot.data;
        if (snapshot.hasData) {
          return buildList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  buildList(Soal _unconfirmedSoal) {
    setTextSoal(_unconfirmedSoal);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.yellow[100]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 95,
                    width: 130,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: jenis == 'TIU' ? Colors.redAccent: Colors.blueAccent),
                    child: Center(child: Text(jenis, style: TextStyle(fontSize: 50,  fontWeight: FontWeight.bold, color: Colors.white)))),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Approve ?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      SizedBox(height: 10),
                      ToggleSwitch(
                        minWidth: 90.0,
                        cornerRadius: 20.0,
                        activeBgColor: Colors.cyan,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ['YES', 'NO'],
                        icons: [Icons.check, Icons.close],
                        onToggle: (idx) {
                          _isConfirmed = idx == 0 ? true : false;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: TextField(
                controller: _controllerSoal,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'SOAL',
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ), //SOAL
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _controllerA,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'A',
                    fillColor: Colors.green[200],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ), //A
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _controllerB,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'B',
                    fillColor: Colors.red[200],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ), //B
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _controllerC,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'C',
                    fillColor: Colors.blue[200],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ), //C
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _controllerD,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'D',
                    fillColor: Colors.orange[200],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ), //D
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: _controllerKey,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'JAWABAN BENAR',
                    fillColor: Colors.blueGrey[200],
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ), //JAWABAN BENAR
            showImage(),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      bloc.updateSoalUnconfirmed(
                          context,
                          _unconfirmedSoal.id,
                          jenis,
                          _controllerSoal.text,
                          _controllerA.text,
                          _controllerB.text,
                          _controllerC.text,
                          _controllerD.text,
                          _controllerKey.text,
                          _isConfirmed ? 1 : 0,
                          base64Image,
                          0,
                          0);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'SIMPAN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), // SIMPAN
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    bloc.deleteSoal(
                        context, _unconfirmedSoal.id, _unconfirmedSoal.jenis);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.teal[700],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'HAPUS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ), // HAPUS
          ],
        ),
      ),
    );
  }
}

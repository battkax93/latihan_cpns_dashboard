import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/confirmed_soal_models.dart';
import '../../bloc/dashboard_bloc.dart';

class DetailSoal extends StatefulWidget {
  final ConfirmedSoal soal;
  final int soalIndex;

  const DetailSoal({Key key, @required this.soal, @required this.soalIndex})
      : super(key: key);

  @override
  _DetailSoalState createState() => _DetailSoalState(soal, soalIndex);
}

class _DetailSoalState extends State<DetailSoal> {
  final ConfirmedSoal confirmedSoal;
  final int soalIndex;

  _DetailSoalState(this.confirmedSoal, this.soalIndex);

  final bloc = DashboardBloc();
  Permission permissions;

  String imgKey;
  Future<File> file;
  String status = '';
  String fileName;
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  final _controllerSoal = TextEditingController();
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();
  final _controllerD = TextEditingController();
  final _controllerKey = TextEditingController();

  @override
  void initState() {
    setTextSoal();
    initPlatformState();
    super.initState();
  }

  initPlatformState() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void setTextSoal() {
    _controllerSoal.text = confirmedSoal.data[soalIndex].soal;
    _controllerA.text = confirmedSoal.data[soalIndex].a;
    _controllerB.text = confirmedSoal.data[soalIndex].b;
    _controllerC.text = confirmedSoal.data[soalIndex].c;
    _controllerD.text = confirmedSoal.data[soalIndex].d;
    _controllerKey.text = confirmedSoal.data[soalIndex].jawabanBenar;
    imgKey = confirmedSoal.data[soalIndex].image;
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
                  'http://192.168.100.22/latihan_cpns/api/image/$imgKey.jpg',
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
                      return const Text(
                        'Error Picking Image',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        'No Image Selected',
                        textAlign: TextAlign.center,
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
    return WillPopScope(
        onWillPop: () async {
          print('clear cache');
          imageCache.clear();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('DETAIL SOAL'),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.yellow[100], boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 0.2), //(x,y)
                blurRadius: 0.5,
              ),
            ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                            bloc.updateSoal(
                                context,
                                confirmedSoal,
                                soalIndex,
                                confirmedSoal.data[soalIndex].jenis,
                                _controllerSoal.text,
                                _controllerA.text,
                                _controllerB.text,
                                _controllerC.text,
                                _controllerD.text,
                                _controllerKey.text,
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
                              context,
                              confirmedSoal.data[soalIndex].id,
                              confirmedSoal.data[soalIndex].jenis);
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
          ),
        ));
  }
}

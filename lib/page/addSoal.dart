import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/dashboard_bloc.dart';

class AddSoal extends StatefulWidget {
  @override
  _AddSoalState createState() => _AddSoalState();
}

class _AddSoalState extends State<AddSoal> {
  final bloc = DashboardBloc();

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

  bool isSoalValidate = false;
  bool isAValidate = false;
  bool isBValidate = false;
  bool isCValidate = false;
  bool isDValidate = false;
  bool isKeyValidate = false;

  var jenisSoal;
  var img = 'xyxy';

  List<String> typeNeg = [
    "TIU",
    "TWK",
    "TKP",
  ];

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initPlatformState() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  chooseImage() {
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
        child: FutureBuilder<File>(
          future: file,
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                null != snapshot.data) {
              tmpFile = snapshot.data;
              base64Image = base64Encode(snapshot.data.readAsBytesSync());
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
      ),
    );
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    fileName = tmpFile.path.split('/').last;
  }

  validation(){
    if(jenisSoal==null){
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('JENIS SOAL BELUM DIPILIH !'),
          backgroundColor: Colors.red,
        ));
      }
    }

  bool validateTextField() {
    _controllerSoal.text.isEmpty ? isSoalValidate = false : isSoalValidate = true;
    _controllerA.text.isEmpty ? isAValidate = false : isAValidate = true;
    _controllerB.text.isEmpty ? isBValidate = false : isBValidate = true;
    _controllerC.text.isEmpty ? isCValidate = false : isCValidate = true;
    _controllerD.text.isEmpty ? isDValidate = false : isDValidate = true;
    _controllerKey.text.isEmpty ? isKeyValidate = false : isKeyValidate = true;

    bool isConfirm = true;
    var checkValidate=[isSoalValidate,isAValidate,isBValidate,isCValidate,isDValidate,isKeyValidate];

    for(var i=0;i<checkValidate.length;i++){
      print(checkValidate[i]);
      if(checkValidate[i]=false){
        setState(() {
          isConfirm = false;
        });
      }
    }

    if(isConfirm) {
      save();
    } else {
      print('error');
    }
  }

  save(){
    print(' cek gmbr $base64Image');
    var _soal = _controllerSoal.text;
    var _a = _controllerA.text;
    var _b = _controllerB.text;
    var _c = _controllerC.text;
    var _d = _controllerD.text;
    var _key = _controllerKey.text;
    bloc.addNewSoal(context, jenisSoal, _soal, _a, _b, _c,
        _d, _key, base64Image, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                width: double.infinity,
                color: Colors.white,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: jenisSoal == null
                      ? Center(child: Text('PILIH JENIS SOAL'))
                      : Center(child: Text(jenisSoal)),
                  items: <String>['TIU', 'TWK', 'TKP'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: new Text(value)),
                    );
                  }).toList(),
                  onChanged: (_newVal) {
                    setState(() {
                      jenisSoal = _newVal;
                    });
                  },
                ),
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
                      errorText: isSoalValidate ? 'Please enter a Username' : null,
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
                      errorText: isAValidate ? 'Please enter a Username' : null,
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
                      errorText: isBValidate ? 'Please enter a Username' : null,
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
                      errorText: isCValidate ? 'Please enter a Username' : null,
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
                      errorText: isDValidate ? 'Please enter a Username' : null,
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
                      errorText: isKeyValidate ? 'Please enter a Username' : null,
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
                        validateTextField();
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
            ],
          ),
        ),
      ),
    );
  }
}

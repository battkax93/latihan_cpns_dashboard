import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/models/soal_all.dart';
import 'package:latihan_cpns_dashboard/models/soal.dart';
import '../bloc/dashboard_bloc.dart';

class AddSoal extends StatefulWidget {
  @override
  _AddSoalState createState() => _AddSoalState();
}

class _AddSoalState extends State<AddSoal> {
  final bloc = DashboardBloc();
  final _controllerSoal = TextEditingController();
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();
  final _controllerD = TextEditingController();
  final _controllerKey = TextEditingController();
  var jenisSoal;
  var img = 'xyxy';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Wrap(
                  children: [
                    InkWell(
                      onTap: () {
                        var _soal = _controllerSoal.text;
                        var _a = _controllerA.text;
                        var _b = _controllerB.text;
                        var _c = _controllerC.text;
                        var _d = _controllerD.text;
                        var _key = _controllerKey.text;
                        bloc.addNewSoal(context, jenisSoal, _soal, _a, _b, _c, _d, _key, img, 0, 0);
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

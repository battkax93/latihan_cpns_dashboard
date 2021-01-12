import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/models/soal_all.dart';
import 'package:latihan_cpns_dashboard/models/soal.dart';
import '../bloc/dashboard_bloc.dart';

class DetailSoal extends StatefulWidget {
  final Soal soal;
  final int soalIndex;

  const DetailSoal({Key key, @required this.soal, @required this.soalIndex})
      : super(key: key);

  @override
  _DetailSoalState createState() => _DetailSoalState(soal, soalIndex);
}

class _DetailSoalState extends State<DetailSoal> {
  final Soal soal;
  final int soalIndex;

  _DetailSoalState(this.soal, this.soalIndex);

  final bloc = DashboardBloc();
  final _controllerSoal = TextEditingController();
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  final _controllerC = TextEditingController();
  final _controllerD = TextEditingController();
  final _controllerKey = TextEditingController();

  @override
  void initState() {
    print('tes $soalIndex');
    setTextSoal();
    super.initState();
  }

  void setTextSoal() {
    _controllerSoal.text = soal.data[soalIndex].soal;
    _controllerA.text = soal.data[soalIndex].a;
    _controllerB.text = soal.data[soalIndex].b;
    _controllerC.text = soal.data[soalIndex].c;
    _controllerD.text = soal.data[soalIndex].d;
    _controllerKey.text = soal.data[soalIndex].jawabanBenar;
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
                        bloc.updateSoal(
                            context,
                            soal,
                            soalIndex,
                            soal.data[soalIndex].jenis,
                            _controllerSoal.text,
                            _controllerA.text,
                            _controllerB.text,
                            _controllerC.text,
                            _controllerD.text,
                            _controllerKey.text,
                            'xsxsx',
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
                      bloc.deleteSoal(context, soal.data[soalIndex].id, soal.data[soalIndex].jenis);
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/models/soal_all.dart';
import '../bloc/dashboard_bloc.dart';

class DetailSoal extends StatefulWidget {

  final soalAllModel soalAll;
  final int soalIndex;

  const DetailSoal({Key key,@required this.soalAll, @required this.soalIndex}) : super(key: key);



  @override
  _DetailSoalState createState() => _DetailSoalState(soalAll, soalIndex);
}

class _DetailSoalState extends State<DetailSoal> {

  final soalAllModel soalAll;
  final int soalIndex;

  _DetailSoalState(this.soalAll, this.soalIndex);

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

  void setTextSoal(){
    _controllerSoal.text = soalAll.soalData[soalIndex].soal;
    _controllerA.text = soalAll.soalData[soalIndex].a;
    _controllerB.text = soalAll.soalData[soalIndex].b;
    _controllerC.text = soalAll.soalData[soalIndex].c;
    _controllerD.text = soalAll.soalData[soalIndex].d;
    _controllerKey.text = soalAll.soalData[soalIndex].jawabanBenar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL SOAL'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.yellow[100],
            boxShadow: [
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
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
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
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
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
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
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
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
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
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
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
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ), //JAWABAN BENAR
              Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      print('press simpan');
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

            ],
          ),
        ),
      ),
    );
  }


}

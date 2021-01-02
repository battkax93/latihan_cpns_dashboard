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

  @override
  void initState() {
    print('tes $soalIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL SOAL'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(soalAll.soalData[soalIndex].soal),
              Text(soalAll.soalData[soalIndex].a),
              Text(soalAll.soalData[soalIndex].b),
              Text(soalAll.soalData[soalIndex].c),
              Text(soalAll.soalData[soalIndex].d)
            ],
          ),
        ),
      ),
    );
  }


}

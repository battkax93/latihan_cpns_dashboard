import 'package:flutter/material.dart';
import '../bloc/dashboard_bloc.dart';
import 'detail_page/confirmedSoal.dart';
import 'detail_page/unconfirmedSoal.dart';

class ViewSoal extends StatefulWidget {
  final String jenisSoal;

  const ViewSoal({Key key, @required this.jenisSoal}) : super(key: key);

  @override
  _ViewSoalState createState() => _ViewSoalState(jenisSoal);
}

class _ViewSoalState extends State<ViewSoal> {
  final String jenisSoal;

  _ViewSoalState(this.jenisSoal);

  var countSoal;
  final bloc = DashboardBloc();

  @override
  void initState() {
    print(jenisSoal);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  checkReturn(BuildContext ctx, int value) {
    if (value == 1) {
      bloc.showCommonDialog(context, 'SUKSES MENGHAPUS SOAL');
      setState(() {
        bloc.fetchAllSoal(jenisSoal);
      });
    } else if (value == 2) {
      bloc.showCommonDialog(context, 'GAGAL MENGHAPUS SOAL');
    } else if (value == 3) {
      bloc.showCommonDialog(context, 'SUKSES UPDATE SOAL');
      setState(() {
        bloc.fetchAllSoal(jenisSoal);
      });
    } else if (value == 4) {
      bloc.showCommonDialog(context, 'GAGAL UPDATE SOAL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child:  Scaffold(
                appBar: AppBar(
                  title: Text('SOAL $jenisSoal'),
                  bottom: TabBar(
                    tabs: [Tab(text: 'CONFIRMED'), Tab(text: 'UNCONFIRMED')],
                  ),
                ),
                body: TabBarView(
                  children: [
                    ConfirmedSoalView(jenisSoal: jenisSoal),
                    UnconfirmedSoalView(jenisSoal: jenisSoal)
                  ],
                )
            ),
          ),
    );
  }
}

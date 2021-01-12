import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/models/soal_all.dart';
import 'package:latihan_cpns_dashboard/models/soal.dart';
import '../bloc/dashboard_bloc.dart';
import 'package:latihan_cpns_dashboard/page/detailSoal.dart';

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
    bloc.fetchAllSoal(jenisSoal);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SOAL $jenisSoal')),
      body: new StreamBuilder(
        stream: bloc.allSoal,
        builder: (context, AsyncSnapshot<Soal> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Soal> snapshot) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.green,
          padding: const EdgeInsets.all(10),
          child: Center(
              child: Text(
            'jumlah soal ${snapshot.data.data.length}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  print(i);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailSoal(
                                soal: snapshot.data,
                                soalIndex: i,
                              ))).then((value) {
                    if (value == 1) {
                      setState(() {
                        bloc.fetchAllSoal(jenisSoal);
                      });
                    } else {
                      print('gagal');
                    }
                  });
                },
                child: Container(
                  height: 70,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.yellow[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 0.2), //(x,y)
                          blurRadius: 0.5,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          '$i',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.redAccent,
                        padding: const EdgeInsets.all(28),
                      ), //id
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            snapshot.data.data[i].soal,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ), //soal
                    ],
                  ),
                ),
              );
            },
          ),
          /*child: GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.soalData.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (BuildContext context, int i) {
                return GridTile(
                  child: InkResponse(
                    enableFeedback: true,
                    child: new Padding(
                      padding: EdgeInsets.all(3),
                      child: new ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
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
                              '${snapshot.data.soalData[i].soal}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),*/
        ),
      ],
    );
  }
}

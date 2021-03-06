import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/bloc/dashboard_bloc.dart';
import 'package:latihan_cpns_dashboard/models/list_soal_confirmed_models.dart';
import 'package:latihan_cpns_dashboard/page/detail_page/detail_soal.dart';

class ConfirmedSoalView extends StatefulWidget {
  final String jenisSoal;

  ConfirmedSoalView({Key key, this.jenisSoal}) : super(key: key);

  @override
  _ConfirmedSoalViewState createState() => _ConfirmedSoalViewState(jenisSoal);
}

class _ConfirmedSoalViewState extends State<ConfirmedSoalView> with AutomaticKeepAliveClientMixin<ConfirmedSoalView> {
  final String jenisSoal;
  _ConfirmedSoalViewState(this.jenisSoal);

  final bloc = DashboardBloc();

  @override
  void initState() {
    print(jenisSoal);
    bloc.fetchAllSoal(jenisSoal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.allSoal,
      builder: (context, AsyncSnapshot<list_soal_confirmed> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<list_soal_confirmed> snapshot) {
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
                          builder: (context) => DetailSoal2(
                            id: snapshot.data.data[i].id,
                            jenis: snapshot.data.data[i].jenis,
                          ))).then((value) {
                    setState(() {
                      bloc.checkReturn(context,value,widget.jenisSoal);
                    });
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
                      Stack(
                        children: [
                          Container(
                            child: SizedBox(
                              width: 14,
                              height: 14,
                            ),
                            color: Colors.redAccent,
                            padding: const EdgeInsets.all(28),
                          ), //id
                          Container(
                            child: Text(
                              '${i+1}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: const EdgeInsets.all(28),
                          ),
                        ],
                      ),
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
                      InkWell(
                        child: Container(
                          child:Icon(Icons.delete, color: Colors.black26,),
                          padding: const EdgeInsets.all(10),
                        ),
                        onTap: (){
                          bloc.deleteSoal2(context, snapshot.data.data[i].id, widget.jenisSoal).then((value) {
                            if(value){
                              setState(() {
                                bloc.fetchAllSoal(jenisSoal);
                              });
                            }
                          });
                        },
                      ), //id
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}

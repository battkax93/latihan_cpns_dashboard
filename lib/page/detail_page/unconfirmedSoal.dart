import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/models/list_soal_models.dart';
import 'package:latihan_cpns_dashboard/bloc/dashboard_bloc.dart';
import 'package:latihan_cpns_dashboard/page/detail_page/unconfirmed_detail_soal.dart';


class UnconfirmedSoalView extends StatefulWidget {
  final String jenisSoal;

  UnconfirmedSoalView({Key key, this.jenisSoal}) : super(key: key);

  @override
  _UnconfirmedSoalViewState createState() => _UnconfirmedSoalViewState(jenisSoal);
}

class _UnconfirmedSoalViewState extends State<UnconfirmedSoalView> with AutomaticKeepAliveClientMixin<UnconfirmedSoalView>{
  final String jenisSoal;
  _UnconfirmedSoalViewState(this.jenisSoal);

  final bloc = DashboardBloc();

  @override
  void initState() {
    print(jenisSoal);
    bloc.fetchUnconfirmedSoal(jenisSoal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  new StreamBuilder(
      stream: bloc.unconfirmedSoal,
      builder: (context, AsyncSnapshot<listSoal> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(AsyncSnapshot<listSoal> snapshot) {
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
                    print(value);
                    bloc.checkReturn(context,value,widget.jenisSoal);
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
                            showAlertDialog(context, snapshot.data.data[i].id,jenisSoal);
                            setState(() {
                              bloc.fetchUnconfirmedSoal(jenisSoal);
                            });
                        },
                      ), //delete
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

  void showAlertDialog(BuildContext ctx, String id, String jenisSoal){
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hapus Soal ini ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("HAPUS"),
                onPressed: () {
                  Navigator.of(context).pop();
                  bloc.deleteSoal2(context,id, jenisSoal);
                },
              )
            ],
          );
        }
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}

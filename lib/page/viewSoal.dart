import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/models/soal_all.dart';
import '../bloc/dashboard_bloc.dart';

class ViewSoal extends StatefulWidget {
  @override
  _ViewSoalState createState() => _ViewSoalState();
}

class _ViewSoalState extends State<ViewSoal> {

  final bloc = DashboardBloc();

  @override
  void initState() {
    bloc.fetchAllSoal();
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
      body: new StreamBuilder(
        stream: bloc.allSoal,
        builder: (context, AsyncSnapshot<soalAllModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<soalAllModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.soalData.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                    width: 125,
                    height: 125,
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
        });
  }
}


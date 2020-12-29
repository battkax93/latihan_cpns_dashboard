import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/page/viewSoal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LATIHAN CPNS DASHBOARD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://192.168.100.22/latihan_cpns/asset/background.jpg"),
                  fit: BoxFit.cover)),
          child: dashBoard(title: 'LATIHAN CPNS DASHBOARD'),
        ));
  }
}

class dashBoard extends StatefulWidget {
  dashBoard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    // bloc.fetchCountSoal('TIU', context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 250,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
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
                        'ADD SOAL',
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSoal()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 250,
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
                        'VIEW SOAL',
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    // bloc.fetchCountSoal('TIU', context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 250,
                    height: 125,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
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
                        'SETTING',
                        style: TextStyle(
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 30,
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
    );
  }
}

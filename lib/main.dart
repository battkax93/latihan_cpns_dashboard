import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/page/setting_page.dart';
import 'package:latihan_cpns_dashboard/page/viewSoal.dart';
import 'package:latihan_cpns_dashboard/page/addSoal.dart';
import 'package:latihan_cpns_dashboard/bloc/dashboard_bloc.dart';
import 'common/common_key.dart';

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
                      "${common.hostname}/asset/background.jpg"),
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

  final bloc = DashboardBloc();
  final _controllerPass = TextEditingController();
  var passwordVisible = true;
  var login = false;

  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.transparent,
      body: loginView()
    );
  }

  checkLogin(BuildContext ctx, String pass) async {
    if (_controllerPass.text.isEmpty) {
      bloc.showCommonDialog(ctx, 'BELUM MEMASUKAN PASSWORD');
    } else {
      login = await bloc.login(ctx, pass);
    }
  }

  loginView(){
    return Center(
      child: Container(
        width: 250,
        height: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue[200]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerPass,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'PASSWORD',
                  suffixIcon:  IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible ? true : false;
                        });
                        }
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        checkLogin(context, _controllerPass.text);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.orange[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'MASUK',
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
    );
  }

}

class MainMenu extends StatelessWidget {

  final bloc = DashboardBloc();

  void changePage(BuildContext context, String jenisSoal){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewSoal(
              jenisSoal: jenisSoal,
            )));
  }

  void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: 300,
              height: 450,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'PILIH JENIS SOAL',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      InkWell(
                        onTap: () {
                          changePage(context, 'TIU');
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 75,
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
                              'TIU',
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
                  ),  //TIU
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      InkWell(
                        onTap: () {
                          changePage(context, 'TWK');
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
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
                              'TWK',
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
                  ),  //TWK
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      InkWell(
                        onTap: () {
                          changePage(context, 'TKP');
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
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
                              'TKP',
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
                  ),  //TKP
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LATIHAN CPNS DASHBOARD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('LATIHAN CPNS DASHBOARD')),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "http://192.168.100.22/latihan_cpns/asset/background.jpg"),
                    fit: BoxFit.cover)),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddSoal(
                                    ))).then((value) {
                              if(value==1){
                                bloc.showCommonDialog(context, 'SUKSES MENGUPLOAD SOAL');
                              } else if(value==0){
                                bloc.showCommonDialog(context, 'GAGAL MENGUPLOAD SOAL');
                              }
                            });
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
                    ), //ADD
                    Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(context);
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
                    ), //VIEW
                    Wrap(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingPage(
                                    ))).then((value) {
                              if(value==1){
                                bloc.showCommonDialog(context, 'SUKSES MENGUPDATE SETTING');
                              } else if(value==0){
                                bloc.showCommonDialog(context, 'GAGAL MENGUPDATE SETTING');
                              }
                            });
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
                    ), //SETTING
                  ],
                ),
              ),
          ),
        ));

  }
}

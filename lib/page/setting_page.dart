import 'package:flutter/material.dart';
import 'package:latihan_cpns_dashboard/bloc/dashboard_bloc.dart';
import 'package:latihan_cpns_dashboard/models/setting_model.dart';
import 'package:toggle_switch/toggle_switch.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final bloc = DashboardBloc();
  int isMaintenance;
  int isContainAds;
  int isApproveAdd;

  @override
  void initState() {
    bloc.getSetting();
    super.initState();
  }

  setvalue(SettingModels settingModels){
    isMaintenance = int.parse(settingModels.isMaintenance);
    isContainAds = int.parse(settingModels.isContainAds);
    isApproveAdd = int.parse(settingModels.isApproveAdd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SETTING'),
        ),
        body: bloc.settingValue.isEmpty != null
            ? streamBuilder(bloc.settingValue)
            : Container());
  }

  streamBuilder(val) {
    return StreamBuilder(
      stream: val,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  buildList(SettingModels settingModels){
    setvalue(settingModels);
    return Container(
      color: Colors.yellow[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sedang dalam Pengembangan ?',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                  SizedBox(height: 10),
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: int.parse(settingModels.isMaintenance) == 1 ? 0:1,
                    labels: ['YA', 'TIDAK'],
                    icons: [Icons.check, Icons.close],
                    onToggle: (idx) {
                      isMaintenance = idx == 0 ? 1 : 0;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Izinkan Memunculkan Iklan ?',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                  SizedBox(height: 10),
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: int.parse(settingModels.isContainAds) == 1 ? 0:1,
                    labels: ['YA', 'TIDAK'],
                    icons: [Icons.check, Icons.close],
                    onToggle: (idx) {
                      isContainAds = idx == 0 ? 1 : 0;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Izinkan Menambahkan Soal ?',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                  SizedBox(height: 10),
                  ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColor: Colors.cyan,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: int.parse(settingModels.isApproveAdd) == 1 ? 0:1 ,
                    labels: ['YA', 'TIDAK'],
                    icons: [Icons.check, Icons.close],
                    onToggle: (idx) {
                      isApproveAdd = idx == 0 ? 1 : 0;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 250,
              margin: EdgeInsets.only(bottom: 10),
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {
                      bloc.updateSetting(context, isMaintenance, isContainAds, isApproveAdd);
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
          ],
        ),
      ),
    );
  }
}

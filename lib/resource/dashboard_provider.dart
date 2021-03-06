import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:latihan_cpns_dashboard/models/list_soal_confirmed_models.dart';
import 'package:latihan_cpns_dashboard/models/setting_model.dart';
import 'dart:convert';
import '../models/confirmed_soal_models.dart';
import '../models/soal.dart';
import '../models/list_soal_unconfirmed_models.dart';
import 'package:latihan_cpns_dashboard/common/common_key.dart';

class DashboardProvider {
  Client client = Client();
  final endPoint = "${common.hostname}/api";
  final confirmedSoalKey = "soal.php";
  final unconfirmedSoalKey = "soal2.php";
  final soalByIdKey = "getSoalbyId.php";
  final deleteSoalKey = "hapusSoal.php";
  final updateSoalKey = "update.php";
  final addSoalKey = "addSoal.php";
  final hitungSoalKey = "hitungSoal.php";
  final getSettingKey = "getSetting.php";
  final updateSettingKey = "updateSetting.php";
  final loginKey = "login.php";

  Future<bool>login(BuildContext ctx, String pass) async {
    var _url = '$endPoint/$loginKey?pass=$pass';
    final _res = await client.get(_url);
    print(_res.body);
    if(_res.body.contains('true')){
      return true;
    } else {
      return false;
    }
  }

  Future<list_soal_confirmed> fetchAllConfirmedSoal(String jenisSoal) async {
    print('run fetchAllSoal $jenisSoal');
    var _url = '$endPoint/$confirmedSoalKey?jenis=$jenisSoal';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      return list_soal_confirmed.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  Future<list_soal_unconfirmed> fetchAllUnconfirmedSoal(
      String jenisSoal) async {
    print('run fetchUnconfirmed $jenisSoal');
    var _url = '$endPoint/$unconfirmedSoalKey?jenis=$jenisSoal';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      return list_soal_unconfirmed.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  Future<Soal> getSoalById(String id, String jenisSoal) async {
    print('run getSoalById $jenisSoal');
    var _url = '$endPoint/$soalByIdKey?id=$id&jenis=$jenisSoal';
    final res = await client.get(_url);
    print(_url);
    print(res.body);
    if (res.statusCode == 200) {
      return Soal.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  updateSoal(
      BuildContext ctx,
      ConfirmedSoal soalAll,
      int idx,
      String jenis,
      String soal,
      String a,
      String b,
      String c,
      String d,
      String jawaban,
      String img,
      int bnr,
      int slh) async {
    var _url = '$endPoint/$updateSoalKey';
    var _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var _body = jsonEncode(<String, String>{
      'id': soalAll.data[idx].id,
      'jenis': jenis,
      'soal': soal,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      'jawaban_benar': jawaban,
      'is_confirmed': 1.toString(),
      'image': img,
      'benar': bnr.toString(),
      'salah': slh.toString(),
    });
    print(_body);
    var res = await client.put(_url, headers: _headers, body: _body);
    if (res.body.contains('true')) {
      print('${res.body}');
      Navigator.pop(ctx, 3);
    } else {
      print('${res.body}');
      Navigator.pop(ctx, 4);
    }
  }

  updateSoalUnconfirmed(
      BuildContext ctx,
      String id,
      String jenis,
      String soal,
      String a,
      String b,
      String c,
      String d,
      String jawaban,
      int isConfirmed,
      String img,
      int bnr,
      int slh) async {
    print('run updateSoalunconfirmed');
    var _url = '$endPoint/$updateSoalKey';
    var _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var _body = jsonEncode(<String, String>{
      'id': id,
      'jenis': jenis,
      'soal': soal,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      'jawaban_benar': jawaban,
      'is_confirmed': isConfirmed.toString(),
      'image': img,
      'benar': bnr.toString(),
      'salah': slh.toString(),
    });
    print(_url);
    print(_body);
    var res = await client.put(_url, headers: _headers, body: _body);
    if (res.body.contains('true')) {
      print('${res.body}');
      Navigator.pop(ctx, 3);
    } else {
      print('${res.body}');
      Navigator.pop(ctx, 4);
    }
  }

  deleteSoal(BuildContext ctx, String id, String jenis) async {
    print(id);
    var _url = '$endPoint/$deleteSoalKey?id=$id&jenis=$jenis';
    final res = await client.get(_url);
    if (res.body.contains('true')) {
      print('${res.body}');
      Navigator.pop(ctx, 1);
    } else {
      Navigator.pop(ctx, 2);
    }
  }

  Future<bool> deleteSoal2(BuildContext ctx, String id, String jenis) async {
    print(id);
    var _url = '$endPoint/$deleteSoalKey?id=$id&jenis=$jenis';
    final res = await client.get(_url);
    if (res.body.contains('true')) {
      return true;
    } else {
      return false;
    }
  }

  Future addNewSoal(
      BuildContext ctx,
      String jenis,
      String soal,
      String a,
      String b,
      String c,
      String d,
      String jawaban,
      String img,
      int bnr,
      int slh) async {
    var _url = '$endPoint/$addSoalKey';
    var _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var _body = {
      'jenis': jenis,
      'soal': soal,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      'jawaban_benar': jawaban,
      'is_confirmed': 1.toString(),
      'img': img,
      'benar': bnr.toString(),
      'salah': slh.toString()
    };
    print(_url);
    print(_body);
    var _res = await client.post(_url, headers: _headers,  body: _body);
    print(_res.body);
    if (_res.body.contains('true')) {
      Navigator.pop(ctx, 1);
    } else {
      Navigator.pop(ctx, 0);
    }
  }

  Future<SettingModels> getSetting() async {
    print('run getSetting');
    var _url = '$endPoint/$getSettingKey';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      print('${res.body}');
      return SettingModels.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  updateSetting(
      BuildContext ctx,
      int isMaintenance,
      int isContainAds,
      int isApproveAdd) async {
    print('run UpdateSetting');
    var _url = '$endPoint/$updateSettingKey';
    var _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var _body = jsonEncode(<String, String>{
      'is_maintenance' : isMaintenance.toString(),
      'is_contain_ads' : isContainAds.toString(),
      'is_approve_add' : isApproveAdd.toString()
    });
    print(_body);
    var res = await client.put(_url, headers: _headers, body: _body);
    if (res.body.contains('true')) {
      print('${res.body}');
      Navigator.pop(ctx);
      Navigator.pop(ctx, 1);
    } else {
      print('${res.body}');
      Navigator.pop(ctx);
      Navigator.pop(ctx, 1);
    }
  }
}

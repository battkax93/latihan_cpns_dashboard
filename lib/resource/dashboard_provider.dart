import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/confirmed_soal_models.dart';
import '../models/unconfirmed_soal_models.dart';
import '../models/list_soal_models.dart';

class DashboardProvider {
  Client client = Client();
  final endPoint = "http://192.168.100.22/latihan_cpns/api";
  final confirmedSoalKey = "soal.php";
  final unconfirmedSoalKey = "soal2.php";
  final soalByIdKey = "getSoalbyId.php";
  final deleteSoalKey = "hapusSoal.php";
  final updateSoalKey = "update.php";
  final addSoalKey = "addSoal.php";
  final hitungSoalKey = "hitungSoal.php";

  Future<ConfirmedSoal> fetchAllSoal(String jenisSoal) async {
    print('run fetchAllSoal $jenisSoal');
    var _url = '$endPoint/$confirmedSoalKey?jenis=$jenisSoal';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      return ConfirmedSoal.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  Future<listSoal> fetchAllUnconfirmedSoal(String jenisSoal) async {
    print('run fetchUnconfirmed $jenisSoal');
    var _url = '$endPoint/$unconfirmedSoalKey?jenis=$jenisSoal';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      return listSoal.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  Future<UnconfirmedSoal> getSoalById(String id, String jenisSoal) async {
    print('run getSoalById $jenisSoal');
    var _url = '$endPoint/$soalByIdKey?id=$id&jenis=$jenisSoal';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      return UnconfirmedSoal.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

  updateSoal( BuildContext ctx,  ConfirmedSoal soalAll,
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
    var _headers= <String, String>{
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
      'is_confirmed':1.toString(),
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

  updateSoalUnconfirmed( BuildContext ctx,
      String id,
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
    print('run updateSoalunconfirmed');
    var _url = '$endPoint/$updateSoalKey';
    var _headers= <String, String>{
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
      'is_confirmed':1.toString(),
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

  deleteSoal(BuildContext ctx, String id, String jenis) async {
    print(id);
    var _url = '$endPoint/$deleteSoalKey?id=$id&jenis=$jenis';
    final res = await client.get(_url);
    if(res.body.contains('true')){
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
    if(res.body.contains('true')){
      return true;
    } else {
      return false;
    }
  }

  Future addNewSoal(BuildContext ctx,
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
    // bloc.showCommonDialog(ctx, 'MENGUPLOAD SOAL');
    var _url = '$endPoint/$addSoalKey';
    var _headers= {
      'Content-Type': 'application/x-www-form-urlencoded',
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
    print(_body);
    var _res = await client.post(_url, body: _body);
    print(_res.body);
    if(_res.body.contains('true')){
      Navigator.pop(ctx,1);
    } else {
      Navigator.pop(ctx,0);
    }
  }

}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../bloc/dashboard_bloc.dart';
import '../models/soal.dart';

class DashboardProvider {
  // final bloc = DashboardBloc();
  Client client = Client();
  final endPoint = "http://192.168.100.22/latihan_cpns/api";
  final soalKey = "soal.php";
  final deleteSoalKey = "hapusSoal.php";
  final updateSoalKey = "update.php";
  final addSoalKey = "addSoal.php";
  final hitungSoalKey = "hitungSoal.php";

  Future<Soal> fetchAllSoal(String jenisSoal) async {
    print('run fetchAllSoal $jenisSoal');
    var _url = '$endPoint/$soalKey?jenis=$jenisSoal';
    final res = await client.get(_url);
    if (res.statusCode == 200) {
      return Soal.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
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

  Future<int> deleteSoal2(BuildContext ctx, String id, String jenis) async {
    print(id);
    var _url = '$endPoint/$deleteSoalKey?id=$id&jenis=$jenis';
    final res = await client.get(_url);
    if(res.body.contains('true')){
      print('${res.body}');
      return 1;
    } else {
      return 0;
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
      'image': img,
      'benar': bnr.toString(),
      'salah': slh.toString()
    };
    var _res = await client.post(_url, body: _body, headers: _headers);
    print(_res.body);
    if(_res.body.contains('true')){
      Navigator.pop(ctx,1);
    } else {
      Navigator.pop(ctx,0);
    }
  }

   updateSoal( BuildContext ctx,  Soal soalAll,
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
    var res = await client.put(_url, headers: _headers, body: _body);
    if (res.body.contains('true')) {
      print('${res.body}');
      Navigator.pop(ctx, 3);
    } else {
      print('${res.body}');
      Navigator.pop(ctx, 4);
    }
  }

}

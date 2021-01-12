import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../bloc/dashboard_bloc.dart';
import '../models/soal.dart';

class DashboardProvider {
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
    // bloc.showDialogLoading(ctx);
    var _url = '$endPoint/$deleteSoalKey?id=$id&jenis=$jenis';
    final res = await client.get(_url);
    if(res.statusCode == 200){
      print('${res.body}');
      Navigator.pop(ctx, 1);
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
    var res = await client.put('$endPoint/$updateSoalKey',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': soalAll.data[idx].id,
        'jenis': jenis,
        'soal': soal,
        'a': a,
        'b': b,
        'c': c,
        'd': d,
        'jawaban_benar': jawaban,
        'image': img,
        'benar': bnr.toString(),
        'salah': slh.toString(),
      }),
    );
    int statusCode = res.statusCode;
    if (statusCode == 200) {
      print('${res.body}');
      Navigator.pop(ctx, 1);
    }
  }

}

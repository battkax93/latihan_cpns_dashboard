import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/soal_all.dart';

class DashboardProvider {
  Client client = Client();
  final endPoint = "http://192.168.100.22/latihan_cpns/api";
  final soalTiuKey = "getAllTiuSoal.php";
  final soalTkpKey = "getAllTkpSoal.php";
  final soalTwkKey = "getAllTwkSoal.php";
  final hitungSoalKey = "hitungSoal.php";

  Future<soalAllModel> fetchAllSoal() async {
    print('run fetchAllSoal');
    var _url = '$endPoint/$soalTwkKey';
    final res = await client.get(_url);
    if(res.statusCode==200){
      return soalAllModel.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }

}



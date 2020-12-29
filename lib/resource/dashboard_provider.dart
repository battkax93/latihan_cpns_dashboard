import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/soal_all.dart';

class DashboardProvider {
  Client client = Client();
  final endPoint = "http://192.168.100.22/latihan_cpns/api";
  final soalAllKey = "getAllTiuSoal.php";

  Future<soalAllModel> fetchAllSoal() async {
    print('run fetchAllSoal');
    String _url = '$endPoint/$soalAllKey';
    final res = await client.get(_url);
    if(res.statusCode==200){
      return soalAllModel.fromJson((jsonDecode(res.body)));
    } else {
      throw Exception(('Failed to get All Soal'));
    }
  }
}


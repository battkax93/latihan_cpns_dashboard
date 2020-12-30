import 'dart:async';
import 'dashboard_provider.dart';
import '../models/soal_all.dart';

class Repository {
  final dashBoardProvider = DashboardProvider();

  //get soal from server
  Future<soalAllModel> fetchAllSoal(String jenisSoal) => dashBoardProvider.fetchAllSoal(jenisSoal);
}

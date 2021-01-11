import 'dart:async';
import 'package:latihan_cpns_dashboard/models/soal.dart';

import 'dashboard_provider.dart';
import '../models/soal_all.dart';

class Repository {
  final dashBoardProvider = DashboardProvider();

  //get soal from server
  Future<Soal> fetchAllSoal(String jenisSoal) => dashBoardProvider.fetchAllSoal(jenisSoal);

  //update soal from server
  updateSoal(
          Soal soalAll,
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
          int slh) =>
      dashBoardProvider.updateSoal(
          soalAll, idx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
}

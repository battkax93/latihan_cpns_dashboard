import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:latihan_cpns_dashboard/models/soal.dart';

import 'dashboard_provider.dart';
import '../models/soal_all.dart';

class Repository {
  final dashBoardProvider = DashboardProvider();

  //get soal from server
  Future<Soal> fetchAllSoal(String jenisSoal) => dashBoardProvider.fetchAllSoal(jenisSoal);

  //hapus soal dari server
  deleteSoal(BuildContext ctx, String id, String jenis) => dashBoardProvider.deleteSoal(ctx, id, jenis);

  Future<int> deleteSoal2(BuildContext ctx, String id, String jenis) => dashBoardProvider.deleteSoal2(ctx, id, jenis);

  //update soal from server
  updateSoal(
          BuildContext ctx,
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
          ctx, soalAll, idx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);

  //add new soal to server
  addNewSoal(BuildContext ctx,
      String jenis,
      String soal,
      String a,
      String b,
      String c,
      String d,
      String jawaban,
      String img,
      int bnr,
      int slh)=> dashBoardProvider.addNewSoal(ctx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
}

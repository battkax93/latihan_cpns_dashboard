import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:latihan_cpns_dashboard/models/list_soal_confirmed_models.dart';
import '../models/confirmed_soal_models.dart';
import '../models/unconfirmed_soal_models.dart';
import '../models/list_soal_unconfirmed_models.dart';
import 'dashboard_provider.dart';

class Repository {
  final dashBoardProvider = DashboardProvider();

  //get soal from server
  Future<UnconfirmedSoal> getSoalbyID(String id, String jenisSoal) => dashBoardProvider.getSoalById(id, jenisSoal);
  Future<list_soal_unconfirmed> fetchUnconfirmedSoal(String jenisSoal) => dashBoardProvider.fetchAllUnconfirmedSoal(jenisSoal);
  Future<list_soal_confirmed> fetchConfirmedSoal(String jenisSoal) => dashBoardProvider.fetchAllConfirmedSoal(jenisSoal);

  //hapus soal dari server
  deleteSoal(BuildContext ctx, String id, String jenis) => dashBoardProvider.deleteSoal(ctx, id, jenis);
  Future<bool> deleteSoal2(BuildContext ctx, String id, String jenis) => dashBoardProvider.deleteSoal2(ctx, id, jenis);

  //update soal from server
  updateSoal(
          BuildContext ctx,
          ConfirmedSoal soal_1,
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
          ctx, soal_1, idx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);

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
      String img,
      int bnr,
      int slh) =>
      dashBoardProvider.updateSoalUnconfirmed(
          ctx, id, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);

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

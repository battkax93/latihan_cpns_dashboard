import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../resource/repository.dart';
import '../models/soal_all.dart';
import '../models/soal.dart';
import '../page/viewSoal.dart';

class DashboardBloc {
  Soal tempSoalAll;
  int isDeleted;

  final _repository = Repository();

  final _soalAllFetcher = PublishSubject<Soal>();

  Observable<Soal> get allSoal => _soalAllFetcher.stream;

  fetchAllSoal(String jenisSoal) async {
    Soal soal = await _repository.fetchAllSoal(jenisSoal);
    if (!_soalAllFetcher.isClosed) _soalAllFetcher.sink.add(soal);
    tempSoalAll = soal;
  }

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
      int slh) async {
    await _repository.addNewSoal(ctx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
  }

  deleteSoal(BuildContext ctx, String id, String jenis) async { await _repository.deleteSoal(ctx, id, jenis);}

  Future<bool> deleteSoal2(BuildContext ctx, String id, String jenis) async {
    showDialogLoading(ctx);
    isDeleted = await _repository.deleteSoal2(ctx, id, jenis);
    if(isDeleted==1){
      Navigator.pop(ctx);
      showCommonDialog(ctx, 'SUKSES MENGHAPUS SOAL');
      return true;
    }else {
      showCommonDialog(ctx, 'GAGAL MENGHAPUS SOAL');
      return true;
    }
  }

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
      int slh) async {
    await _repository.updateSoal(
        ctx, soalAll, idx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
  }

  dispose() {
    _soalAllFetcher.close();
  }

  void showDialogLoading(BuildContext ctx) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: ctx,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              )),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  void showCommonDialog(BuildContext ctx, String txt) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: ctx,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(txt))),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

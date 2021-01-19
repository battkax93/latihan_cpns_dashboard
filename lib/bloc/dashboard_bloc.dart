import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../resource/repository.dart';
import '../models/unconfirmed_soal_models.dart';
import '../models/confirmed_soal_models.dart';
import '../page/viewSoal.dart';

class DashboardBloc {
  ConfirmedSoal tempSoalAll;
  UnconfirmedSoal tempSoalUnconfirmed;
  int isDeleted;

  final _repository = Repository();

  final _soalAllFetcher = PublishSubject<ConfirmedSoal>();
  final _soalUnconfirmedFetcher = PublishSubject<UnconfirmedSoal>();

  Observable<ConfirmedSoal> get allSoal => _soalAllFetcher.stream;
  Observable<UnconfirmedSoal> get unconfirmedSoal => _soalUnconfirmedFetcher.stream;

  fetchAllSoal(String jenisSoal) async {
    ConfirmedSoal _soal = await _repository.fetchAllSoal(jenisSoal);
    if (!_soalAllFetcher.isClosed) _soalAllFetcher.sink.add(_soal);
    tempSoalAll = _soal;
  }

  fetchUnconfirmedSoal(String jenisSoal) async {
    UnconfirmedSoal _soal2 = await _repository.fetchUnconfirmedSoal(jenisSoal);
    if (!_soalUnconfirmedFetcher.isClosed) _soalUnconfirmedFetcher.sink.add(_soal2);
    tempSoalUnconfirmed = _soal2;
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
    var _res = await _repository.deleteSoal2(ctx, id, jenis);
    if(_res){
      showCommonDialog(ctx, 'SUKSES MENGHAPUS SOAL');
      return true;
    } else {
      showCommonDialog(ctx, 'GAGAL MENGHAPUS SOAL');
      return false;
    }
  }

  updateSoal(
      BuildContext ctx,
      ConfirmedSoal soalAll,
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

  updateSoalUnconfirmed(
      BuildContext ctx,
      UnconfirmedSoal soalAll,
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
    await _repository.updateSoalUnconfirmed(
        ctx, soalAll, idx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
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



  checkReturn(BuildContext ctx, int value, String jenisSoal) {
    if (value == 1) {
      showCommonDialog(ctx, 'SUKSES MENGHAPUS SOAL');
      fetchAllSoal(jenisSoal);
    } else if (value == 2) {
      showCommonDialog(ctx, 'GAGAL MENGHAPUS SOAL');
    } else if (value == 3) {
      showCommonDialog(ctx, 'SUKSES UPDATE SOAL');
       fetchAllSoal(jenisSoal);
    } else if (value == 4) {
     showCommonDialog(ctx, 'GAGAL UPDATE SOAL');
    }
  }

  dispose() {
    _soalAllFetcher.close();
    _soalUnconfirmedFetcher.close();
  }


}

import 'package:latihan_cpns_dashboard/models/list_soal_confirmed_models.dart';
import 'package:latihan_cpns_dashboard/models/setting_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../resource/repository.dart';
import '../models/soal.dart';
import '../models/confirmed_soal_models.dart';
import '../models/list_soal_unconfirmed_models.dart';

class DashboardBloc {
  Soal tempUnconfirmedSoal;
  list_soal_unconfirmed tempListSoal;
  list_soal_confirmed tempSoalAll;
  int isDeleted;

  final _repository = Repository();

  final _soalbyId = PublishSubject<Soal>();
  final _soalConfirmedFetcher = PublishSubject<list_soal_confirmed>();
  final _soalUnconfirmedFetcher = PublishSubject<list_soal_unconfirmed>();
  final _settingFetcher = PublishSubject<SettingModels>();

  Observable<Soal> get soalById => _soalbyId.stream;

  Observable<list_soal_confirmed> get allSoal => _soalConfirmedFetcher.stream;

  Observable<list_soal_unconfirmed> get unconfirmedSoal =>
      _soalUnconfirmedFetcher.stream;

  Observable<SettingModels> get settingValue => _settingFetcher.stream;

  getSetting() async {
    SettingModels _setting = await _repository.getSetting();
    if (!_settingFetcher.isClosed) _settingFetcher.sink.add(_setting);
  }

  updateSetting(BuildContext ctx, int isMaintenance, int isContainAds,
      int isApproveAdd) async {
    showDialogLoading(ctx);
    await _repository.updateSetting(
        ctx, isMaintenance, isContainAds, isApproveAdd);
  }

  getSoalById(String id, String jenisSoal) async {
    Soal _soal = await _repository.getSoalbyID(id, jenisSoal);
    if (!_soalbyId.isClosed) _soalbyId.sink.add(_soal);
    tempUnconfirmedSoal = _soal;
  }

  fetchAllSoal(String jenisSoal) async {
    list_soal_confirmed _soal = await _repository.fetchConfirmedSoal(jenisSoal);
    if (!_soalConfirmedFetcher.isClosed) _soalConfirmedFetcher.sink.add(_soal);
  }

  fetchUnconfirmedSoal(String jenisSoal) async {
    list_soal_unconfirmed _soal2 =
        await _repository.fetchUnconfirmedSoal(jenisSoal);
    if (!_soalUnconfirmedFetcher.isClosed)
      _soalUnconfirmedFetcher.sink.add(_soal2);
    tempListSoal = _soal2;
  }

  addNewSoal(BuildContext ctx, String jenis, String soal, String a, String b,
      String c, String d, String jawaban, String img, int bnr, int slh) async {
    if (img == null) img = 'x';
    await _repository.addNewSoal(
        ctx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
  }

  deleteSoal(BuildContext ctx, String id, String jenis) async {
    await _repository.deleteSoal(ctx, id, jenis);
  }

  Future<bool> deleteSoal2(BuildContext ctx, String id, String jenis) async {
    var _res = await _repository.deleteSoal2(ctx, id, jenis);
    if (_res) {
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
      String id,
      String jenis,
      String soal,
      String a,
      String b,
      String c,
      String d,
      String jawaban,
      int isConfirmed,
      String img,
      int bnr,
      int slh) async {
    await _repository.updateSoalUnconfirmed(
        ctx, id, jenis, soal, a, b, c, d, jawaban, isConfirmed, img, bnr, slh);
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
              height: 150,
              width: 150,
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
      transitionDuration: Duration(milliseconds: 400),
      context: ctx,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
              height: 300,
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                txt,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueAccent,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ))),
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
    _settingFetcher.close();
    _soalbyId.close();
    _soalConfirmedFetcher.close();
    _soalUnconfirmedFetcher.close();
  }
}

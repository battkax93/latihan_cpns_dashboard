import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../resource/repository.dart';
import '../models/soal_all.dart';
import '../models/soal.dart';
import '../page/viewSoal.dart';

class DashboardBloc {

  Soal tempSoalAll;

  final _repository = Repository();

  final _soalAllFetcher = PublishSubject<Soal>();

  Observable<Soal> get allSoal => _soalAllFetcher.stream;

  fetchAllSoal(String jenisSoal) async {
    Soal soal = await _repository.fetchAllSoal(jenisSoal);
    if (!_soalAllFetcher.isClosed) _soalAllFetcher.sink.add(soal);
    tempSoalAll = soal;
  }

  updateSoal( Soal soalAll,
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
    await _repository.updateSoal(soalAll, idx, jenis, soal, a, b, c, d, jawaban, img, bnr, slh);
  }

  dispose() {
    _soalAllFetcher.close();
  }

}

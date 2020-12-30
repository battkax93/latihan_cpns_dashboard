import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../resource/repository.dart';
import '../models/soal_all.dart';
import '../page/viewSoal.dart';

class DashboardBloc {

  soalAllModel tempSoalAll;

  final _repository = Repository();

  final _soalAllFetcher = PublishSubject<soalAllModel>();

  Observable<soalAllModel> get allSoal => _soalAllFetcher.stream;

  fetchAllSoal(String jenisSoal) async {
    soalAllModel soalAll = await _repository.fetchAllSoal(jenisSoal);
    if (!_soalAllFetcher.isClosed) _soalAllFetcher.sink.add(soalAll);
    tempSoalAll = soalAll;
  }

  dispose() {
    _soalAllFetcher.close();
  }

}

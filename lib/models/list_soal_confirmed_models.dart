class list_soal_confirmed {
  int code;
  String message;
  List<Data> data;

  list_soal_confirmed({this.code, this.message, this.data});

  list_soal_confirmed.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String jenis;
  String soal;
  String isConfirmed;

  Data({this.id, this.jenis, this.soal, this.isConfirmed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    soal = json['soal'];
    isConfirmed = json['is_confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis'] = this.jenis;
    data['soal'] = this.soal;
    data['is_confirmed'] = this.isConfirmed;
    return data;
  }
}

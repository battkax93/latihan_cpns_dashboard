class UnconfirmedSoal {
  String id;
  String jenis;
  String soal;
  String a;
  String b;
  String c;
  String d;
  String jawabanBenar;
  String image;
  String benar;
  String salah;

  UnconfirmedSoal(
      {this.id,
        this.jenis,
        this.soal,
        this.a,
        this.b,
        this.c,
        this.d,
        this.jawabanBenar,
        this.image,
        this.benar,
        this.salah});

  UnconfirmedSoal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    soal = json['soal'];
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    jawabanBenar = json['jawaban_benar'];
    image = json['image'];
    benar = json['benar'];
    salah = json['salah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis'] = this.jenis;
    data['soal'] = this.soal;
    data['a'] = this.a;
    data['b'] = this.b;
    data['c'] = this.c;
    data['d'] = this.d;
    data['jawaban_benar'] = this.jawabanBenar;
    data['image'] = this.image;
    data['benar'] = this.benar;
    data['salah'] = this.salah;
    return data;
  }
}

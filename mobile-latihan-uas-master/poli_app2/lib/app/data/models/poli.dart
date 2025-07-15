import 'dart:convert';

class PoliData {
  int id;
  String nama;
  String jenis;

  PoliData({required this.id, required this.nama, required this.jenis});
}

class Poli {
  List<PoliData> ListPoli = <PoliData>[];

  Poli(Map<String, dynamic> jsonData) {
    var data = jsonData['data'];

    for (var value in data) {
      var id = value['id'];
      var nama = value['nama'];
      var jenis = value['jenis'];
      ListPoli.add(PoliData(id: id, nama: nama, jenis: jenis));
    }
  }

  factory Poli.fromJson(Map<String, dynamic> jsonData) {
    return Poli(jsonData);
  }
}

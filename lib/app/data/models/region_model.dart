class RegionModel {
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String provinsi;
  final String kodePos;

  RegionModel({
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.kodePos,
  });

  String get fullAddress => "$kelurahan, $kecamatan, $kota, $provinsi";
}

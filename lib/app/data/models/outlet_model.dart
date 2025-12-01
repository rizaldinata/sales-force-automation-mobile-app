class OutletModel {
  final String id;
  final String name;
  final String type;
  final String address;
  final bool isVerified;
  final DateTime createdAt;

  OutletModel({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.isVerified,
    required this.createdAt,
  });
}

class Building {
  final String name;
  final String address;
  final String type;
  final double lat;
  final double lng;
  final int tradePriceWon;
  final int depositWon;
  final int gongsiWon;


  Building({
    required this.name,
    required this.address,
    required this.type,
    required this.lat,
    required this.lng,
    required this.tradePriceWon,
    required this.depositWon,
    required this.gongsiWon,
  });


  factory Building.fromJson(Map<String, dynamic> json) {
    final lat = (json['위도'] as num?);
    final lng = (json['경도'] as num?);
    final trade = (json['주택매매가격(원)'] as num?);

    if (lat == null || lng == null || trade == null) {
      throw FormatException('필수 필드 누락');
    }

    return Building(
      name: (json['단지명'] ?? '정보 없음').toString(),
      address: (json['전체주소'] ?? '').toString(),
      type: (json['주택유형'] ?? '').toString(),
      lat: lat.toDouble(),
      lng: lng.toDouble(),
      tradePriceWon: trade.toInt(),
      depositWon: (json['보증금(원)'] as num? ?? 0).toInt(),
      gongsiWon: (json['공시지가(원)'] as num? ?? 0).toInt(),
    );
  }
}
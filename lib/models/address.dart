class Address {
  Address({
    required this.city,
    required this.district,
    required this.address,
    required this.name,
    required this.phonenum,
    required this.id,
  });

  final String? city;
  final String? district;
  final String? address;
  final String? name;
  final int? phonenum;
  final String? id;

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
      city: json["city"],
      district: json["district"],
      address: json["address"],
      name: json["name"],
      phonenum: json["phonenum"],
      id: json["_id"],
    );
  }

}

class Order {
  Order({
    required this.id,
    required this.userId,
    required this.username,
    required this.total,
    required this.city,
    required this.district,
    required this.address,
    required this.name,
    required this.phonenum,
    required this.paymentMethod,
    required this.items,
  });
  final String? id;
  final String? userId;
  final String? username;
  final double? total;
  final String? city;
  final String? district;
  final String? address;
  final String? name;
  final String? phonenum;
  final String? paymentMethod;
  final List<Item> items;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json["_id"],
      userId: json["userId"],
      username: json["username"],
      total: json["total"],
      city: json["city"],
      district: json["district"],
      address: json["address"],
      name: json["name"],
      phonenum: json["phonenum"],
      paymentMethod: json["payment_method"],
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

}

class Item {
  Item({
    required this.productname,
    required this.quantity,
    required this.price,
  });

  final String? productname;
  final int? quantity;
  final double? price;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      productname: json["productname"],
      quantity: json["quantity"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productname': productname,
      'quantity': quantity,
      'price': price,
    };
  }
}


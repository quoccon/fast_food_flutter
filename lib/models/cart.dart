class Cart {
    Cart({
        required this.productId,
        required this.productname,
        required this.imageproduct,
        required this.price,
        required this.quantity,
        required this.totalOrder,
        required this.id,
    });

    final String? productId;
    final String? productname;
    final String? imageproduct;
    final int? price;
    late int? quantity;
    final int? totalOrder;
    final String? id;

    factory Cart.fromJson(Map<String, dynamic> json){
        return Cart(
            productId: json["productId"],
            productname: json["productname"],
            imageproduct: json["imageproduct"],
            price: json["price"],
            quantity: json["quantity"],
            totalOrder: json["total_order"],
            id: json["_id"],
        );
    }

}

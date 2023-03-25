// ignore_for_file: non_constant_identifier_names

class Product {
  final String product_name;
  final String product_detail;
  final int price;
  final String image;
  final String public_id;
  final String id;

  Product(
      {required this.product_name,
      required this.image,
      required this.price,
      required this.product_detail,
      required this.public_id,
      required this.id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        product_name: json['product_name'],
        image: json['image'],
        price: json['price'],
        product_detail: json['product_detail'],
        public_id: json['public_id'],
        id: json['_id']);
  }
}

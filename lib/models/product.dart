class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final double discountPercentage;

  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.discountPercentage,
    this.isFavorite = false,
  });
}
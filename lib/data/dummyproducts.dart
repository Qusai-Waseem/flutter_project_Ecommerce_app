import '../models/product.dart';

//اذا كان محلي 
final List<Product> dummyProducts = [
  Product(
    id: 1,
    title: 'Gaming Laptop',
    price: 1200,
    description: 'High performance gaming laptop.',
    image: 'lib/asset/images/glaptops.jpg',
    discountPercentage: 10,
  ),
  Product(
    id: 2,
    title: 'Mechanical Keyboard',
    price: 80,
    description: 'RGB mechanical keyboard.',
    image: 'lib/asset/images/keyboard.jpg',
    discountPercentage: 5,
  ),
  Product(
    id: 3,
    title: 'Wireless Mouse',
    price: 35,
    description: 'Ergonomic wireless mouse.',
    image: 'lib/asset/images/wmouse.jpg',
    discountPercentage: 15,
  ),
  Product(
    id: 4,
    title: '16GB RAM',
    price: 60,
    description: 'DDR4 16GB RAM module.',
    image: 'lib/asset/images/rams16.jpg',
    discountPercentage: 8,
  ),
  Product(
    id: 5,
    title: 'SSD 1TB',
    price: 95,
    description: 'Fast NVMe SSD storage.',
    image: 'lib/asset/images/hardssdjpg.jpg',
    discountPercentage: 12,
  ),
];
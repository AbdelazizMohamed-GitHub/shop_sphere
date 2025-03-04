import 'package:shop_sphere/core/utils/app_images.dart';
import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

List<ProductEntity> dummyProducts = [
  ProductEntity(
    id: '1',
    name: 'iPhone 14 Pro',
    description: 'Apple iPhone 14 Pro with A16 Bionic Chip and 48MP Camera.',
    price: 999.99,
    imageUrl: ProductImages.iPhone,
    category: 'Electronics',
    stock: 15,
   
    isFeatured: true, imagesUrl: [],
  ),
  ProductEntity(
    id: '2',
    name: 'Samsung Galaxy S23',
    description: 'Samsung Galaxy S23 with Snapdragon 8 Gen 2 and 120Hz Display.',
    price: 899.99,
    imageUrl: ProductImages.samsung,
    category: 'Electronics',
    stock: 20,
   imagesUrl: [],
    isFeatured: false,
  ),
  ProductEntity(
    id: '3',
    name: 'MacBook Pro 16"',
    description: 'Apple MacBook Pro with M2 Pro Chip and 16GB RAM.',
    price: 2499.99,
    imageUrl: ProductImages.mac,
    category: 'Laptops',
    stock: 10,
   
    isFeatured: true, imagesUrl: [],
  ),
  ProductEntity(
    id: '4',
    name: 'Sony WH-1000XM5',
    description: 'Sony Noise Cancelling Wireless Headphones.',
    price: 349.99,
    imageUrl: ProductImages.sony,
    category: 'Accessories',
    stock: 25,
    
    isFeatured: true, imagesUrl: [],
  ),
  ProductEntity(
    id: '5',
    name: 'Nike Air Max 270',
    description: 'Nike Air Max 270 Running Shoes.',
    price: 129.99,
    imageUrl: ProductImages.nike,
    category: 'Fashion',
    stock: 30,
    
    isFeatured: false, imagesUrl: [],
  ),
  ProductEntity(
    id: '6',
    name: 'Adidas Ultraboost',
    description: 'Adidas Ultraboost 22 Running Shoes.',
    price: 149.99,
    imageUrl: ProductImages.adidas,
    category: 'Fashion',
    stock: 18,
   
    isFeatured: false, imagesUrl: [],
  ),
  ProductEntity(
    id: '7',
    name: 'Apple Watch Series 8',
    description: 'Apple Watch Series 8 with Always-On Retina Display.',
    price: 399.99,
    imageUrl: ProductImages.apple,
    category: 'Wearables',
    stock: 12,
    
    isFeatured: true, imagesUrl: [],
  ),
  ProductEntity(
    id: '8',
    name: 'Logitech MX Master 3',
    description: 'Logitech MX Master 3 Wireless Mouse for Productivity.',
    price: 99.99,
    imageUrl: ProductImages.mouse,
    category: 'Accessories',
    stock: 40,
   
    isFeatured: true, imagesUrl: [],
  ),
  ProductEntity(
    id: '9',
    name: 'Samsung 55" OLED TV',
    description: 'Samsung 55" OLED 4K Smart TV with Quantum Dot Technology.',
    price: 1599.99,
    imageUrl: ProductImages.tv,
    category: 'Home Appliances',
    stock: 8,
    
    isFeatured: false, imagesUrl: [],
  ),
  ProductEntity(
    id: '10',
    name: 'JBL Flip 6',
    description: 'JBL Flip 6 Portable Bluetooth Speaker with Deep Bass.',
    price: 119.99,
    imageUrl: ProductImages.jpl,
    category: 'Audio',
    stock: 35,
    
    isFeatured: true, imagesUrl: [],
  ),
];

import 'dart:core';
import 'package:t_store/features/shop/models/banner_model.dart';
import 'package:t_store/features/shop/models/brand_category_model.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_attribute_model.dart';
import 'package:t_store/features/shop/models/product_category_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';
import 'package:t_store/routes/routes.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import '../features/shop/models/category_model.dart';
import 'package:faker/faker.dart';

class TDummyData {
  ///Baners
  static final List<BannerModel> banners = [
    BannerModel(
        targetScreen: TRoutes.order, active: false, imageUrl: TImages.banner1),
    BannerModel(
        targetScreen: TRoutes.cart, active: true, imageUrl: TImages.banner2),
    BannerModel(
        targetScreen: TRoutes.favourites,
        active: true,
        imageUrl: TImages.banner3),
    BannerModel(
        targetScreen: TRoutes.search, active: true, imageUrl: TImages.banner4),
    BannerModel(
        targetScreen: TRoutes.settings,
        active: true,
        imageUrl: TImages.banner5),
    BannerModel(
        targetScreen: TRoutes.userAddress,
        active: true,
        imageUrl: TImages.banner6),
    BannerModel(
        targetScreen: TRoutes.checkout,
        active: true,
        imageUrl: TImages.banner7),
    BannerModel(
        targetScreen: TRoutes.signIn, active: false, imageUrl: TImages.banner8),
  ];

// Assuming you add the faker package

  Faker faker = Faker();

  // List<ProductModel> generateRandomProducts(int count) {
  //   List<ProductModel> products = [];
  //   int random = Random().nextInt(77) + 1;
  //   int random1 = Random().nextInt(100) + 1;
  //   for (int i = 0; i < count; i++) {
  //     products.add(ProductModel(
  //       id: "00" + random1.toString(),
  //       // Generate random unique ID (using a library like uuid)
  //       stock: Random().nextInt(100) + 1,
  //       // Random stock between 1 and 100
  //       price: Random().nextDouble() * 990 + 10,
  //       // Random price between $10 and $1000
  //       title: faker.sport.name(),
  //       // Generate random product name
  //      /// thumbnail: imageUrls[random - 1],
  //       // Placeholder image URL
  //       productType: ProductType.single.toString(),
  //       isFeatured: true,
  //       sku: "sku",
  //       description: "description",
  //       categoryId: "1",
  //       images: [],
  //     ));
  //   }
  //   return products;
  // }

  // static final List<ProductModel> products1 =
  //     TDummyData().generateRandomProducts(3);
  static final List<ProductModel> products = [
    // ProductModel(id: '001',
    //     stock: 15,
    //     price: 135,
    //     title: 'Green Nike sports shoe',
    //     isFeatured: true,
    //     thumbnail: TImages.productImage1,
    //     description: 'Green Nike sports shoe',
    //     brand: BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo,productsCount: 265,isFeatured: true),
    //     images: [TImages.productImage1,TImages.productImage23,TImages.productImage21,TImages.productImage9],
    //     salePrice: 30,
    //     sku: 'ABR4568',
    //     categoryId: '1',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Black','Red']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 30','EU 32','EU 34']),
    //     ],
    //     productVariations: [
    //       ProductVariationModel(id: '1',
    //           stock:34,
    //           price: 134,
    //           salePrice: 122.6,
    //           image: TImages.productImage1,
    //           description: 'This is a Product description for Green Nike sports shoe ',
    //           attributeValues: {'Color':'Green','Size':'EU 34'}
    //          ),
    //       ProductVariationModel(id: '2',
    //           stock:15,
    //           price: 132,
    //           image: TImages.productImage23,
    //           attributeValues: {'Color':'Black','Size':'EU 32'}
    //       ),
    //       ProductVariationModel(id: '3',
    //           stock:0,
    //           price: 234,
    //           image: TImages.productImage23,
    //           attributeValues: {'Color':'Black','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '4',
    //           stock:222,
    //           price: 232,
    //           image: TImages.productImage1,
    //           attributeValues: {'Color':'Green','Size':'EU 32'}
    //       ),
    //       ProductVariationModel(id: '5',
    //           stock:0,
    //           price: 334,
    //           image: TImages.productImage21,
    //           attributeValues: {'Color':'Red','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '6',
    //           stock:11,
    //           price: 332,
    //           image: TImages.productImage21,
    //           attributeValues: {'Color':'Red','Size':'EU 32'}
    //       ),
    //     ],
    //
    //     productType: 'ProductType.variable'),
    // ProductModel(id: '002',
    //     stock: 15,
    //     price: 35,
    //     title: 'Blue T-shirt for all  ages',
    //     isFeatured: true,
    //     thumbnail: TImages.productImage69,
    //     description: 'This is a product description for blue nike sleeve less vest. There are more things that can be added but i am just practicing and nothing else',
    //     brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo),
    //     images: [TImages.productImage68,TImages.productImage69,TImages.productImage5,],
    //     salePrice: 30,
    //     sku: 'ABR4568',
    //     categoryId: '16',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Blue','Red']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 32','EU 34']),
    //     ],
    //     productType: 'ProductType.single'),
    // ProductModel(id: '003',
    //     stock: 15,
    //     price: 38000,
    //     title: 'Leather brown Jacket',
    //     isFeatured: false,
    //     thumbnail: TImages.productImage64,
    //     description: 'This is a product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else',
    //     brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo),
    //     images: [TImages.productImage64,TImages.productImage64,TImages.productImage66,TImages.productImage67],
    //     salePrice: 30,
    //     sku: 'ABR4568',
    //     categoryId: '16',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Blue','Red']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 32','EU 34']),
    //     ],
    //     productType: 'ProductType.single'),
    //
    // ProductModel(id: '004',
    //     stock: 15,
    //     price: 135,
    //     title: '4 Color collar t-shirt dry fit',
    //     isFeatured: false,
    //     thumbnail: TImages.productImage60,
    //     description: 'This is a product description for 4 Color collar t-shirt dry fit. There are more things that can be added but i am just practicing and nothing else',
    //     brand: BrandModel(id: '6', name: 'ZARA', image: TImages.zaraLogo),
    //     images: [TImages.productImage60,TImages.productImage61,TImages.productImage62,TImages.productImage63],
    //     salePrice: 30,
    //     sku: 'ABR4568',
    //     categoryId: '16',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Black','Red','Yellow']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 30','EU 32','EU 34']),
    //     ],
    //     productVariations: [
    //       ProductVariationModel(id: '1',
    //           stock:34,
    //           price: 134,
    //           salePrice: 122.6,
    //           image: TImages.productImage60,
    //           description: 'This is a Product description for 4 Color collar t-shirt dry fit',
    //           attributeValues: {'Color':'Red','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '2',
    //           stock:15,
    //           price: 132,
    //           image: TImages.productImage60,
    //           attributeValues: {'Color':'Red','Size':'EU 32'}
    //       ),
    //       ProductVariationModel(id: '3',
    //           stock:0,
    //           price: 234,
    //           image: TImages.productImage61,
    //           attributeValues: {'Color':'Yellow','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '4',
    //           stock:222,
    //           price: 232,
    //           image: TImages.productImage61,
    //           attributeValues: {'Color':'Yellow','Size':'EU 32'}
    //       ),
    //       ProductVariationModel(id: '5',
    //           stock:0,
    //           price: 334,
    //           image: TImages.productImage62,
    //           attributeValues: {'Color':'Green','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '6',
    //           stock:11,
    //           price: 332,
    //           image: TImages.productImage62,
    //           attributeValues: {'Color':'Green','Size':'EU 30'}
    //       ),
    //       ProductVariationModel(id: '7',
    //           stock:0,
    //           price: 334,
    //           image: TImages.productImage63,
    //           attributeValues: {'Color':'Blue','Size':'EU 30'}
    //       ),
    //       ProductVariationModel(id: '8',
    //           stock:11,
    //           price: 332,
    //           image: TImages.productImage63,
    //           attributeValues: {'Color':'Blue','Size':'EU 34'}
    //       ),
    //     ],
    //     productType: 'ProductType.variable'),
    // ProductModel(id: '005',
    //     stock: 15,
    //     price: 35,
    //     title: 'Nike Air Jordan Shoes',
    //     isFeatured: false,
    //     thumbnail: TImages.productImage10,
    //     description: 'Nike Air Jordan Shoes for running. Quality product, Long Lasting  ',
    //     brand: BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo,productsCount: 265, isFeatured: true),
    //     images: [TImages.productImage7,TImages.productImage8,TImages.productImage9,TImages.productImage10],
    //     salePrice: 30,
    //     sku: 'ABR4568',
    //     categoryId: '8',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Orange','Black','Brown',]),
    //       ProductAttributeModel(name: 'Size',values: ['EU 30','EU 32','EU 34']),
    //     ],
    //     productVariations: [
    //       ProductVariationModel(id: '1',
    //           stock:16,
    //           price: 36,
    //           salePrice: 12.6,
    //           image: TImages.productImage8,
    //           description: 'This is a Product description for Nike Air Jordan Shoes',
    //           attributeValues: {'Color':'Orange','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '2',
    //           stock:15,
    //           price: 35,
    //           image: TImages.productImage7,
    //           attributeValues: {'Color':'Black','Size':'EU 32'}
    //       ),
    //       ProductVariationModel(id: '3',
    //           stock:14,
    //           price: 34,
    //           image: TImages.productImage9,
    //           attributeValues: {'Color':'Brown','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '4',
    //           stock:13,
    //           price: 33,
    //           image: TImages.productImage7,
    //           attributeValues: {'Color':'Black','Size':'EU 34'}
    //       ),
    //       ProductVariationModel(id: '5',
    //           stock:12,
    //           price: 32,
    //           image: TImages.productImage9,
    //           attributeValues: {'Color':'Brown','Size':'EU 32'}
    //       ),
    //       ProductVariationModel(id: '6',
    //           stock:11,
    //           price: 31,
    //           image: TImages.productImage8,
    //           attributeValues: {'Color':'Orange','Size':'EU 32'}
    //       ),
    //     ],
    //     productType: 'ProductType.variable'),
    // ProductModel(id: '006',
    //     stock: 15,
    //     price: 750,
    //     title: 'Samsung Galaxy S9(Pink,64GB) (4GB RAM)',
    //     isFeatured: false,
    //     thumbnail: TImages.productImage11,
    //     description: 'Samsung Galaxy S9(Pink,64GB) (4GB RAM), Long Battery timing',
    //     brand: BrandModel(id: '7', name: 'Samsung', image: TImages.appleLogo),
    //     images: [TImages.productImage11,TImages.productImage12,TImages.productImage13,TImages.productImage14],
    //     salePrice: 650,
    //     sku: 'ABR4568',
    //     categoryId: '2',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Blue','Red']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 32','EU 34']),
    //     ],
    //     productType: 'ProductType.single'),
    //
    // ProductModel(id: '007',
    //     stock: 15,
    //     price: 20,
    //     title: 'Tomi Dog food',
    //     isFeatured: false,
    //     thumbnail: TImages.productImage18,
    //     description: 'This is a Product description for Tomi Dog food.There are more things that can be added but i am just practicing and nothing else',
    //     brand: BrandModel(id: '7', name: 'Tomi', image: TImages.appleLogo),
    //     salePrice: 10,
    //     sku: 'ABR4568',
    //     categoryId: '4',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Blue','Red']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 32','EU 34']),
    //     ],
    //     productType: 'ProductType.single'),
    // ProductModel(id: '009',
    //     stock: 15,
    //     price: 400,
    //     title: 'Nike Air Jordon 19 Blue',
    //     isFeatured: false,
    //     thumbnail: TImages.productImage19,
    //     description: 'This is a Product description for Nike Air Jordon.There are more things that can be added but i am just practicing and nothing else',
    //     brand: BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo),
    //     images: [TImages.productImage19,TImages.productImage20,TImages.productImage21, TImages.productImage22],
    //     salePrice: 200,
    //     sku: 'ABR4568',
    //     categoryId: '8',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color',values: ['Green','Blue','Red']),
    //       ProductAttributeModel(name: 'Size',values: ['EU 32','EU 34']),
    //     ],
    //     productType: 'ProductType.single'),

    // ProductModel(
    //     id: '008',
    //     stock: 30,
    //     price: 100,
    //     title: 'Adidas Running Shoes',
    //     isFeatured: true,
    //     thumbnail: TImages.productImage8D1,
    //     description: 'Comfortable and durable running shoes',
    //     brand: BrandModel(id: '7', name: 'Adidas', image: TImages.adidasLogo),
    //     images: [
    //       TImages.productImage8D1,
    //       TImages.productImage8D2,
    //       TImages.productImage8D3
    //     ],
    //     salePrice: 90,
    //     sku: 'ADI12345',
    //     categoryId: '1',
    //     productAttributes: [
    //       ProductAttributeModel(
    //           name: 'Color', values: ['Black', 'White', 'Blue']),
    //       ProductAttributeModel(name: 'Size', values: ['US 8', 'US 9', 'US 10'])
    //     ],
    //     productVariations: [
    //       ProductVariationModel(
    //           id: '1',
    //           stock: 10,
    //           price: 100,
    //           salePrice: 90,
    //           image: TImages.productImage8D1,
    //           description: 'Black Adidas running shoes',
    //           attributeValues: {'Color': 'Black', 'Size': 'US 8'}),
    //       ProductVariationModel(
    //           id: '2',
    //           stock: 10,
    //           price: 100,
    //           salePrice: 90,
    //           image: TImages.productImage8D2,
    //           description: 'White Adidas running shoes',
    //           attributeValues: {'Color': 'White', 'Size': 'US 9'}),
    //       ProductVariationModel(
    //           id: '3',
    //           stock: 10,
    //           price: 100,
    //           salePrice: 90,
    //           image: TImages.productImage8D3,
    //           description: 'Blue Adidas running shoes',
    //           attributeValues: {'Color': 'Blue', 'Size': 'US 10'}),
    //     ],
    //     productType: 'ProductType.variable'),
    //
    // ProductModel(
    //     id: '010',
    //     stock: 20,
    //     price: 75,
    //     title: 'Casio Digital Watch',
    //     isFeatured: true,
    //     thumbnail: TImages.productImage10D3,
    //     description: 'Reliable and stylish digital watch',
    //     brand: BrandModel(id: '8', name: 'Casio', image: TImages.casiologo),
    //     images: [
    //       TImages.productImage10D3,
    //       TImages.productImage10D2,
    //       TImages.productImage10D1,
    //     ],
    //     salePrice: 70,
    //     sku: 'CASIO1234',
    //     categoryId: '5',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color', values: ['Black', 'Silver']),
    //       ProductAttributeModel(name: 'Strap', values: ['Rubber', 'Metal'])
    //     ],
    //     productVariations: [
    //       ProductVariationModel(
    //           id: '1',
    //           stock: 10,
    //           price: 75,
    //           salePrice: 70,
    //           image: TImages.productImage10D3,
    //           description: 'Black Casio digital watch with rubber strap',
    //           attributeValues: {'Color': 'Black', 'Strap': 'Rubber'}),
    //       ProductVariationModel(
    //           id: '2',
    //           stock: 10,
    //           price: 75,
    //           salePrice: 70,
    //           image: TImages.productImage10D1,
    //           description: 'Silver Casio digital watch with metal strap',
    //           attributeValues: {'Color': 'Silver', 'Strap': 'Metal'}),
    //     ],
    //     productType: 'ProductType.variable'),
    // ProductModel(
    //     id: '011',
    //     stock: 15,
    //     price: 60,
    //     title: 'Bluetooth Wireless Earphones',
    //     isFeatured: true,
    //     thumbnail: TImages.productImage11D1,
    //     description: 'High-quality wireless earphones with superior sound',
    //     brand:
    //         BrandModel(id: '9', name: 'TechGear', image: TImages.techGearLogo),
    //     images: [
    //       TImages.productImage11D1,
    //       TImages.productImage11D2,
    //       TImages.productImage11D3,
    //     ],
    //     salePrice: 50,
    //     sku: 'TECH1234',
    //     categoryId: '2',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
    //       ProductAttributeModel(
    //           name: 'Battery Life', values: ['6 hours', '8 hours'])
    //     ],
    //     productVariations: [
    //       ProductVariationModel(
    //           id: '1',
    //           stock: 5,
    //           price: 60,
    //           salePrice: 50,
    //           image: TImages.productImage11D1,
    //           description: 'Black wireless earphones with 6 hours battery life',
    //           attributeValues: {'Color': 'Black', 'Battery Life': '6 hours'}),
    //       ProductVariationModel(
    //           id: '2',
    //           stock: 5,
    //           price: 60,
    //           salePrice: 50,
    //           image: TImages.productImage11D2,
    //           description: 'White wireless earphones with 8 hours battery life',
    //           attributeValues: {'Color': 'White', 'Battery Life': '8 hours'}),
    //     ],
    //     productType: 'ProductType.variable'),
    // ProductModel(
    //     id: '012',
    //     stock: 30,
    //     price: 120,
    //     title: 'Electric Kettle 1.7L',
    //     isFeatured: true,
    //     thumbnail: TImages.productImage12D1,
    //     description: 'Fast boiling electric kettle with 1.7L capacity',
    //     brand: BrandModel(
    //         id: '10', name: 'KitchenPro', image: TImages.kitChenProLogo),
    //     images: [
    //       TImages.productImage12D1,
    //       TImages.productImage12D2,
    //       TImages.productImage12D3,
    //     ],
    //     salePrice: 100,
    //     sku: 'KET12345',
    //     categoryId: '7',
    //     productAttributes: [
    //       ProductAttributeModel(name: 'Color', values: ['Silver', 'Black']),
    //       ProductAttributeModel(name: 'Capacity', values: ['1.7L', '1.5L'])
    //     ],
    //     productVariations: [
    //       ProductVariationModel(
    //           id: '1',
    //           stock: 15,
    //           price: 120,
    //           salePrice: 100,
    //           image: TImages.productImage12D1,
    //           description: 'Silver electric kettle with 1.7L capacity',
    //           attributeValues: {'Color': 'Silver', 'Capacity': '1.7L'}),
    //       ProductVariationModel(
    //           id: '2',
    //           stock: 15,
    //           price: 110,
    //           salePrice: 90,
    //           image: TImages.productImage12D2,
    //           description: 'Black electric kettle with 1.5L capacity',
    //           attributeValues: {'Color': 'Black', 'Capacity': '1.5L'}),
    //       ProductVariationModel(
    //           id: '3',
    //           stock: 153,
    //           price: 156,
    //           salePrice: 134,
    //           image: TImages.productImage12D3,
    //           description: 'Pink electric kettle with 1.5L capacity',
    //           attributeValues: {'Color': 'Black', 'Capacity': '1.5L'}),
    //     ],
    //     productType: 'ProductType.variable'),

    ProductModel(
        id: '013',
        stock: 25,
        price: 300,
        title: 'Adjustable Office Chair',
        isFeatured: true,
        thumbnail:
        TImages.productImage13D3,
        description:
            'Ergonomic office chair with adjustable height and lumbar support',
        brand: BrandModel(
            id: '11',
            name: "Office Comfort Chair",
            image:
            TImages.officeComfortLogo,),
        images: [
          TImages.productImage13D3,  TImages.productImage13D2,  TImages.productImage13D1,
        ],
        salePrice: 250,
        sku: 'CHAIR1234',
        categoryId: '8',
        productAttributes: [
          ProductAttributeModel(name: 'Color', values: ['Black', 'Grey']),
          ProductAttributeModel(name: 'Material', values: ['Mesh', 'Leather'])
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 12,
              price: 300,
              salePrice: 250,
              image:
              TImages.productImage13D3,
              description: 'Black ergonomic office chair with mesh material',
              attributeValues: {'Color': 'Black', 'Material': 'Mesh'}),
          ProductVariationModel(
              id: '2',
              stock: 13,
              price: 320,
              salePrice: 270,
              image:
              TImages.productImage13D2,
              description: 'Grey ergonomic office chair with leather material',
              attributeValues: {'Color': 'Grey', 'Material': 'Leather'}),
          ProductVariationModel(
              id: '3',
              stock: 13,
              price: 321,
              salePrice: 27,
              image:
              TImages.productImage13D1,
              description: 'Grey ergonomic office chair with leather material',
              attributeValues: {'Color': 'Grey', 'Material': 'Leather'}),
        ],
        productType: 'ProductType.variable')
  ];

  ///Categories
  static final List<CategoryModel> categories = [
    // CategoryModel(
    //     id: '1', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
    // CategoryModel(
    //     id: '5',
    //     name: 'Furniture',
    //     image: TImages.furnitureIcon,
    //     isFeatured: true),
    // CategoryModel(
    //     id: '2',
    //     name: 'Electronics',
    //     image: TImages.electronicsIcon,
    //     isFeatured: true),
    // CategoryModel(
    //     id: '3', name: 'Clothes', image: TImages.clothIcon, isFeatured: true),
    // CategoryModel(
    //     id: '4', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
    // CategoryModel(
    //     id: '6', name: 'Shoes', image: TImages.shoeIcon, isFeatured: true),
    // CategoryModel(
    //     id: '7',
    //     name: 'Cosmetics',
    //     image: TImages.cosmeticsIcon,
    //     isFeatured: true),
    // CategoryModel(
    //     id: '14',
    //     name: 'Jewelery',
    //     image: TImages.jeweleryIcon,
    //     isFeatured: true),
    //
    // //sub categories
    // CategoryModel(
    //     id: '8',
    //     name: 'Sports Shoes',
    //     image: TImages.sportIcon,
    //     isFeatured: false,
    //     parentId: '1'),
    // CategoryModel(
    //     id: '9',
    //     name: 'Track  suits',
    //     image: TImages.sportIcon,
    //     isFeatured: false,
    //     parentId: '1'),
    // CategoryModel(
    //     id: '10',
    //     name: 'Sports Equipments',
    //     image: TImages.sportIcon,
    //     isFeatured: false,
    //     parentId: '1'),
    // //furnitures
    // CategoryModel(
    //     id: '11',
    //     name: 'Bedroom furniture',
    //     image: TImages.furnitureIcon,
    //     isFeatured: false,
    //     parentId: '5'),
    // CategoryModel(
    //     id: '12',
    //     name: 'Kitchen furniture',
    //     image: TImages.furnitureIcon,
    //     isFeatured: false,
    //     parentId: '5'),
    // CategoryModel(
    //     id: '13',
    //     name: 'Office furniture ',
    //     image: TImages.furnitureIcon,
    //     isFeatured: false,
    //     parentId: '5'),
    // //electronics
    // CategoryModel(
    //     id: '14',
    //     name: 'Laptop',
    //     image: TImages.electronicsIcon,
    //     isFeatured: false,
    //     parentId: '2'),
    // CategoryModel(
    //     id: '15',
    //     name: 'Mobile',
    //     image: TImages.electronicsIcon,
    //     isFeatured: false,
    //     parentId: '2'),
    // CategoryModel(
    //     id: '16',
    //     name: 'Shirts',
    //     image: TImages.clothIcon,
    //     isFeatured: false,
    //     parentId: '3'),
    // CategoryModel(
    //     id: '17',
    //     name: 'Jacket',
    //     image: TImages.clothIcon,
    //     isFeatured: false,
    //     parentId: '3'),
    // CategoryModel(
    //     id: '18',
    //     name: 'Trousers',
    //     image: TImages.clothIcon,
    //     isFeatured: false,
    //     parentId: '3'),
    // CategoryModel(
    //     id: '19',
    //     name: 'Dress',
    //     image: TImages.clothIcon,
    //     isFeatured: false,
    //     parentId: '3'),
    // CategoryModel(
    //     id: '20',
    //     name: 'Vest',
    //     image: TImages.clothIcon,
    //     isFeatured: false,
    //     parentId: '3'),
    // CategoryModel(
    //     id: '21',
    //     name: 'Scarf',
    //     image: TImages.clothIcon,
    //     isFeatured: true,
    //     ),
    // CategoryModel(
    //   id: '22',
    //   name: 'Hat',
    //   image: TImages.clothIcon,
    //   isFeatured: true,
    // ),
    // CategoryModel(
    //   id: '23',
    //   name: 'Flip-flops',
    //   image: TImages.shoeIcon,
    //   isFeatured: false,
    //   parentId: '6'
    // ),
    // CategoryModel(
    //   id: '24',
    //   name: 'Wallet',
    //   image: TImages.jeweleryIcon,
    //   isFeatured: false,
    //   parentId: '4'
    // ),
    // CategoryModel(
    //     id: '25',
    //     name: 'High heels',
    //     image: TImages.shoeIcon,
    //     isFeatured: false,
    //     parentId: '6'
    // ),
    // CategoryModel(
    //     id: '26',
    //     name: 'Sandals',
    //     image: TImages.shoeIcon,
    //     isFeatured: false,
    //     parentId: '6'
    // ),
    // CategoryModel(
    //     id: '27',
    //     name: 'Socks',
    //     image: TImages.shoeIcon,
    //     isFeatured: false,
    //     parentId: '3'
    // ),
    // CategoryModel(
    //     id: '28',
    //     name: 'Sweater',
    //     image: TImages.shoeIcon,
    //     isFeatured: false,
    //     parentId: '3'
    // ),
    // CategoryModel(
    //     id: '29',
    //     name: 'Suit',
    //     image: TImages.shoeIcon,
    //     isFeatured: false,
    //     parentId: '3'
    // ),
    // CategoryModel(
    //     id: '30',
    //     name: 'Hand Bag',
    //     image: TImages.jeweleryIcon,
    //     isFeatured: false,
    //     parentId: '4'
    // ),
    CategoryModel(
        id: '31',
        name: 'Belt',
        image: TImages.jeweleryIcon,
        isFeatured: false,
        parentId: '3'
    ),
    CategoryModel(
        id: '32',
        name: 'Fashion shoes',
        image: TImages.shoeIcon,
        isFeatured: false,
        parentId: '6'
    ),
    CategoryModel(
          id: '33',
          name: 'Jewelery',
          image: TImages.jeweleryIcon,
          isFeatured: false,
          parentId: '3'
    ),





  ];

  static final List<BrandModel> brands = [
    BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo,isFeatured: true,productsCount: 265),
    BrandModel(id: '2', name: 'Adidas', image: TImages.adidasLogo, isFeatured: true, productsCount: 320),
    BrandModel(id: '3', name: 'Apple', image: TImages.appleLogo, isFeatured: true, productsCount: 150),
    BrandModel(id: '4', name: 'Jordan', image: TImages.jordanLogo, isFeatured: true, productsCount: 100),
    BrandModel(id: '5', name: 'Puma', image: TImages.pumaLogo, isFeatured: true, productsCount: 180),
    BrandModel(id: '6', name: 'Zara', image: TImages.zaraLogo, isFeatured: true, productsCount: 200),
    BrandModel(id: '7', name: 'Kenwood', image: TImages.kenwoodLogo, isFeatured: true, productsCount: 75),
    BrandModel(id: '8', name: 'Herman Miller', image: TImages.hermanMillerLogo, isFeatured: true, productsCount: 50),
    BrandModel(id: '9', name: 'Ikea', image: TImages.ikeaLogo, isFeatured: true, productsCount: 220),
    BrandModel(id: '10', name: 'Acer', image: TImages.acerlogo, isFeatured: true, productsCount: 90),
    BrandModel(id: '11', name: 'Rolex', image: TImages.casiologo, isFeatured: true, productsCount: 130),
    BrandModel(id: '12', name: 'JBL', image: TImages.techGearLogo, isFeatured: true, productsCount: 60),
    BrandModel(id: '13', name: 'Sun House', image: TImages.kitChenProLogo, isFeatured: true, productsCount: 40),
    BrandModel(id: '14', name: 'Hoa Phat', image: TImages.officeComfortLogo, isFeatured: true, productsCount: 110),
  ];
  static final List<BrandCategoryModel> brandCategorys = [
    BrandCategoryModel(brandId: "1", categoryId: "1"),  // Nike - Sports
    BrandCategoryModel(brandId: "1", categoryId: "8"),  // Nike - Sports Shoes
    BrandCategoryModel(brandId: "1", categoryId: "9"),  // Nike - Tracksuits
    BrandCategoryModel(brandId: "2", categoryId: "1"),  // Adidas - Sports
    BrandCategoryModel(brandId: "2", categoryId: "8"),  // Adidas - Sports Shoes
    BrandCategoryModel(brandId: "3", categoryId: "2"),  // Apple - Electronics
    BrandCategoryModel(brandId: "3", categoryId: "14"), // Apple - Laptop
    BrandCategoryModel(brandId: "4", categoryId: "1"),  // Jordan - Sports
    BrandCategoryModel(brandId: "4", categoryId: "8"),  // Jordan - Sports Shoes
    BrandCategoryModel(brandId: "5", categoryId: "1"),  // Puma - Sports
    BrandCategoryModel(brandId: "5", categoryId: "8"),  // Puma - Sports Shoes
    BrandCategoryModel(brandId: "6", categoryId: "3"),  // Zara - Clothes (assuming general clothing)
    BrandCategoryModel(brandId: "6", categoryId: "16"),  // Zara - Shirts (if applicable)
    BrandCategoryModel(brandId: "7", categoryId: "2"),  // Kenwood - Electronics
    BrandCategoryModel(brandId: "8", categoryId: "5"),  // Herman Miller - Furniture
    BrandCategoryModel(brandId: "8", categoryId: "11"), // Herman Miller - Bedroom furniture (if applicable)
    BrandCategoryModel(brandId: "8", categoryId: "12"), // Herman Miller - Kitchen furniture (if applicable)
    BrandCategoryModel(brandId: "8", categoryId: "13"), // Herman Miller - Office furniture (if applicable)
    BrandCategoryModel(brandId: "9", categoryId: "5"),  // Ikea - Furniture
    BrandCategoryModel(brandId: "9", categoryId: "11"), // Ikea - Bedroom furniture (if applicable)
    BrandCategoryModel(brandId: "9", categoryId: "12"), // Ikea - Kitchen furniture (if applicable)
    BrandCategoryModel(brandId: "10", categoryId: "2"),  // Acer - Electronics
    BrandCategoryModel(brandId: "10", categoryId: "14"), // Acer - Laptop (if applicable)
    BrandCategoryModel(brandId: "11", categoryId: "14"), // Rolex - Jewelry (assuming luxury watches)
    BrandCategoryModel(brandId: "12", categoryId: "2"),  // JBL - Electronics
    BrandCategoryModel(brandId: "13", categoryId: "5"),  // Sun House - Furniture (assuming home furniture)
    BrandCategoryModel(brandId: "13", categoryId: "11"), // Sun House - Bedroom furniture (if applicable)
    BrandCategoryModel(brandId: "13", categoryId: "12"), // Sun House - Kitchen furniture (if applicable)
    BrandCategoryModel(brandId: "14", categoryId: "5"),  // Hoa Phat - Furniture (assuming office furniture)
    BrandCategoryModel(brandId: "14", categoryId: "13"), // Hoa Phat - Office furniture
  ];
  static final List<ProductCategoryModel> productCategorys = [
    // Sports
    ProductCategoryModel(productId: "001", categoryId: "1"), // Green Nike sports shoe
    ProductCategoryModel(productId: "002", categoryId: "3"), // Blue T-shirt for all ages
    ProductCategoryModel(productId: "005", categoryId: "1"), // Nike Air Jordan Shoes
    ProductCategoryModel(productId: "008", categoryId: "1"), // Adidas Running Shoes
    ProductCategoryModel(productId: "009", categoryId: "1"), // Nike Air Jordon 19 Blue
    ProductCategoryModel(productId: "010", categoryId: "14"), // Rolex Limited

    // Furniture
    ProductCategoryModel(productId: "011", categoryId: "5"), // Bluetooth Wireless Earphones
    ProductCategoryModel(productId: "012", categoryId: "5"), // Electric Kettle 1.7L
    ProductCategoryModel(productId: "013", categoryId: "5"), // Adjustable Office Chair

    // Electronics
    ProductCategoryModel(productId: "006", categoryId: "2"), // Samsung Galaxy S9
    ProductCategoryModel(productId: "011", categoryId: "2"), // Bluetooth Wireless Earphones

    // Clothes
    ProductCategoryModel(productId: "002", categoryId: "3"), // Blue T-shirt for all ages
    ProductCategoryModel(productId: "003", categoryId: "3"), // Leather brown Jacket
    ProductCategoryModel(productId: "004", categoryId: "3"), // 4 Color collar t-shirt dry fit
    ProductCategoryModel(productId: "016", categoryId: "3"), // Shirts

    // Animals
    ProductCategoryModel(productId: "007", categoryId: "4"), // Tomi Dog food

    // Shoes
    ProductCategoryModel(productId: "001", categoryId: "6"), // Green Nike sports shoe
    ProductCategoryModel(productId: "005", categoryId: "6"), // Nike Air Jordan Shoes
    ProductCategoryModel(productId: "008", categoryId: "6"), // Adidas Running Shoes
    ProductCategoryModel(productId: "009", categoryId: "6"), // Nike Air Jordon 19 Blue

    // Cosmetics
    ProductCategoryModel(productId: "007", categoryId: "7"), // Tomi Dog food

    // Jewelery
    ProductCategoryModel(productId: "010", categoryId: "14"), // Rolex Limited
    ProductCategoryModel(productId: "011", categoryId: "14"), // Bluetooth Wireless Earphones

    // Sports Shoes
    ProductCategoryModel(productId: "001", categoryId: "8"), // Green Nike sports shoe
    ProductCategoryModel(productId: "008", categoryId: "8"), // Adidas Running Shoes
    ProductCategoryModel(productId: "009", categoryId: "8"), // Nike Air Jordon 19 Blue

    // Track suits
    ProductCategoryModel(productId: "002", categoryId: "9"), // Blue T-shirt for all ages

    // Sports Equipments
    ProductCategoryModel(productId: "010", categoryId: "10"), // Rolex Limited

    // Bedroom furniture
    ProductCategoryModel(productId: "011", categoryId: "11"), // Bluetooth Wireless Earphones

    // Kitchen furniture
    ProductCategoryModel(productId: "012", categoryId: "12"), // Electric Kettle 1.7L

    // Office furniture
    ProductCategoryModel(productId: "013", categoryId: "13"), // Adjustable Office Chair

    // Laptop
    ProductCategoryModel(productId: "006", categoryId: "14"), // Samsung Galaxy S9

    // Mobile
    ProductCategoryModel(productId: "015", categoryId: "15"), // Mobile

    // Cosmetics (again for Mobile)
    ProductCategoryModel(productId: "015", categoryId: "7"), // Mobile

    // Jewelery (again for Mobile)
    ProductCategoryModel(productId: "015", categoryId: "14"), // Mobile
  ];
}

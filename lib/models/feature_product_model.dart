class ProductModel {
  final String id;
  final String title;
  final String club;
  final double price;
  final String image;
  final double rating;
  final bool isFeatured;
  final bool isNew;
  final String category;

  const ProductModel({
    required this.id,
    required this.title,
    required this.club,
    required this.price,
    required this.image,
    required this.rating,
    required this.isFeatured,
    required this.isNew,
    required this.category,
  });
}

const List<ProductModel> featuredProducts = [
  ProductModel(
    id: '1',
    title: 'Home Jersey 24/25',
    club: 'Real Madrid',
    price: 1499,
    image: 'assets/images/products/real_madrid_home.png',
    rating: 4.8,
    isFeatured: true,
    isNew: true,
    category: 'club',
  ),
  ProductModel(
    id: '2',
    title: 'Home Jersey 24/25',
    club: 'Barcelona',
    price: 1499,
    image: 'assets/images/products/barcelona_home.png',
    rating: 4.7,
    isFeatured: true,
    isNew: true,
    category: 'club',
  ),
  ProductModel(
    id: '3',
    title: 'Home Jersey',
    club: 'Argentina',
    price: 1599,
    image: 'assets/images/products/argentina_home.png',
    rating: 4.9,
    isFeatured: true,
    isNew: false,
    category: 'national',
  ),
  ProductModel(
  id: '4',
  title: 'Away Jersey 24/25',
  club: 'Brazil',
  price: 1599,
  image: 'assets/images/products/brazil_away.png',
  rating: 4.8,
  isFeatured: true,
  isNew: true,
  category: 'national',
),
];

const List<ProductModel> newArrivalProducts = [
  ProductModel(
    id: '5',
    title: 'Home Jersey 25/26',
    club: 'Manchester City',
    price: 1699,
    image: 'assets/images/products/manchester_city_home.png',
    rating: 4.9,
    isFeatured: false,
    isNew: true,
    category: 'club',
  ),

  ProductModel(
    id: '6',
    title: 'Away Jersey 25/26',
    club: 'Liverpool',
    price: 1699,
    image: 'assets/images/products/liverpool_away.png',
    rating: 4.8,
    isFeatured: false,
    isNew: true,
    category: 'club',
  ),

  ProductModel(
    id: '7',
    title: 'Retro Jersey',
    club: 'AC Milan',
    price: 1799,
    image: 'assets/images/products/ac_milan_retro.png',
    rating: 4.9,
    isFeatured: false,
    isNew: true,
    category: 'retro',
  ),

  ProductModel(
    id: '8',
    title: 'Home Jersey',
    club: 'Germany',
    price: 1599,
    image: 'assets/images/products/germany_home.png',
    rating: 4.7,
    isFeatured: false,
    isNew: true,
    category: 'national',
  ),
];

const List<ProductModel> shopProducts = [

  ProductModel(
    id: '1',
    title: 'Home Jersey 24/25',
    club: 'Real Madrid',
    price: 1499,
    image: 'assets/images/products/real_madrid_home.png',
    rating: 4.8,
    isFeatured: true,
    isNew: true,
    category: 'club',
  ),

  ProductModel(
    id: '2',
    title: 'Home Jersey 24/25',
    club: 'Barcelona',
    price: 1499,
    image: 'assets/images/products/barcelona_home.png',
    rating: 4.7,
    isFeatured: true,
    isNew: true,
    category: 'club',
  ),

  ProductModel(
    id: '3',
    title: 'Home Jersey',
    club: 'Manchester United',
    price: 1599,
    image: 'assets/images/products/manchester_home.png',
    rating: 4.8,
    isFeatured: false,
    isNew: true,
    category: 'club',
  ),

  ProductModel(
    id: '4',
    title: 'Away Jersey',
    club: 'Liverpool',
    price: 1599,
    image: 'assets/images/products/liverpool_away.png',
    rating: 4.9,
    isFeatured: false,
    isNew: true,
    category: 'club',
  ),

  ProductModel(
    id: '5',
    title: 'Away Jersey',
    club: 'Arsenal',
    price: 1499,
    image: 'assets/images/products/arsenal_away.png',
    rating: 4.7,
    isFeatured: false,
    isNew: false,
    category: 'club',
  ),

  ProductModel(
    id: '6',
    title: 'Home Jersey',
    club: 'Argentina',
    price: 1599,
    image: 'assets/images/products/argentina_home.png',
    rating: 4.9,
    isFeatured: false,
    isNew: true,
    category: 'national',
  ),

  ProductModel(
    id: '7',
    title: 'Away Jersey',
    club: 'Brazil',
    price: 1599,
    image: 'assets/images/products/brazil_away.png',
    rating: 4.8,
    isFeatured: false,
    isNew: true,
    category: 'national',
  ),

  ProductModel(
    id: '8',
    title: 'Home Jersey',
    club: 'France',
    price: 1599,
    image: 'assets/images/products/france_home.png',
    rating: 4.8,
    isFeatured: false,
    isNew: false,
    category: 'national',
  ),

  ProductModel(
    id: '9',
    title: 'Away Jersey',
    club: 'Germany',
    price: 1599,
    image: 'assets/images/products/germany_away.png',
    rating: 4.7,
    isFeatured: false,
    isNew: true,
    category: 'national',
  ),

  ProductModel(
    id: '10',
    title: 'Home Jersey',
    club: 'Portugal',
    price: 1599,
    image: 'assets/images/products/portugal_home.png',
    rating: 4.9,
    isFeatured: false,
    isNew: true,
    category: 'national',
  ),
];
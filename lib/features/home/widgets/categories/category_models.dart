import '../../../../routes/app_routes.dart';

class CategoryModel {
  final String title;
  final String image;
  final String route;
  final String categoryId;

  const CategoryModel({
    required this.title,
    required this.image,
    required this.route,
    required this.categoryId,
  });
}

/// Temporary category data
///
/// Later this will come from Firebase.
const List<CategoryModel> categories = [
  CategoryModel(
    title: 'Club Jerseys',
    image: 'assets/images/categories/club_jerseys.png',
    route: AppRouter.shop,
    categoryId: 'club',
  ),
  CategoryModel(
    title: 'National Teams',
    image: 'assets/images/categories/national_teams.png',
    route: AppRouter.shop,
    categoryId: 'national',
  ),
  CategoryModel(
    title: 'Retro Jerseys',
    image: 'assets/images/categories/retro_jerseys.png',
    route: AppRouter.shop,
    categoryId: 'retro',
  ),
  CategoryModel(
    title: 'Custom Jerseys',
    image: 'assets/images/categories/custom_jerseys.png',
    route: AppRouter.shop,
    categoryId: 'custom',
  ),
];
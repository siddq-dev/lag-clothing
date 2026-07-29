import '../../../../models/product_image_model.dart';
import '../../../../models/product_seo_model.dart';
import '../../../../models/product_variant_model.dart';

class ProductFormModel {
  String name = "";

  String description = "";

  String brand = "";

  String category = "";

  String subCategory = "";

  double price = 0;

  double salePrice = 0;

  int stock = 0;

  bool featured = false;

  bool bestSeller = false;

  bool newArrival = false;

  bool status = true;

  List<ProductImageModel> images = [];

  List<ProductVariantModel> variants = [];

  ProductSeoModel seo = const ProductSeoModel(
    seoTitle: "",
    metaDescription: "",
    slug: "",
    keywords: [],
    hashtags: [],
    searchTags: [],
    openGraphImage: "",
  );
}
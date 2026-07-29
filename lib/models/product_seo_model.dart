class ProductSeoModel {
  final String seoTitle;

  final String metaDescription;

  final String slug;

  final List<String> keywords;

  final List<String> hashtags;

  final List<String> searchTags;

  final String openGraphImage;

  const ProductSeoModel({
    required this.seoTitle,
    required this.metaDescription,
    required this.slug,
    required this.keywords,
    required this.hashtags,
    required this.searchTags,
    required this.openGraphImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'seoTitle': seoTitle,
      'metaDescription': metaDescription,
      'slug': slug,
      'keywords': keywords,
      'hashtags': hashtags,
      'searchTags': searchTags,
      'openGraphImage': openGraphImage,
    };
  }

  factory ProductSeoModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ProductSeoModel(
      seoTitle: map['seoTitle'] ?? '',
      metaDescription: map['metaDescription'] ?? '',
      slug: map['slug'] ?? '',
      keywords: List<String>.from(
        map['keywords'] ?? [],
      ),
      hashtags: List<String>.from(
        map['hashtags'] ?? [],
      ),
      searchTags: List<String>.from(
        map['searchTags'] ?? [],
      ),
      openGraphImage:
          map['openGraphImage'] ?? '',
    );
  }

  ProductSeoModel copyWith({
    String? seoTitle,
    String? metaDescription,
    String? slug,
    List<String>? keywords,
    List<String>? hashtags,
    List<String>? searchTags,
    String? openGraphImage,
  }) {
    return ProductSeoModel(
      seoTitle: seoTitle ?? this.seoTitle,
      metaDescription:
          metaDescription ?? this.metaDescription,
      slug: slug ?? this.slug,
      keywords: keywords ?? this.keywords,
      hashtags: hashtags ?? this.hashtags,
      searchTags: searchTags ?? this.searchTags,
      openGraphImage:
          openGraphImage ?? this.openGraphImage,
    );
  }
}
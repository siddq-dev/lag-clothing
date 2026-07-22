import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/categories/categories_section.dart';
import '../widgets/featured_collection/featured_collection.dart';
import '../widgets/hero/hero_section.dart';
import '../widgets/new_arrivals/new_arrivals.dart';
import '../widgets/customer_review/customer_reviews.dart';
import '../widgets/why_choose_us/why_choose_us.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.home,
      child: const Column(
        children: [
          HeroSection(),
          CategoriesSection(),
          FeaturedCollection(),
          NewArrivals(),
          WhyChooseUs(),
          CustomerReviews(),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/responsive/responsive_builders.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_spacing.dart';

import 'footers_brands.dart';
import 'footer_customer_support.dart';
import 'footer_company.dart';
import 'footers_links.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl,
      ),
      child: ResponsiveBuilder(
        desktop: const _DesktopFooter(),
        tablet: const _TabletFooter(),
        mobile: const _MobileFooter(),
      ),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  const _DesktopFooter();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          flex: 2,
          child: FooterBrand(),
        ),

        SizedBox(width: AppSpacing.xxl),

        Expanded(
          child: FooterLinks(),
        ),

        SizedBox(width: AppSpacing.xxl),

        Expanded(
          child: FooterCustomerSupport(),
        ),

        SizedBox(width: AppSpacing.xxl),

        Expanded(
          child: FooterCompany(),
        ),
      ],
    );
  }
}

class _TabletFooter extends StatelessWidget {
  const _TabletFooter();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          flex: 2,
          child: FooterBrand(),
        ),

        SizedBox(width: AppSpacing.lg),

        Expanded(
          child: FooterLinks(),
        ),

        SizedBox(width: AppSpacing.lg),

        Expanded(
          child: FooterCustomerSupport(),
        ),

        SizedBox(width: AppSpacing.lg),

        Expanded(
          child: FooterCompany(),
        ),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  const _MobileFooter();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        FooterBrand(),

        SizedBox(height: AppSpacing.xl),

        FooterLinks(),

        SizedBox(height: AppSpacing.xl),

        FooterCustomerSupport(),

        SizedBox(height: AppSpacing.xl),

        FooterCompany(),

      ],
    );
  }
}
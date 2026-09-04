import 'dart:async';

import 'package:flutter/material.dart';

class HeroImage extends StatefulWidget {
  const HeroImage({super.key});

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage> {
  final PageController _pageController = PageController();

  Timer? _timer;

  int _currentIndex = 0;

  final List<String> _images = const [
    'assets/images/hero/hero_banner_1.jpeg',
    'assets/images/hero/hero_banner_2.jpeg',
    'assets/images/hero/hero_banner_3.jpeg',
  ];

  @override
  void initState() {
    super.initState();

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) {
        return;
      }

      final int nextIndex = (_currentIndex + 1) % _images.length;

      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    });
  }

  void _goToPrevious() {
    if (!_pageController.hasClients) {
      return;
    }

    final int previousIndex = _currentIndex == 0
        ? _images.length - 1
        : _currentIndex - 1;

    _pageController.animateToPage(
      previousIndex,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _goToNext() {
    if (!_pageController.hasClients) {
      return;
    }

    final int nextIndex = (_currentIndex + 1) % _images.length;

    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ============================================================
          // SLIDES
          // ============================================================
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _images[index],
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      size: 80,
                      color: Colors.white70,
                    ),
                  );
                },
              );
            },
          ),

          // ============================================================
          // LEFT / PREVIOUS BUTTON
          // ============================================================
          Positioned(
            left: 24,
            top: 0,
            bottom: 0,
            child: Center(
              child: _HeroNavigationButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onPressed: _goToPrevious,
              ),
            ),
          ),

          // ============================================================
          // RIGHT / NEXT BUTTON
          // ============================================================
          Positioned(
            right: 24,
            top: 0,
            bottom: 0,
            child: Center(
              child: _HeroNavigationButton(
                icon: Icons.arrow_forward_ios_rounded,
                onPressed: _goToNext,
              ),
            ),
          ),

          // ============================================================
          // SLIDE INDICATORS
          // ============================================================
          Positioned(
            left: 0,
            right: 0,
            bottom: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                final bool isActive = index == _currentIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: isActive ? 28 : 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroNavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _HeroNavigationButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.32),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(child: Icon(icon, color: Colors.white, size: 18)),
        ),
      ),
    );
  }
}

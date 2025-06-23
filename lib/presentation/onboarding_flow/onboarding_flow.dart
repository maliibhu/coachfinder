import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/onboarding_slide_widget.dart';
import './widgets/page_indicator_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "id": 1,
      "title": "Find Expert Coaches",
      "description":
          "Discover qualified sports coaches near you across multiple disciplines including badminton, cricket, tennis and more.",
      "imageUrl":
          "https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "iconName": "search",
    },
    {
      "id": 2,
      "title": "Book & Schedule",
      "description":
          "Easily book coaching sessions with flexible scheduling options that fit your busy lifestyle and training goals.",
      "imageUrl":
          "https://images.pexels.com/photos/6740821/pexels-photo-6740821.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "iconName": "calendar_today",
    },
    {
      "id": 3,
      "title": "Train & Improve",
      "description":
          "Get personalized coaching to enhance your skills, track progress, and achieve your athletic potential with expert guidance.",
      "imageUrl":
          "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "iconName": "trending_up",
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      HapticFeedback.lightImpact();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    HapticFeedback.lightImpact();
    _completeOnboarding();
  }

  void _completeOnboarding() {
    Navigator.pushReplacementNamed(context, '/authentication-login-register');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _skipOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    ),
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isDark
                                ? AppTheme
                                    .darkTheme.colorScheme.onSurfaceVariant
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  // Page indicator
                  PageIndicatorWidget(
                    currentPage: _currentPage,
                    totalPages: _onboardingData.length,
                  ),
                ],
              ),
            ),

            // PageView content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  HapticFeedback.selectionClick();
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final slideData =
                      _onboardingData[index];
                  return OnboardingSlideWidget(
                    title: slideData["title"] as String,
                    description: slideData["description"] as String,
                    imageUrl: slideData["imageUrl"] as String,
                    iconName: slideData["iconName"] as String,
                  );
                },
              ),
            ),

            // Bottom action button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppTheme.darkTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.primary,
                  foregroundColor: isDark
                      ? AppTheme.darkTheme.colorScheme.onPrimary
                      : AppTheme.lightTheme.colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentPage == _onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isDark
                                ? AppTheme.darkTheme.colorScheme.onPrimary
                                : AppTheme.lightTheme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                    ),
                    if (_currentPage < _onboardingData.length - 1) ...[
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: 'arrow_forward',
                        color: isDark
                            ? AppTheme.darkTheme.colorScheme.onPrimary
                            : AppTheme.lightTheme.colorScheme.onPrimary,
                        size: 20,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

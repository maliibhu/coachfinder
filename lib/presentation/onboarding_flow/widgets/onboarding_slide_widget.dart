import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String iconName;

  const OnboardingSlideWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main illustration
          Container(
            width: 80.w,
            height: 35.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? AppTheme.darkTheme.colorScheme.shadow
                      : AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CustomImageWidget(
                imageUrl: imageUrl,
                width: 80.w,
                height: 35.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 4.h),

          // Icon with background
          Container(
            width: 16.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.darkTheme.colorScheme.tertiary
                      .withValues(alpha: 0.2)
                  : AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: iconName,
                color: isDark
                    ? AppTheme.darkTheme.colorScheme.tertiary
                    : AppTheme.lightTheme.colorScheme.tertiary,
                size: 32,
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: isDark
                      ? AppTheme.darkTheme.colorScheme.onSurface
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ),
          ),

          SizedBox(height: 2.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isDark
                        ? AppTheme.darkTheme.colorScheme.onSurfaceVariant
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    fontSize: 16.sp,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

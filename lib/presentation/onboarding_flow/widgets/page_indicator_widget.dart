import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PageIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          width: currentPage == index ? 8.w : 2.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: currentPage == index
                ? (isDark
                    ? AppTheme.darkTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.primary)
                : (isDark
                    ? AppTheme.darkTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}

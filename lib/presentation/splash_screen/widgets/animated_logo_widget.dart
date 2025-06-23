import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AnimatedLogoWidget extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;

  const AnimatedLogoWidget({
    super.key,
    required this.scaleAnimation,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([scaleAnimation, fadeAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Opacity(
            opacity: fadeAnimation.value,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Sports equipment icons
                        Positioned(
                          top: 2.w,
                          child: CustomIconWidget(
                            iconName: 'sports_tennis',
                            color: AppTheme.lightTheme.primaryColor,
                            size: 4.w,
                          ),
                        ),
                        Positioned(
                          bottom: 2.w,
                          left: 2.w,
                          child: CustomIconWidget(
                            iconName: 'sports_cricket',
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            size: 3.5.w,
                          ),
                        ),
                        Positioned(
                          bottom: 2.w,
                          right: 2.w,
                          child: CustomIconWidget(
                            iconName: 'sports_basketball',
                            color: AppTheme.accentLight,
                            size: 3.5.w,
                          ),
                        ),
                        // Central coach icon
                        CustomIconWidget(
                          iconName: 'person',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 8.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

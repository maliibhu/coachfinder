import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/coach_about_widget.dart';
import './widgets/coach_action_buttons_widget.dart';
import './widgets/coach_availability_widget.dart';
import './widgets/coach_experience_widget.dart';
import './widgets/coach_gallery_widget.dart';
import './widgets/coach_header_widget.dart';
import './widgets/coach_location_widget.dart';
import './widgets/coach_pricing_widget.dart';
import './widgets/coach_reviews_widget.dart';

class CoachProfileDetail extends StatefulWidget {
  const CoachProfileDetail({super.key});

  @override
  State<CoachProfileDetail> createState() => _CoachProfileDetailState();
}

class _CoachProfileDetailState extends State<CoachProfileDetail> {
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderVisible = true;

  // Mock coach data
  final Map<String, dynamic> coachData = {
    "id": 1,
    "name": "Sarah Johnson",
    "profileImage":
        "https://images.pexels.com/photos/3768916/pexels-photo-3768916.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "isVerified": true,
    "sports": ["Tennis", "Badminton"],
    "experience": 8,
    "rating": 4.8,
    "reviewCount": 127,
    "bio":
        "Professional tennis coach with 8+ years of experience training players from beginner to advanced levels. Former collegiate player with expertise in technique refinement and mental game development.",
    "philosophy":
        "I believe every player has unique potential. My coaching focuses on building strong fundamentals while developing each player's natural strengths and competitive mindset.",
    "credentials": [
      "USPTA Certified Professional",
      "Sports Psychology Certificate",
      "First Aid & CPR Certified"
    ],
    "gallery": [
      "https://images.pexels.com/photos/209977/pexels-photo-209977.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1263348/pexels-photo-1263348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3768916/pexels-photo-3768916.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1263349/pexels-photo-1263349.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    ],
    "experience_timeline": [
      {
        "year": "2016-Present",
        "title": "Head Tennis Coach",
        "organization": "Elite Sports Academy",
        "description": "Leading tennis program for 50+ students"
      },
      {
        "year": "2014-2016",
        "title": "Assistant Coach",
        "organization": "City Tennis Club",
        "description": "Coached junior players and group sessions"
      }
    ],
    "availability": [
      {
        "date": "2024-01-15",
        "slots": ["09:00", "11:00", "14:00", "16:00"]
      },
      {
        "date": "2024-01-16",
        "slots": ["10:00", "15:00", "17:00"]
      },
      {
        "date": "2024-01-17",
        "slots": ["08:00", "13:00", "16:00"]
      },
      {
        "date": "2024-01-18",
        "slots": ["09:00", "11:00", "14:00"]
      },
      {
        "date": "2024-01-19",
        "slots": ["10:00", "12:00", "15:00"]
      },
      {
        "date": "2024-01-20",
        "slots": ["09:00", "16:00", "18:00"]
      },
      {
        "date": "2024-01-21",
        "slots": ["11:00", "14:00", "17:00"]
      }
    ],
    "reviews": [
      {
        "id": 1,
        "reviewer": "Mike Chen",
        "rating": 5,
        "date": "2024-01-10",
        "comment":
            "Sarah is an exceptional coach! Her technique corrections improved my serve dramatically. Highly recommend for serious players."
      },
      {
        "id": 2,
        "reviewer": "Lisa Rodriguez",
        "rating": 5,
        "date": "2024-01-08",
        "comment":
            "Great with beginners. Patient and encouraging. My daughter loves her lessons and has improved so much."
      },
      {
        "id": 3,
        "reviewer": "David Park",
        "rating": 4,
        "date": "2024-01-05",
        "comment":
            "Solid coaching fundamentals. Good at identifying weaknesses and providing targeted drills."
      }
    ],
    "location": {
      "venue": "Elite Sports Academy",
      "address": "123 Sports Drive, Athletic City",
      "distance": "2.3 miles away",
      "latitude": 37.7749,
      "longitude": -122.4194
    },
    "pricing": [
      {"type": "Individual Session (1 hour)", "price": "\$80"},
      {"type": "Group Session (1 hour)", "price": "\$45"},
      {"type": "4-Session Package", "price": "\$300"},
      {"type": "8-Session Package", "price": "\$560"}
    ]
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && _isHeaderVisible) {
      setState(() {
        _isHeaderVisible = false;
      });
    } else if (_scrollController.offset <= 200 && !_isHeaderVisible) {
      setState(() {
        _isHeaderVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 30.h,
                floating: false,
                pinned: true,
                backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: _shareProfile,
                    icon: CustomIconWidget(
                      iconName: 'share',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFavorite,
                    icon: CustomIconWidget(
                      iconName: 'favorite_border',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: CoachHeaderWidget(
                    coachData: coachData,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CoachGalleryWidget(
                      gallery: (coachData["gallery"] as List).cast<String>(),
                    ),
                    SizedBox(height: 2.h),
                    CoachAboutWidget(
                      bio: coachData["bio"] as String,
                      philosophy: coachData["philosophy"] as String,
                      credentials:
                          (coachData["credentials"] as List).cast<String>(),
                    ),
                    SizedBox(height: 2.h),
                    CoachExperienceWidget(
                      timeline: (coachData["experience_timeline"] as List)
                          .cast<Map<String, dynamic>>(),
                    ),
                    SizedBox(height: 2.h),
                    CoachAvailabilityWidget(
                      availability: (coachData["availability"] as List)
                          .cast<Map<String, dynamic>>(),
                    ),
                    SizedBox(height: 2.h),
                    CoachReviewsWidget(
                      reviews: (coachData["reviews"] as List)
                          .cast<Map<String, dynamic>>(),
                      rating: coachData["rating"] as double,
                      reviewCount: coachData["reviewCount"] as int,
                    ),
                    SizedBox(height: 2.h),
                    CoachLocationWidget(
                      location: coachData["location"] as Map<String, dynamic>,
                    ),
                    SizedBox(height: 2.h),
                    CoachPricingWidget(
                      pricing: (coachData["pricing"] as List)
                          .cast<Map<String, dynamic>>(),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CoachActionButtonsWidget(
              onBookSession: _bookSession,
              onMessageCoach: _messageCoach,
            ),
          ),
        ],
      ),
    );
  }

  void _shareProfile() {
    // Share profile functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile shared successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _toggleFavorite() {
    // Toggle favorite functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to favorites'),
        backgroundColor: AppTheme.getSuccessColor(true),
      ),
    );
  }

  void _bookSession() {
    // Navigate to booking flow
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening booking flow...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _messageCoach() {
    // Navigate to messaging
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with coach...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }
}

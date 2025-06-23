import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/coach_recommendation_card_widget.dart';
import './widgets/featured_coach_card_widget.dart';
import './widgets/recent_booking_widget.dart';
import './widgets/sport_category_tile_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  int _currentTabIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  // Mock data for coaches
  final List<Map<String, dynamic>> _recommendedCoaches = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "sport": "Tennis",
      "rating": 4.8,
      "distance": "0.5 km",
      "image":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=400",
      "hourlyRate": "\$45",
      "experience": "8 years"
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "sport": "Badminton",
      "rating": 4.9,
      "distance": "1.2 km",
      "image":
          "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400",
      "hourlyRate": "\$40",
      "experience": "6 years"
    },
    {
      "id": 3,
      "name": "Emma Davis",
      "sport": "Cricket",
      "rating": 4.7,
      "distance": "2.1 km",
      "image":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=400",
      "hourlyRate": "\$50",
      "experience": "10 years"
    }
  ];

  final List<Map<String, dynamic>> _featuredCoaches = [
    {
      "id": 4,
      "name": "David Rodriguez",
      "sport": "Tennis",
      "rating": 4.9,
      "bio":
          "Former professional player with 12 years coaching experience. Specializes in advanced techniques and mental game.",
      "image":
          "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=400",
      "hourlyRate": "\$65",
      "experience": "12 years",
      "verified": true
    },
    {
      "id": 5,
      "name": "Lisa Wang",
      "sport": "Badminton",
      "rating": 4.8,
      "bio":
          "National champion turned coach. Expert in footwork, strategy, and competitive play for all skill levels.",
      "image":
          "https://images.pexels.com/photos/1239288/pexels-photo-1239288.jpeg?auto=compress&cs=tinysrgb&w=400",
      "hourlyRate": "\$55",
      "experience": "9 years",
      "verified": true
    }
  ];

  final List<Map<String, dynamic>> _recentBookings = [
    {
      "id": 1,
      "coachName": "Sarah Johnson",
      "sport": "Tennis",
      "date": "Today",
      "time": "3:00 PM",
      "status": "Confirmed",
      "image":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=400"
    },
    {
      "id": 2,
      "coachName": "Mike Chen",
      "sport": "Badminton",
      "date": "Tomorrow",
      "time": "10:00 AM",
      "status": "Pending",
      "image":
          "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400"
    }
  ];

  final List<Map<String, dynamic>> _sportsCategories = [
    {
      "name": "Tennis",
      "icon": "sports_tennis",
      "coaches": 45,
      "color": AppTheme.lightTheme.colorScheme.tertiary
    },
    {
      "name": "Badminton",
      "icon": "sports_baseball",
      "coaches": 32,
      "color": AppTheme.lightTheme.colorScheme.secondary
    },
    {
      "name": "Cricket",
      "icon": "sports_cricket",
      "coaches": 28,
      "color": AppTheme.lightTheme.colorScheme.primary
    },
    {
      "name": "Football",
      "icon": "sports_soccer",
      "coaches": 38,
      "color": AppTheme.getSuccessColor(true)
    }
  ];

  final List<String> _sportFilters = [
    "All",
    "Tennis",
    "Badminton",
    "Cricket",
    "Football"
  ];
  String _selectedFilter = "All";

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });

    // Navigate to different screens based on tab
    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/coach-search-discovery');
        break;
      case 2:
        // Bookings tab - could navigate to bookings screen
        break;
      case 3:
        // Profile tab - could navigate to profile screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppTheme.lightTheme.colorScheme.tertiary,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchSection(),
                  SizedBox(height: 2.h),
                  _buildRecommendedCoaches(),
                  SizedBox(height: 3.h),
                  _buildFeaturedCoaches(),
                  SizedBox(height: 3.h),
                  _buildRecentBookings(),
                  SizedBox(height: 3.h),
                  _buildPopularSports(),
                  SizedBox(height: 10.h), // Space for FAB
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/coach-search-discovery');
        },
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
        foregroundColor: Colors.white,
        icon: CustomIconWidget(
          iconName: 'location_on',
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          'Find Coaches Near Me',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
        unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _currentTabIndex == 0
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'search',
              color: _currentTabIndex == 1
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'calendar_today',
              color: _currentTabIndex == 2
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: _currentTabIndex == 3
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 12.h,
      floating: true,
      pinned: true,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle location change
                        },
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'location_on',
                              color: AppTheme.lightTheme.colorScheme.tertiary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Location',
                                    style:
                                        AppTheme.lightTheme.textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'New York, NY',
                                    style: AppTheme
                                        .lightTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            CustomIconWidget(
                              iconName: 'keyboard_arrow_down',
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle notifications
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            CustomIconWidget(
                              iconName: 'notifications',
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              size: 24,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.lightTheme.colorScheme.tertiary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search coaches or sports...',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/coach-search-discovery');
              },
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 5.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sportFilters.length,
              itemBuilder: (context, index) {
                final filter = _sportFilters[index];
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                    selectedColor: AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.2),
                    labelStyle:
                        AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.outline,
                      width: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCoaches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended for You',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/coach-search-discovery');
                },
                child: Text(
                  'See All',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 25.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: _recommendedCoaches.length,
            itemBuilder: (context, index) {
              final coach = _recommendedCoaches[index];
              return Padding(
                padding: EdgeInsets.only(right: 3.w),
                child: CoachRecommendationCardWidget(
                  coach: coach,
                  onTap: () {
                    Navigator.pushNamed(context, '/coach-profile-detail');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCoaches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Featured Coaches',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: _featuredCoaches.length,
          itemBuilder: (context, index) {
            final coach = _featuredCoaches[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: FeaturedCoachCardWidget(
                coach: coach,
                onTap: () {
                  Navigator.pushNamed(context, '/coach-profile-detail');
                },
                onBookNow: () {
                  // Handle booking
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentBookings() {
    if (_recentBookings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Recent Bookings',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: _recentBookings.length,
          itemBuilder: (context, index) {
            final booking = _recentBookings[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: RecentBookingWidget(
                booking: booking,
                onTap: () {
                  // Handle booking tap
                },
                onContact: () {
                  // Handle contact coach
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularSports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Popular Sports',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 1.5,
            ),
            itemCount: _sportsCategories.length,
            itemBuilder: (context, index) {
              final sport = _sportsCategories[index];
              return SportCategoryTileWidget(
                sport: sport,
                onTap: () {
                  Navigator.pushNamed(context, '/coach-search-discovery');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

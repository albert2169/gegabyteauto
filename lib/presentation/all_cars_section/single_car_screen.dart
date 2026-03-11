import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:shimmer/shimmer.dart';

class SingleCarScreen extends StatefulWidget {
  final CarViewModel car;

  const SingleCarScreen({super.key, required this.car});

  @override
  State<SingleCarScreen> createState() => _SingleCarScreenState();
}

class _SingleCarScreenState extends State<SingleCarScreen> {
  late final PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.car.singleCarInfoViewModel;
    final owner = info.carOwnerInfoViewModel;
    final images = info.images;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Image carousel as SliverAppBar
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.black,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border,
                      color: Colors.white, size: 22),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share_outlined,
                      color: Colors.white, size: 22),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image PageView
                  PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (i) =>
                        setState(() => _currentImageIndex = i),
                    itemBuilder: (context, i) {
                      final url = images[i].networkImageUrl;
                      if (url != null && url.isNotEmpty) {
                        return CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Shimmer.fromColors(
                            baseColor: Colors.white.withValues(alpha: 0.06),
                            highlightColor:
                                Colors.white.withValues(alpha: 0.15),
                            child: Container(color: Colors.white10),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: Colors.white10,
                            child: const Center(
                              child: Icon(Icons.broken_image_outlined,
                                  color: Colors.white24, size: 60),
                            ),
                          ),
                        );
                      }
                      return Container(
                        color: Colors.white10,
                        child: const Center(
                          child: Icon(Icons.photo_outlined,
                              color: Colors.white24, size: 60),
                        ),
                      );
                    },
                  ),

                  // Bottom gradient
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.black.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Dot indicators
                  Positioned(
                    bottom: 14,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentImageIndex == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentImageIndex == i
                                ? const Color(0xFF3255ED)
                                : Colors.white38,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Image counter badge
                  Positioned(
                    bottom: 14,
                    right: 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_currentImageIndex + 1}/${images.length}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Brand + model + seria
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          widget.car.brandLogoImageAsset,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.directions_car,
                                color: Colors.white54, size: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${info.brand} ${info.model}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              widget.car.seria,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Price
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3255ED), Color(0xFF1A3DB8)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.attach_money,
                            color: Colors.white, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          info.price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Quick specs grid
                  _sectionTitle('Specifications'),
                  const SizedBox(height: 12),
                  _specsGrid(info),

                  const SizedBox(height: 28),

                  // Description
                  _sectionTitle('Description'),
                  const SizedBox(height: 12),
                  Text(
                    info.description,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Owner info
                  _sectionTitle('Owner Details'),
                  const SizedBox(height: 12),
                  _ownerCard(owner),

                  const SizedBox(height: 32),

                  // Contact button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone, size: 22),
                      label: Text(
                        'Call ${owner.phoneNumber}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2ECC71),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _specsGrid(info) {
    final specs = <MapEntry<IconData, String>>[
      MapEntry(Icons.calendar_today, info.year),
      MapEntry(Icons.speed, info.mileage),
      MapEntry(Icons.settings, info.gearBox),
      MapEntry(Icons.local_gas_station, info.engine),
      MapEntry(Icons.engineering, info.engineVolume),
      MapEntry(Icons.palette, info.color),
      MapEntry(Icons.verified_user, info.condition),
      MapEntry(Icons.airline_seat_recline_extra, info.interior),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.8,
      ),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        final spec = specs[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              Icon(spec.key, color: const Color(0xFF3255ED), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  spec.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _ownerCard(owner) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          _ownerRow(Icons.person, 'Name', owner.name),
          const Divider(color: Colors.white10, height: 20),
          _ownerRow(Icons.location_city, 'City', owner.city),
          const Divider(color: Colors.white10, height: 20),
          _ownerRow(Icons.phone, 'Phone', owner.phoneNumber),
          const Divider(color: Colors.white10, height: 20),
          _ownerRow(Icons.calendar_month, 'Published', owner.releaseDate),
          const Divider(color: Colors.white10, height: 20),
          _ownerRow(Icons.update, 'Last Update', owner.lastUpdate),
        ],
      ),
    );
  }

  Widget _ownerRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 20),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

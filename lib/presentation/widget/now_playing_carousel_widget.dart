import 'package:flutter/material.dart';

class NowPlayingCarouselWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final VoidCallback? onSeeAllTap;

  const NowPlayingCarouselWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    this.onSeeAllTap,
  });

  Color get _badgeColor {
    if (rating >= 7.0) return const Color(0xFF16A34A); // hijau
    if (rating >= 5.0) return const Color(0xFFFACC15); // kuning
    return const Color(0xFFDC2626); // merah
  }

  Color get _bageFontColor {
    if (rating >= 7.0) return Colors.white; // hijau
    if (rating >= 5.0) return Colors.black; // kuning
    return Colors.white; // merah
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (rating * 10).toStringAsFixed(0);

    return GestureDetector(
      onTap: onSeeAllTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Poster
              Image.network(
                imageUrl,
                width: 160,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              ),
              // Gradient overlay bawah biar teks kebaca
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              // Badge rating (pojok kiri bawah)
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "$percentage%",
                    style: TextStyle(
                      color: _bageFontColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

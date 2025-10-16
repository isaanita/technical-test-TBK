import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TrendingMoviesVariant { defaultCard, compact }

class TrendingMoviesCarouselWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? description;
  final String rating;
  final String? releaseDate;
  final TrendingMoviesVariant variant;
  final VoidCallback? onSeeAllTap;

  const TrendingMoviesCarouselWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    this.description,
    required this.rating,
    this.releaseDate,
    this.variant = TrendingMoviesVariant.defaultCard,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == TrendingMoviesVariant.compact) {
      return _buildCompactCard(context);
    } else {
      return _buildDefaultCard(context);
    }
  }

  // 🔹 Tampilan compact (kayak The Shawshank Redemption)
  Widget _buildCompactCard(BuildContext context) {
    final formattedDate = (releaseDate != null && releaseDate!.isNotEmpty)
        ? DateFormat('MMM dd, yyyy').format(DateTime.parse(releaseDate!))
        : '';

    return GestureDetector(
      onTap: onSeeAllTap,
      child: Container(
        width: 330,
        margin: const EdgeInsets.only(right: 12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color.fromRGBO(229, 232, 235, 1),
              width: 1,
            ),
          ),
          color: Colors.white,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image_outlined, size: 40),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(113, 116, 125, 1),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Color.fromRGBO(113, 63, 18, 1),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '$rating%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(113, 63, 18, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Tampilan default (punya kamu yang lama)
  Widget _buildDefaultCard(BuildContext context) {
    return GestureDetector(
      onTap: onSeeAllTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 330,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color.fromRGBO(229, 232, 235, 1),
              width: 1,
            ),
          ),
          color: Colors.white,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        color: Colors.grey[200],
                        child:
                            const Icon(Icons.broken_image_outlined, size: 40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color.fromRGBO(250, 204, 21, 1),
                          width: 1,
                        ),
                      ),
                      color: const Color.fromRGBO(250, 204, 21, 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_outlined,
                              color: Color.fromRGBO(113, 63, 18, 1),
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "$rating%",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color.fromRGBO(113, 63, 18, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: -1,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(113, 116, 125, 1),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

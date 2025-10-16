import 'package:flutter/material.dart';

class SectionTitleHomePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showSeeAll;
  final VoidCallback? onSeeAllTap;

  const SectionTitleHomePage({
    super.key,
    required this.title,
    required this.subtitle,
    this.showSeeAll = true,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Kiri: title + subtitle
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(113, 116, 125, 1),
              ),
            ),
          ],
        ),

        // Kanan: "Lihat Semua" (ditampilkan hanya kalau showSeeAll == true)
        if (showSeeAll)
          GestureDetector(
            onTap: onSeeAllTap,
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(63, 85, 198, 1),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 12,
                    color: Color.fromRGBO(63, 85, 198, 1),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

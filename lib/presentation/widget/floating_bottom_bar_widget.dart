import 'package:flutter/material.dart';

class FloatingBottomBar extends StatefulWidget {
  final int currentIndex;
  const FloatingBottomBar({super.key, required this.currentIndex});

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentIndex; // ✅ Ambil dari parameter
  }

  final List<_NavItem> items = [
    const _NavItem(icon: Icons.home_outlined, label: "Beranda"),
    const _NavItem(icon: Icons.bookmark_border, label: "Watchlist"),
    const _NavItem(icon: Icons.person_outline, label: "Profil"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            shadowColor: Colors.black.withOpacity(0.1),
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final isSelected = index == selectedIndex;
                  final item = items[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(30),
                    splashColor: const Color(0xFF3F55C6).withOpacity(0.2),
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else if (index == 1) {
                        Navigator.pushReplacementNamed(context, '/watchlist');
                      } else if (index == 2) {
                        Navigator.pushReplacementNamed(context, '/profile');
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3F55C6)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 20,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            Text(
                              item.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

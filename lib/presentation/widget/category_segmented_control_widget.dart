import 'package:flutter/material.dart';

class CategorySegmentedControlWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<int>? onChanged;
  final int initialIndex;

  const CategorySegmentedControlWidget({
    super.key,
    required this.items,
    this.onChanged,
    this.initialIndex = 0,
  });

  @override
  State<CategorySegmentedControlWidget> createState() =>
      _CategorySegmentedControlWidgetState();
}

class _CategorySegmentedControlWidgetState
    extends State<CategorySegmentedControlWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(widget.items.length, (index) {
        final isSelected = index == selectedIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onChanged?.call(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3F55C6)
                    : const Color(0xFFF5F6FE),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3F55C6)
                      : const Color(0xFFE0E3FF),
                  width: 1.2,
                ),
              ),
              child: Text(
                widget.items[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF3F55C6),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

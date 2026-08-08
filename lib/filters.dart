import 'package:flutter/material.dart';

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kTeal = Color(0xFF00897B);
const Color kTealLight = Color(0xFFE0F2F1);
const Color kGrey = Color(0xFFF0F0F0);
const Color kGreyDark = Color(0xFF9E9E9E);
const Color kText = Color(0xFF212121);

// ─── Filter State Model ───────────────────────────────────────────────────────

class FilterState {
  String? selectedGender;          // null = nothing selected
  String? selectedCategory;        // null = nothing selected
  final Set<String> selectedSizes;
  double minPrice;
  double maxPrice;
  final Set<String> selectedCategoryCheckboxes;

  FilterState({
    this.selectedGender,
    this.selectedCategory,
    Set<String>? selectedSizes,
    this.minPrice = 0,
    this.maxPrice = 0,
    Set<String>? selectedCategoryCheckboxes,
  })  : selectedSizes = selectedSizes ?? {},
        selectedCategoryCheckboxes = selectedCategoryCheckboxes ?? {};

  FilterState copyWith({
    Object? selectedGender = _sentinel,
    Object? selectedCategory = _sentinel,
    Set<String>? selectedSizes,
    double? minPrice,
    double? maxPrice,
    Set<String>? selectedCategoryCheckboxes,
  }) {
    return FilterState(
      selectedGender: selectedGender == _sentinel
          ? this.selectedGender
          : selectedGender as String?,
      selectedCategory: selectedCategory == _sentinel
          ? this.selectedCategory
          : selectedCategory as String?,
      selectedSizes: selectedSizes ?? Set.from(this.selectedSizes),
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      selectedCategoryCheckboxes: selectedCategoryCheckboxes ??
          Set.from(this.selectedCategoryCheckboxes),
    );
  }

  FilterState reset() => FilterState();
}

const _sentinel = Object();

// ─── Demo Page ────────────────────────────────────────────────────────────────

class FilterDemoPage extends StatefulWidget {
  const FilterDemoPage({super.key});

  @override
  State<FilterDemoPage> createState() => _FilterDemoPageState();
}

class _FilterDemoPageState extends State<FilterDemoPage> {
  FilterState _filters = FilterState();

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterSheet(
        initial: _filters,
        onApply: (newFilters) {
          setState(() => _filters = newFilters);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBDBDBD),
        elevation: 0,
        title: const Text('Filter Demo', style: TextStyle(color: kText)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sidebar preview (Category checkboxes)
            _CategorySidebarPreview(filters: _filters),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _openFilterSheet,
              icon: const Icon(Icons.tune),
              label: const Text('Open Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: kTeal,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Category Sidebar Preview ─────────────────────────────────────────────────

class _CategorySidebarPreview extends StatelessWidget {
  final FilterState filters;

  const _CategorySidebarPreview({required this.filters});

  static const List<String> _categories = [
    'Jackets', 'Pants', 'Shorts', 'Skirts',
    'Accessories', 'Hoodies', 'Socks',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category',
              style: TextStyle(
                  fontSize: 13,
                  color: kGreyDark,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          ..._categories.map((cat) {
            final checked =
                filters.selectedCategoryCheckboxes.contains(cat);
            return Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: checked,
                    onChanged: null, // read-only preview
                    activeColor: kTeal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(cat,
                    style: const TextStyle(fontSize: 14, color: kText)),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ─── Filter Bottom Sheet ──────────────────────────────────────────────────────

class FilterSheet extends StatefulWidget {
  final FilterState initial;
  final ValueChanged<FilterState> onApply;

  const FilterSheet({
    super.key,
    required this.initial,
    required this.onApply,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late FilterState _local;

  final _minController = TextEditingController();
  final _maxController = TextEditingController();

  static const List<String> _genders = ['Men', 'Women', 'Unisex'];
  static const List<String> _categories = [
    'All', 'Jackets', 'Pants', 'Shorts',
    'Skirts', 'Accessories', 'Hoodies', 'Socks',
  ];
  static const List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  @override
  void initState() {
    super.initState();
    _local = widget.initial.copyWith();
    _minController.text =
        _local.minPrice == 0 ? '' : _local.minPrice.toStringAsFixed(0);
    _maxController.text =
        _local.maxPrice == 0 ? '' : _local.maxPrice.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _local = FilterState();
      _minController.clear();
      _maxController.clear();
    });
  }

  void _toggleSize(String size) {
    final sizes = Set<String>.from(_local.selectedSizes);
    if (sizes.contains(size)) {
      sizes.remove(size);
    } else {
      sizes.add(size);
    }
    setState(() => _local = _local.copyWith(selectedSizes: sizes));
  }

  void _toggleCategory(String cat) {
    // also sync the checkbox sidebar
    final cats = Set<String>.from(_local.selectedCategoryCheckboxes);
    if (cat == 'All') {
      cats.clear();
    } else {
      if (cats.contains(cat)) {
        cats.remove(cat);
      } else {
        cats.add(cat);
      }
    }
    setState(() => _local = _local.copyWith(
          selectedCategory: cat == 'All' ? null : cat,
          selectedCategoryCheckboxes: cats,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Filters',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _reset,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 15,
                          color: kGreyDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // ── Gender ──────────────────────────────────────────────
                    _SectionLabel('Gender'),
                    const SizedBox(height: 12),
                    Row(
                      children: _genders.map((g) {
                        final selected = _local.selectedGender == g;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _ToggleChip(
                              label: g,
                              selected: selected,
                              onTap: () => setState(() => _local =
                                  _local.copyWith(
                                      selectedGender:
                                          selected ? _sentinel : g)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // ── Category ─────────────────────────────────────────────
                    _SectionLabel('Category'),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _local.selectedCategory ?? 'All',
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(12),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: kGreyDark),
                          items: _categories
                              .map((c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(c,
                                        style: const TextStyle(
                                            fontSize: 15, color: kText)),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) _toggleCategory(val);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Size ─────────────────────────────────────────────────
                    _SectionLabel('Size'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _sizes.map((s) {
                        final selected = _local.selectedSizes.contains(s);
                        return _ToggleChip(
                          label: s,
                          selected: selected,
                          onTap: () => _toggleSize(s),
                          width: 56,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // ── Price ─────────────────────────────────────────────────
                    _SectionLabel('Price'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Min.',
                            style: TextStyle(
                                fontSize: 14, color: kGreyDark)),
                        const SizedBox(width: 8),
                        _PriceField(
                          controller: _minController,
                          onChanged: (v) => setState(() =>
                              _local = _local.copyWith(
                                  minPrice: double.tryParse(v) ?? 0)),
                        ),
                        const SizedBox(width: 16),
                        const Text('Max.',
                            style: TextStyle(
                                fontSize: 14, color: kGreyDark)),
                        const SizedBox(width: 8),
                        _PriceField(
                          controller: _maxController,
                          onChanged: (v) => setState(() =>
                              _local = _local.copyWith(
                                  maxPrice: double.tryParse(v) ?? 0)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Apply Button
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20, 0, 20, MediaQuery.of(context).padding.bottom + 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_local);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTeal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Reusable Widgets ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 17, fontWeight: FontWeight.w600, color: kText),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double? width;

  const _ToggleChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: width,
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? kTeal : kGrey,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : kGreyDark,
          ),
        ),
      ),
    );
  }
}

class _PriceField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _PriceField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: const TextStyle(color: kGreyDark),
          filled: true,
          fillColor: kGrey,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
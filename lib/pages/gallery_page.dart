import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/stagger_fade_list.dart';
import '../widgets/text_reveal.dart';
import '../widgets/floating_widget.dart';
import '../widgets/hover_card.dart';
import '../data.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String _selectedCategory = 'All';

  List<String> get _categories {
    final cats = Data.gallery.map((e) => e.category).toSet().toList();
    return ['All', ...cats];
  }

  List<GalleryItem> get _filteredItems {
    if (_selectedCategory == 'All') return Data.gallery;
    return Data.gallery
        .where((e) => e.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerSection(context),
          _filterChips(),
          _masonryGrid(context),
          _videoSection(context),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.darkGreen, AppTheme.primaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const FloatingWidget(
            child: Icon(Icons.photo_library, color: Colors.white24, size: 48),
          ),
          const SizedBox(height: 16),
          TextReveal(
            text: 'Gallery',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 12),
          ScrollReveal(
            child: Text(
              'Moments captured from our events and activities',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChips() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ScrollReveal(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: _categories.map((cat) {
            final isSelected = _selectedCategory == cat;
            return ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (v) => setState(() => _selectedCategory = cat),
              selectedColor: AppTheme.primaryGreen,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.w600 : null,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _masonryGrid(BuildContext context) {
    final items = _filteredItems;
    final mid = (items.length / 2).ceil();
    final col1 = items.take(mid).toList();
    final col2 = items.skip(mid).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: StaggerFadeList(
        itemDelay: const Duration(milliseconds: 60),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: col1
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: HoverCard(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _showLightbox(
                              context,
                              _filteredItems.indexOf(item),
                            ),
                            child: _galleryPlaceholder(item),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: col2
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: HoverCard(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _showLightbox(
                              context,
                              _filteredItems.indexOf(item),
                            ),
                            child: _galleryPlaceholder(item),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _galleryPlaceholder(GalleryItem item) {
    final colors = [
      AppTheme.primaryGreen,
      AppTheme.primaryBlue,
      AppTheme.warmAmber,
      AppTheme.accentGreen,
      AppTheme.lightBlue,
      AppTheme.earthBrown,
    ];
    final color = colors[item.title.length % colors.length];

    if (item.image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          item.image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholderContent(item, color),
        ),
      );
    }

    return _placeholderContent(item, color);
  }

  Widget _placeholderContent(GalleryItem item, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.image, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item.category,
              style: TextStyle(fontSize: 11, color: color),
            ),
          ),
        ],
      ),
    );
  }

  void _showLightbox(BuildContext context, int index) {
    final items = _filteredItems;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => Scaffold(
          backgroundColor: Colors.black.withValues(alpha: 0.92),
          body: Stack(
            children: [
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _lightboxContent(items[index]),
                ),
              ),
              Positioned(
                top: 48,
                right: 24,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              if (items.length > 1) ...[
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white70,
                      ),
                      onPressed: index > 0
                          ? () {
                              _showLightbox(context, index - 1);
                              Navigator.of(context).pop();
                            }
                          : null,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                      ),
                      onPressed: index < items.length - 1
                          ? () {
                              _showLightbox(context, index + 1);
                              Navigator.of(context).pop();
                            }
                          : null,
                    ),
                  ),
                ),
              ],
              Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Text(
                  '${index + 1} / ${items.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        transitionsBuilder: (_, anim, __, child) => ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(opacity: anim, child: child),
        ),
      ),
    );
  }

  Widget _lightboxContent(GalleryItem item) {
    final colors = [
      AppTheme.primaryGreen,
      AppTheme.primaryBlue,
      AppTheme.warmAmber,
      AppTheme.accentGreen,
    ];
    final color = colors[item.title.length % colors.length];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      key: ValueKey(item.title),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                item.image,
                width: 400,
                height: 400,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.image, color: color, size: 80),
                ),
              ),
            )
          else
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.image, color: color, size: 80),
            ),
          const SizedBox(height: 24),
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item.category,
              style: TextStyle(color: color, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: isDark ? AppTheme.darkSurface : Colors.white,
      child: Column(
        children: [
          TextReveal(
            text: 'Video Highlights',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Watch our activities in action',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 100),
            children: [
              HoverCard(
                child: Card(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryGreen.withValues(alpha: 0.8),
                          AppTheme.darkGreen,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle,
                            color: Colors.white,
                            size: 56,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Environmental Activities 2026',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/stagger_fade_list.dart';
import '../widgets/text_reveal.dart';
import '../widgets/floating_widget.dart';
import '../widgets/hover_card.dart';
import '../data.dart';

class HomePage extends StatelessWidget {
  final ValueChanged<int>? onPageChanged;

  const HomePage({super.key, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 768;
    return SingleChildScrollView(
      child: Column(
        children: [
          _heroSection(context, isDark, isWide),
          _galleryPreviewSection(context),
          _upcomingEventsSection(context),
          _newsSection(context),
        ],
      ),
    );
  }

  Widget _heroSection(BuildContext context, bool isDark, bool isWide) {
    final heroForeground = Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FloatingWidget(
            child: Icon(Icons.eco, color: AppTheme.lightGreen, size: 64),
          ),
          const SizedBox(height: 16),
          TextReveal(
            text:
                'Empowering Students to\nProtect the Environment\nThrough Science and Action.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isWide ? 44 : 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
            itemDuration: const Duration(milliseconds: 50),
          ),
          const SizedBox(height: 16),
          ScrollReveal(
            delay: const Duration(milliseconds: 300),
            child: Text(
              'Belison National Science High School',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isWide ? 18 : 15,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ScrollReveal(
            delay: const Duration(milliseconds: 400),
            child: Text(
              'YES-O Club • Youth for Environment and Science Organization',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isWide ? 15 : 13,
                color: AppTheme.lightGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 36),
          ScrollReveal(
            delay: const Duration(milliseconds: 500),
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    onPageChanged?.call(6);
                  },
                  icon: const Icon(Icons.eco, size: 20),
                  label: const Text('Contact Us'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                HoverCard(
                  borderRadius: BorderRadius.circular(30),
                  scale: 1.03,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      onPageChanged?.call(1);
                    },
                    icon: const Icon(Icons.visibility, size: 20),
                    label: const Text('Learn More'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/hero.jpg',
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    color: AppTheme.darkGreen,
                  ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          heroForeground,
        ],
      ),
    );
  }

  Widget _galleryPreviewSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final preview = Data.gallery.take(6).toList();
    final colors = [
      AppTheme.primaryGreen,
      AppTheme.primaryBlue,
      AppTheme.warmAmber,
      AppTheme.accentGreen,
      AppTheme.lightBlue,
      AppTheme.earthBrown,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: isDark ? AppTheme.darkSurface : Colors.white,
      child: Column(
        children: [
          TextReveal(
            text: 'Gallery Highlights',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'A glimpse of our activities and events',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 700 ? 3 : 2;
              final childWidth =
                  (constraints.maxWidth - (crossAxisCount - 1) * 12.0) /
                      crossAxisCount;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final (i, item) in preview.indexed)
                    SizedBox(
                      width: childWidth,
                      child: ScrollReveal(
                        delay: Duration(milliseconds: 80 * i),
                        child: HoverCard(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: (colors[i % colors.length])
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.image.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item.image,
                                      width: double.infinity,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: (colors[i % colors.length])
                                              .withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.image,
                                          color: colors[i % colors.length],
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (colors[i % colors.length])
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.image,
                                      color: colors[i % colors.length],
                                      size: 24,
                                    ),
                                  ),
                                const SizedBox(height: 12),
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (colors[i % colors.length])
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    item.category,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: colors[i % colors.length],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _upcomingEventsSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final upcoming = Data.events.where((e) => e.isUpcoming).take(3).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: isDark ? AppTheme.darkSurface : Colors.white,
      child: Column(
        children: [
          TextReveal(
            text: 'Upcoming Events',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Join us in our upcoming activities',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 100),
            children: [
              ...upcoming.map(
                (event) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HoverCard(
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.event,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        title: Text(
                          event.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${event.date} • ${event.location}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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

  Widget _newsSection(BuildContext context) {
    final articles = Data.articles.take(3).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          TextReveal(
            text: 'Latest News',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Stay updated with our latest articles',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 100),
            children: [
              ...articles.map(
                (article) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HoverCard(
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryGreen.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    article.category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primaryGreen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  article.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article.summary,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
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

import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/stagger_fade_list.dart';
import '../widgets/text_reveal.dart';
import '../widgets/floating_widget.dart';
import '../widgets/hover_card.dart';
import '../data.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  int _factIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () => _cycleFact());
  }

  void _cycleFact() {
    if (!mounted) return;
    setState(() => _factIndex = (_factIndex + 1) % Data.funFacts.length);
    Future.delayed(const Duration(seconds: 5), _cycleFact);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerSection(context),
          _topicsGrid(context),
          _articlesSection(context),
          _funFactsSection(context, isDark),
          _resourcesSection(context),
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
            child: Icon(Icons.school, color: Colors.white24, size: 48),
          ),
          const SizedBox(height: 16),
          TextReveal(
            text: 'Education',
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
              'Learn about the environment and science',
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

  Widget _topicsGrid(BuildContext context) {
    final topics = [
      {
        'icon': Icons.thermostat,
        'title': 'Climate Change',
        'desc': 'Understanding global warming and its effects',
        'color': AppTheme.warmAmber,
      },
      {
        'icon': Icons.forest,
        'title': 'Biodiversity',
        'desc': 'The variety of life on Earth',
        'color': AppTheme.primaryGreen,
      },
      {
        'icon': Icons.recycling,
        'title': 'Waste Management',
        'desc': 'Reduce, reuse, and recycle',
        'color': AppTheme.primaryBlue,
      },
      {
        'icon': Icons.solar_power,
        'title': 'Renewable Energy',
        'desc': 'Powering a sustainable future',
        'color': AppTheme.warmAmber,
      },
      {
        'icon': Icons.water_drop,
        'title': 'Water Conservation',
        'desc': 'Protecting our water resources',
        'color': AppTheme.lightBlue,
      },
      {
        'icon': Icons.eco,
        'title': 'Sustainable Living',
        'desc': 'Eco-friendly daily practices',
        'color': AppTheme.accentGreen,
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          TextReveal(
            text: 'Explore Topics',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Learn about key environmental concepts',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 60),
            children: [
              ...topics.map(
                (t) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HoverCard(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: (t['color'] as Color)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                t['icon'] as IconData,
                                color: t['color'] as Color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t['title'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    t['desc'] as String,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey.shade400,
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

  Widget _articlesSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: isDark ? AppTheme.darkSurface : Colors.white,
      child: Column(
        children: [
          TextReveal(
            text: 'Articles & Resources',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Read our environmental articles',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 70),
            children: [
              ...Data.articles.map(
                (article) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HoverCard(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGreen.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.article,
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryGreen
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          article.category,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: AppTheme.primaryGreen,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        article.date,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey.shade400,
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

  Widget _funFactsSection(BuildContext context, bool isDark) {
    final colors = [
      AppTheme.primaryGreen,
      AppTheme.primaryBlue,
      AppTheme.warmAmber,
      AppTheme.accentGreen,
    ];
    final color = colors[_factIndex % colors.length];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          TextReveal(
            text: 'Did You Know?',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Interesting environmental facts',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          ScrollReveal(
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.1),
                      color.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.lightbulb, color: color, size: 40),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: Text(
                        Data.funFacts[_factIndex],
                        key: ValueKey(_factIndex),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resourcesSection(BuildContext context) {
    final resources = [
      {'icon': Icons.picture_as_pdf, 'title': 'Environmental Handbook', 'color': AppTheme.warmAmber},
      {'icon': Icons.assignment, 'title': 'Activity Worksheets', 'color': AppTheme.primaryBlue},
      {'icon': Icons.video_library, 'title': 'Educational Videos', 'color': AppTheme.accentGreen},
      {'icon': Icons.web, 'title': 'Useful Links', 'color': AppTheme.primaryGreen},
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: isDark ? AppTheme.darkSurface : Colors.white,
      child: Column(
        children: [
          TextReveal(
            text: 'Learning Resources',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Tools and materials to deepen your knowledge',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 80),
            children: [
              ...resources.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HoverCard(
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (r['color'] as Color)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            r['icon'] as IconData,
                            color: r['color'] as Color,
                          ),
                        ),
                        title: Text(
                          r['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'View',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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

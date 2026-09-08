import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/stagger_fade_list.dart';
import '../widgets/text_reveal.dart';
import '../widgets/floating_widget.dart';
import '../widgets/hover_card.dart';
import '../data.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerSection(context),
          _missionVision(context),
          _coreValues(context),
          _historySection(context),
          _teamSection(context),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.darkGreen, AppTheme.primaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const FloatingWidget(
            child: Icon(Icons.info_outline, color: Colors.white24, size: 48),
          ),
          const SizedBox(height: 16),
          TextReveal(
            text: 'About YES-O',
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
              'Youth for Environment in Schools Organization',
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

  Widget _missionVision(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.darkSurface : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: bgColor,
      child: Column(
        children: [
          TextReveal(
            text: 'Our Mission & Vision',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 120),
            children: [
              HoverCard(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.flag,
                            color: AppTheme.primaryGreen,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Our Mission',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'To empower students to become environmental stewards through science education, community action, and sustainable practices that protect our planet for future generations.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              HoverCard(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.visibility,
                            color: AppTheme.primaryBlue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Our Vision',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'A generation of environmentally conscious leaders who use science and innovation to create a sustainable and thriving world.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _coreValues(BuildContext context) {
    final values = [
      {
        'icon': Icons.eco,
        'title': 'Environmental\nStewardship',
        'desc': 'Protecting and preserving our natural resources for future generations.',
        'color': AppTheme.primaryGreen,
      },
      {
        'icon': Icons.science,
        'title': 'Scientific\nExcellence',
        'desc': 'Promoting evidence-based solutions to environmental challenges.',
        'color': AppTheme.primaryBlue,
      },
      {
        'icon': Icons.groups,
        'title': 'Community\nEngagement',
        'desc': 'Working together to create meaningful environmental impact.',
        'color': AppTheme.warmAmber,
      },
      {
        'icon': Icons.recycling,
        'title': 'Sustainable\nPractices',
        'desc': 'Embracing habits that reduce our ecological footprint.',
        'color': AppTheme.accentGreen,
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          TextReveal(
            text: 'Core Values',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'The principles that guide our organization',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 80),
            children: [
              ...values.map(
                (v) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HoverCard(
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: (v['color'] as Color)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  v['icon'] as IconData,
                                  color: v['color'] as Color,
                                  size: 36,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                v['title'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                v['desc'] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _historySection(BuildContext context) {
    final milestones = [
      {'year': '2018', 'event': 'YES-O Club founded at Belison National Science High School'},
      {'year': '2019', 'event': 'First tree planting event with 200 participants'},
      {'year': '2020', 'event': 'Launched online environmental awareness campaigns'},
      {'year': '2021', 'event': 'Won Regional Science & Environment Competition'},
      {'year': '2022', 'event': 'Expanded to 500+ active members'},
      {'year': '2023', 'event': 'Implemented school-wide recycling program'},
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          TextReveal(
            text: 'Our Journey',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Milestones that shaped our organization',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 80),
            children: [
              ...milestones.map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              m['year'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 40,
                            color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              m['event'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teamSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [
          TextReveal(
            text: 'Our Team',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'Meet our dedicated officers and advisers',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          TextReveal(
            text: 'Club Officers',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
            itemDuration: const Duration(milliseconds: 60),
          ),
          const SizedBox(height: 20),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 80),
            children: [
              ...Data.officers.map(
                (member) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HoverCard(
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primaryGreen.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            member.name.split(' ').map((n) => n[0]).join(),
                            style: const TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        title: Text(
                          member.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(member.role),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Officer',
                            style: TextStyle(
                              fontSize: 11,
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
          const SizedBox(height: 40),
          TextReveal(
            text: 'Advisers',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
            itemDuration: const Duration(milliseconds: 60),
          ),
          const SizedBox(height: 20),
          StaggerFadeList(
            itemDelay: const Duration(milliseconds: 100),
            children: [
              ...Data.advisers.map(
                (member) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HoverCard(
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primaryBlue.withValues(
                            alpha: 0.1,
                          ),
                          child: Text(
                            member.name.split(' ').map((n) => n[0]).join(),
                            style: const TextStyle(
                              color: AppTheme.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        title: Text(
                          member.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(member.role),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Adviser',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.primaryBlue,
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

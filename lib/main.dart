import 'package:flutter/material.dart';
import 'theme.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/events_page.dart';
import 'pages/gallery_page.dart';
import 'pages/education_page.dart';
import 'pages/projects_page.dart';
import 'pages/contact_page.dart';
import 'widgets/footer.dart';
import 'widgets/nav_bar.dart';

void main() {
  runApp(const YESOApp());
}

class YESOApp extends StatelessWidget {
  const YESOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YES-O',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;
  bool _isDark = false;
  bool _isScrolled = false;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(onPageChanged: _onPageChanged),
      const AboutPage(),
      const EventsPage(),
      const GalleryPage(),
      const EducationPage(),
      const ProjectsPage(),
      const ContactPage(),
    ]);
  }

  void _onPageChanged(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
      _isScrolled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YES-O',
      theme: _isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: Theme(
        data: _isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        child: Scaffold(
          drawer: ResponsiveNavBar.buildDrawer(
            context,
            _currentIndex,
            _onPageChanged,
          ),
          body: Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels > 60) {
                    if (!_isScrolled) setState(() => _isScrolled = true);
                  } else {
                    if (_isScrolled) setState(() => _isScrolled = false);
                  }
                  return false;
                },
                child: _pages[_currentIndex],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: const AppFooter(),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ResponsiveNavBar(
                  currentIndex: _currentIndex,
                  onPageChanged: _onPageChanged,
                  onToggleTheme: () => setState(() => _isDark = !_isDark),
                  isDark: _isDark,
                  isScrolled: _isScrolled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

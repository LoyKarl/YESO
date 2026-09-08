import 'package:flutter/material.dart';
import '../theme.dart';

class ResponsiveNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onToggleTheme;
  final bool isDark;
  final bool isScrolled;

  const ResponsiveNavBar({
    super.key,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onToggleTheme,
    required this.isDark,
    this.isScrolled = false,
  });

  static Widget buildDrawer(BuildContext context, int currentIndex, ValueChanged<int> onPageChanged) {
    final titles = ['Home', 'About Us', 'Events', 'Gallery', 'Education', 'Projects', 'Contact'];
    final icons = [Icons.home, Icons.info, Icons.event, Icons.photo_library, Icons.school, Icons.handyman, Icons.contact_mail];
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipOval(child: Image.asset('assets/images/logo.png', height: 48, width: 48, fit: BoxFit.cover)),
                  const SizedBox(height: 8),
                  Text('BNS YES-O CLUB', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                  Text('Youth for Environment\nand Science Organization',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            ...List.generate(titles.length, (i) {
              return ListTile(
                leading: Icon(icons[i], color: currentIndex == i ? AppTheme.primaryGreen : null),
                title: Text(titles[i]),
                selected: currentIndex == i,
                selectedTileColor: AppTheme.primaryGreen.withOpacity(0.08),
                onTap: () {
                  onPageChanged(i);
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  State<ResponsiveNavBar> createState() => _ResponsiveNavBarState();
}

class _ResponsiveNavBarState extends State<ResponsiveNavBar> {
  final List<String> _titles = ['Home', 'About Us', 'Events', 'Gallery', 'Education', 'Projects', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: widget.isScrolled
            ? (widget.isDark ? const Color(0xDD121212) : const Color(0xDD0D3B0D))
            : Colors.transparent,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 768
              ? _buildDesktopNav()
              : _buildMobileNav();
        },
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      child: Row(
        children: [
          InkWell(
            onTap: () => widget.onPageChanged(0),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(child: Image.asset('assets/images/logo.png', height: 40, width: 40, fit: BoxFit.cover)),
                const SizedBox(width: 10),
                Text('BNS YES-O CLUB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.3)),
              ],
            ),
          ),
          const Spacer(),
          ...List.generate(_titles.length, (i) {
            final isSelected = widget.currentIndex == i;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TextButton(
                onPressed: () => widget.onPageChanged(i),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: isSelected
                      ? AppTheme.primaryGreen.withValues(alpha: 0.1)
                      : null,
                  foregroundColor: isSelected
                      ? Colors.white
                      : Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _titles[i],
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 8),
          Container(
            height: 24,
            width: 1,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              size: 18,
            ),
            onPressed: widget.onToggleTheme,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            color: Colors.white70,
          ),
          const SizedBox(width: 12),
          Image.asset('assets/images/logo2.jpg', height: 36, fit: BoxFit.contain),
        ],
      ),
    );
  }

  Widget _buildMobileNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => widget.onPageChanged(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(child: Image.asset('assets/images/logo.png', height: 32, width: 32, fit: BoxFit.cover)),
                const SizedBox(width: 8),
                Text('BNS YES-O CLUB', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.2)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 24,
            width: 1,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
              size: 18,
            ),
            onPressed: widget.onToggleTheme,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            color: Colors.white70,
          ),
          const SizedBox(width: 8),
          Image.asset('assets/images/logo2.jpg', height: 28, fit: BoxFit.contain),
          const SizedBox(width: 8),
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu, size: 22),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0D3B0D),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 500;
          return Row(
            children: [
              ClipOval(child: Image.asset('assets/images/logo.png', height: 28, width: 28, fit: BoxFit.cover)),
              const SizedBox(width: 8),
              Text('BNS YES-O CLUB', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              Text('© 2026-2027', style: TextStyle(color: Colors.white60, fontSize: 11)),
              if (isWide) ...[
                const SizedBox(width: 16),
                Text('belisonnationalschoolyeso67@gmail.com', style: TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ],
          );
        },
      ),
    );
  }
}

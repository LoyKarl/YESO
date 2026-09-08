import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/scroll_reveal.dart';
import '../widgets/text_reveal.dart';
import '../widgets/floating_widget.dart';
import '../widgets/hover_card.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerSection(),
          _contactFormSection(),
          _contactInfoSection(),
        ],
      ),
    );
  }

  Widget _headerSection() {
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
            child: Icon(Icons.contact_mail, color: Colors.white24, size: 48),
          ),
          const SizedBox(height: 16),
          TextReveal(
            text: 'Contact Us',
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
              "We'd love to hear from you",
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

  Widget _contactFormSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              if (!_submitted) ...[
                TextReveal(
                  text: 'Send Us a Message',
                  style: Theme.of(context).textTheme.displayMedium,
                  itemDuration: const Duration(milliseconds: 70),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: constraints.maxWidth > 600
                      ? 500
                      : constraints.maxWidth - 48,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ScrollReveal(
                          delay: const Duration(milliseconds: 50),
                          child: TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Enter your name' : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ScrollReveal(
                          delay: const Duration(milliseconds: 100),
                          child: TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) =>
                                v == null || !v.contains('@')
                                    ? 'Enter a valid email'
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ScrollReveal(
                          delay: const Duration(milliseconds: 150),
                          child: TextFormField(
                            controller: _subjectCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Subject',
                              prefixIcon: Icon(Icons.subject),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Enter a subject' : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ScrollReveal(
                          delay: const Duration(milliseconds: 200),
                          child: TextFormField(
                            controller: _messageCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Message',
                              alignLabelWithHint: true,
                            ),
                            maxLines: 5,
                            validator: (v) =>
                                v == null || v.isEmpty
                                    ? 'Enter your message'
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ScrollReveal(
                          delay: const Duration(milliseconds: 250),
                          child: SizedBox(
                            width: double.infinity,
                            child: HoverCard(
                              borderRadius: BorderRadius.circular(30),
                              child: ElevatedButton(
                                onPressed: _isSubmitting ? null : _submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryGreen,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: _isSubmitting
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Send Message'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                ScrollReveal(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppTheme.primaryGreen,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Message Sent!',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Thank you for reaching out. We will get back to you soon.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _submitted = false;
                            _nameCtrl.clear();
                            _emailCtrl.clear();
                            _subjectCtrl.clear();
                            _messageCtrl.clear();
                          });
                        },
                        child: const Text('Send Another Message'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
            _submitted = true;
          });
        }
      });
    }
  }

  Widget _contactInfoSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final details = [
      {'icon': Icons.email, 'title': 'Email', 'value': 'belisonnationalschoolyeso67@gmail.com'},
      {'icon': Icons.phone, 'title': 'Phone', 'value': '09942662797'},
      {'icon': Icons.location_on, 'title': 'Address', 'value': 'Magsaysay St., Poblacion, Belison, Antique'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: isDark ? AppTheme.darkSurface : Colors.white,
      child: Column(
        children: [
          const ScrollReveal(
            child: FloatingWidget(
              child: Icon(Icons.contact_mail, color: AppTheme.primaryGreen, size: 48),
            ),
          ),
          const SizedBox(height: 12),
          TextReveal(
            text: 'Contact Us',
            style: Theme.of(context).textTheme.displayMedium,
            itemDuration: const Duration(milliseconds: 70),
          ),
          const SizedBox(height: 8),
          ScrollReveal(
            child: Text(
              'We\'d love to hear from you — reach out anytime!',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _mapPlaceholder()),
                    const SizedBox(width: 32),
                    Expanded(child: _contactDetails(details, isDark)),
                  ],
                );
              }
              return Column(
                children: [
                  _mapPlaceholder(),
                  const SizedBox(height: 24),
                  _contactDetails(details, isDark),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _mapPlaceholder() {
    return ScrollReveal(
      child: HoverCard(
        child: Card(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppTheme.primaryGreen,
                  AppTheme.primaryBlue,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'School Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Magsaysay St., Poblacion, Belison, Antique',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactDetails(List<Map> details, bool isDark) {
    return Column(
      children: [
        ...details.map(
          (d) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ScrollReveal(
              child: HoverCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        d['icon'] as IconData,
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d['title'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          d['value'] as String,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white70 : AppTheme.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingWidget(
              period: const Duration(seconds: 3),
              child: _socialCircle(Icons.facebook),
            ),
            const SizedBox(width: 12),
            FloatingWidget(
              period: const Duration(seconds: 4),
              delay: 0.3,
              child: _socialCircle(Icons.camera_alt),
            ),
            const SizedBox(width: 12),
            FloatingWidget(
              period: const Duration(seconds: 3),
              delay: 0.6,
              child: _socialCircle(Icons.videocam),
            ),
            const SizedBox(width: 12),
            FloatingWidget(
              period: const Duration(seconds: 5),
              delay: 0.2,
              child: _socialCircle(Icons.mail),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialCircle(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: AppTheme.primaryGreen, size: 22),
    );
  }
}

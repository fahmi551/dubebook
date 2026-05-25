import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../services/locale_service.dart';
import '../utils/theme.dart';
import '../utils/ethiopian_calendar.dart';
import '../main.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SplashSetupScreen extends StatefulWidget {
  const SplashSetupScreen({super.key});

  @override
  State<SplashSetupScreen> createState() => _SplashSetupScreenState();
}

class _SplashSetupScreenState extends State<SplashSetupScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  bool _showLanguageSelection = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _q1Controller = TextEditingController();
  final _q2Controller = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final isFirst = await AuthService.isFirstLaunch();
    if (isFirst) {
      // Check if language has been selected yet
      final hasLocale = await LocaleService.hasLocale();
      setState(() {
        _isLoading = false;
        _showLanguageSelection = !hasLocale;
      });
      _animationController.forward();
    } else {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  Future<void> _selectLanguage(String code) async {
    await LocaleService.setLocale(code);
    if (mounted) {
      DubeNoteApp.setLocale(context, Locale(code));
      setState(() {
        _showLanguageSelection = false;
      });
    }
  }

  int get _currentEthiopianYear => EthiopianCalendar.currentYear();

  Future<void> _submitSetup() async {
    if (_formKey.currentState!.validate()) {
      await AuthService.setupUser(
        _passwordController.text,
        _q1Controller.text,
        _q2Controller.text,
      );
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (_, __, ___) => const DashboardScreen(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue)),
        ),
      );
    }

    if (_showLanguageSelection) {
      return _buildLanguageSelection();
    }

    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildLogo(l),
                  const SizedBox(height: 40),
                  _buildInputSection(l),
                  const SizedBox(height: 48),
                  _buildInitializeButton(l),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_rounded, size: 14, color: AppTheme.textSecondary.withOpacity(0.5)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          l.dataSecureNote,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildLanguageSelection() {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppTheme.primaryBlue, width: 2),
                  ),
                  child: const Icon(Icons.translate_rounded, size: 64, color: AppTheme.primaryBlue),
                ),
                const SizedBox(height: 32),
                const Text(
                  'DUBE NOTE',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.textPrimary, letterSpacing: 6),
                ),
                const SizedBox(height: 16),
                Text(
                  'SELECT YOUR LANGUAGE',
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary, letterSpacing: 2, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'ቋንቋ ይምረጡ • AFAAN FILADHU',
                  style: TextStyle(fontSize: 11, color: AppTheme.textSecondary.withOpacity(0.6), fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 48),
                _buildLanguageCard('English', 'EN', Icons.language_rounded, 'en'),
                const SizedBox(height: 16),
                _buildLanguageCard('አማርኛ', 'AM', Icons.language_rounded, 'am'),
                const SizedBox(height: 16),
                _buildLanguageCard('Afan Oromo', 'OM', Icons.language_rounded, 'om'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard(String name, String code, IconData icon, String localeCode) {
    return GestureDetector(
      onTap: () => _selectLanguage(localeCode),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  code,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppTheme.primaryBlue, letterSpacing: 1),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.textPrimary),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.primaryBlue, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildInitializeButton(AppLocalizations l) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [AppTheme.primaryBlue, AppTheme.primaryBlue.withBlue(255)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: _submitSetup,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l.setUpMyShop, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(AppLocalizations l) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppTheme.primaryBlue, width: 2),
            ),
          child: const Icon(Icons.wallet_rounded, size: 80, color: AppTheme.primaryBlue),
        ),
        const SizedBox(height: 24),
        Text(
          l.appName,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.textPrimary, letterSpacing: 6),
        ),
        const SizedBox(height: 4),
        Text(
          l.appTagline,
          style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, letterSpacing: 1.2, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _buildInputSection(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 16, color: AppTheme.primaryBlue),
            const SizedBox(width: 8),
            Text(l.secureSetup, style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ],
        ),
        const SizedBox(height: 16),
        _buildField(
          _passwordController,
          'Create 4-Digit PIN',
          Icons.password_rounded,
          true,
          isNumber: true,
          validator: (v) {
            if (v == null || v.isEmpty) return l.passwordRequired;
            if (v.length != 4) return 'PIN must be exactly 4 digits';
            if (int.tryParse(v) == null) return 'PIN must be numeric';
            return null;
          },
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Container(width: 3, height: 16, color: AppTheme.primaryBlue),
            const SizedBox(width: 8),
            Text(l.recoveryQuestions, style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ],
        ),
        const SizedBox(height: 16),
        _buildField(
          _q1Controller,
          l.birthCity,
          Icons.location_on_rounded,
          false,
          validator: (v) => v!.isEmpty ? l.birthCityRequired : null,
        ),
        const SizedBox(height: 16),
        _buildField(
          _q2Controller,
          l.openingYear,
          Icons.event_available_rounded,
          false,
          isNumber: true,
          validator: (v) {
            if (v == null || v.isEmpty) return l.yearRequired;
            if (v.length != 4) return l.yearExactDigits;
            
            final year = int.tryParse(v);
            if (year == null) return l.invalidYearFormat;
            
            final currentYear = _currentEthiopianYear;
            if (year > currentYear) return l.yearFuture(currentYear);
            if (year < currentYear - 50) return l.yearTooOld(currentYear - 50);
            
            return null;
          },
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppTheme.primaryBlue,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.recoveryHelperText,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool obscure, {
    bool isNumber = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 20),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD0D5E0), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD0D5E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _passwordController.dispose();
    _q1Controller.dispose();
    _q2Controller.dispose();
    super.dispose();
  }
}

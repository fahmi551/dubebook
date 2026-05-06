import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/theme.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SplashSetupScreen extends StatefulWidget {
  const SplashSetupScreen({super.key});

  @override
  State<SplashSetupScreen> createState() => _SplashSetupScreenState();
}

class _SplashSetupScreenState extends State<SplashSetupScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
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
      setState(() {
        _isLoading = false;
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

  int get _currentEthiopianYear {
    final now = DateTime.now();
    // Ethiopian year is Gregorian - 8 if before Sept 11 (approx), else - 7.
    if (now.month < 9 || (now.month == 9 && now.day < 11)) {
      return now.year - 8;
    }
    return now.year - 7;
  }

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

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildInputSection(),
                  const SizedBox(height: 48),
                  _buildInitializeButton(),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_rounded, size: 14, color: AppTheme.textSecondary.withOpacity(0.5)),
                      const SizedBox(width: 6),
                      Text(
                        'Your data is stored securely on this device only.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.bold),
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

  Widget _buildInitializeButton() {
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
          children: const [
            Text('Set Up My Shop', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
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
        const Text(
          'DUBE BOOK',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.textPrimary, letterSpacing: 6),
        ),
        const SizedBox(height: 4),
        Text(
          'PROFESSIONAL SHOP ASSISTANT',
          style: TextStyle(fontSize: 13, color: AppTheme.textSecondary, letterSpacing: 1.2, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 16, color: AppTheme.primaryBlue),
            const SizedBox(width: 8),
            Text('SECURE SETUP', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ],
        ),
        const SizedBox(height: 16),
        _buildField(
          _passwordController,
          'Master Password',
          Icons.password_rounded,
          true,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Password is required';
            if (v.length < 4) return 'Must be at least 4 characters';
            return null;
          },
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Container(width: 3, height: 16, color: AppTheme.primaryBlue),
            const SizedBox(width: 8),
            Text('RECOVERY QUESTIONS', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ],
        ),
        const SizedBox(height: 16),
        _buildField(
          _q1Controller,
          'Birth City',
          Icons.location_on_rounded,
          false,
          validator: (v) => v!.isEmpty ? 'Birth city is required' : null,
        ),
        const SizedBox(height: 16),
        _buildField(
          _q2Controller,
          'Opening Year (Ethiopian)',
          Icons.event_available_rounded,
          false,
          isNumber: true,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Year is required';
            if (v.length != 4) return 'Must be exactly 4 digits';
            
            final year = int.tryParse(v);
            if (year == null) return 'Invalid year format';
            
            final currentYear = _currentEthiopianYear;
            if (year > currentYear) return 'Cannot be in the future ($currentYear E.C.)';
            if (year < currentYear - 50) return 'Too far in the past (Min: ${currentYear - 50})';
            
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 16, decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: AppTheme.textPrimary.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
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


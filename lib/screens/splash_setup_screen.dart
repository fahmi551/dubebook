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
                  const SizedBox(height: 56),
                  _buildInputSection(),
                  const SizedBox(height: 48),
                  _buildInitializeButton(),
                  const SizedBox(height: 24),
                  Text(
                    'Your data is stored securely on this device only.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.bold),
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
      height: 64,
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
            Text('INITIALIZE SYSTEM', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
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
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: const Icon(Icons.wallet_rounded, size: 64, color: AppTheme.primaryBlue),
        ),
        const SizedBox(height: 24),
        const Text(
          'DUBE BOOK',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.textPrimary, letterSpacing: 6),
        ),
        const SizedBox(height: 4),
        Text(
          'PROFESSIONAL SHOP ASSISTANT',
          style: TextStyle(fontSize: 10, color: AppTheme.textSecondary, letterSpacing: 2, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SECURE SETUP', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
        const SizedBox(height: 16),
        _buildField(_passwordController, 'Create Master Password', Icons.lock_rounded, true),
        const SizedBox(height: 32),
        Text('RECOVERY QUESTIONS', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2)),
        const SizedBox(height: 16),
        _buildField(_q1Controller, 'In which city were you born?', Icons.location_city_rounded, false),
        const SizedBox(height: 16),
        _buildField(_q2Controller, 'What year did your shop open?', Icons.calendar_today_rounded, false, isNumber: true),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, bool obscure, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 22),
      ),
      validator: (v) => v!.isEmpty ? 'This information is required' : null,
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

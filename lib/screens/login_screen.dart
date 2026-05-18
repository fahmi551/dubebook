import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../utils/theme.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  bool _error = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scaleAnimation = CurvedAnimation(
      parent: _animController, 
      curve: const Interval(0.0, 0.8, curve: Curves.elasticOut)
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController, 
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn)
    );
    _animController.forward();
  }

  Future<void> _login() async {
    final success = await AuthService.login(_passwordController.text);
    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const DashboardScreen(),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
        ),
      );
    } else {
      setState(() => _error = true);
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              AppTheme.primaryBlue.withOpacity(0.1),
              AppTheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryBlue.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: const Icon(Icons.lock_outline_rounded, size: 56, color: AppTheme.primaryBlue),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          l.appName, 
                          style: const TextStyle(
                            fontSize: 32, 
                            fontWeight: FontWeight.w900, 
                            letterSpacing: 8,
                            color: AppTheme.textPrimary,
                          )
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l.enterPasswordPrompt, 
                          style: TextStyle(
                            color: AppTheme.textSecondary, 
                            fontSize: 10, 
                            fontWeight: FontWeight.w900, 
                            letterSpacing: 2
                          )
                        ),
                        const SizedBox(height: 56),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24, letterSpacing: 12, color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: l.passwordHint,
                            hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.2)),
                            errorText: _error ? l.accessDenied : null,
                            contentPadding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          onSubmitted: (_) => _login(),
                        ),
                        const SizedBox(height: 40),
                        _buildUnlockButton(),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () => showDialog(context: context, builder: (_) => const ForgotPasswordDialog()),
                          child: Text(
                            l.forgotPassword, 
                            style: TextStyle(
                              color: AppTheme.textSecondary.withOpacity(0.5), 
                              fontSize: 11, 
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2
                            )
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
      ),
    );
  }

  Widget _buildUnlockButton() {
    final l = AppLocalizations.of(context)!;
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
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(
          l.enter, 
          style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _q1 = TextEditingController();
  final _q2 = TextEditingController();
  final _pass = TextEditingController();
  bool _err = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: Colors.white.withOpacity(0.1))),
      title: Text(l.recovery, style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_err) 
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(l.securityAnswersIncorrect, style: const TextStyle(color: AppTheme.error, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            _field(_q1, l.placeOfBirth, Icons.location_on_rounded),
            const SizedBox(height: 16),
            _field(_q2, l.yearShopOpened, Icons.calendar_today_rounded),
            const SizedBox(height: 16),
            _field(_pass, l.createNewPassword, Icons.vpn_key_rounded, obscure: true),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))
        ),
        ElevatedButton(
          onPressed: () async {
            final ok = await AuthService.resetPassword(_q1.text, _q2.text, _pass.text);
            if (ok && mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l.passwordResetSuccess), 
                  backgroundColor: AppTheme.primaryBlue,
                  behavior: SnackBarBehavior.floating,
                )
              );
            } else {
              setState(() => _err = true);
            }
          },
          child: Text(l.reset),
        ),
      ],
    );
  }

  Widget _field(TextEditingController c, String l, IconData i, {bool obscure = false}) {
    return TextField(
      controller: c,
      obscureText: obscure,
      style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: l,
        prefixIcon: Icon(i, size: 20, color: AppTheme.primaryBlue),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/backup_service.dart';
import '../utils/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('SETTINGS'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('DATABASE MANAGEMENT'),
          _buildSettingsTile(
            icon: Icons.cloud_upload_rounded,
            title: 'Export Local Backup',
            subtitle: 'Securely export your credit database file.',
            onTap: () async {
              try {
                await BackupService.exportDatabase();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Database exported successfully', style: TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: AppTheme.accentGreen,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Export failed: $e'),
                      backgroundColor: AppTheme.error,
                    ),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('APPLICATION INFO'),
          _buildSettingsTile(
            icon: Icons.auto_awesome_rounded,
            title: 'Dube book',
            subtitle: 'Version 0.0.1 (Beta Release)',
          ),
          _buildSettingsTile(
            icon: Icons.fingerprint_rounded,
            title: 'Security Engine',
            subtitle: 'Local-only data architecture',
          ),
          const SizedBox(height: 64),
          Center(
            child: Opacity(
              opacity: 0.2,
              child: Column(
                children: [
                  const Icon(Icons.wallet_rounded, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  const Text(
                    'DUBE BOOK',
                    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '© 2024 WECAN TEAM',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.primaryBlue, 
          fontWeight: FontWeight.w900, 
          fontSize: 12, 
          letterSpacing: 2
        ),
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, String? subtitle, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primaryBlue, size: 24),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)) : null,
        trailing: onTap != null ? const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16) : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../database/database_helper.dart';
import '../models/customer.dart';
import '../utils/theme.dart';
import 'customer_detail_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import '../services/notification_service.dart';
import '../utils/ethiopian_calendar.dart';
import '../utils/ethiopian_date_picker.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> _unpaidCustomers = [];
  bool _isLoading = true;
  double _totalUnpaid = 0.0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper.instance.getUnpaidCustomersWithDebt();
    double total = 0;
    for (var item in data) {
      total += (item['total_debt'] as num).toDouble();
    }
    setState(() {
      _unpaidCustomers = data;
      _totalUnpaid = total;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: AppTheme.accentGreen),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppTheme.textSecondary),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              // Reload in case language changed
              if (mounted) setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeroCard(),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
            child: Row(
              children: [
                Text(
                  l.pendingDebts,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  l.customersCount(_unpaidCustomers.length),
                  style: TextStyle(fontSize: 10, color: AppTheme.textSecondary.withOpacity(0.5), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
              ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppTheme.primaryBlue)))
              : _unpaidCustomers.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: _unpaidCustomers.length,
                    itemBuilder: (context, index) {
                      final item = _unpaidCustomers[index];
                      final customer = Customer.fromMap(item);
                      final debt = (item['total_debt'] as num).toDouble();
                      final isOverdue = customer.deadline != null && customer.deadline!.isBefore(DateTime.now());

                      return _AnimatedCustomerTile(
                        index: index,
                        customer: customer,
                        debt: debt,
                        isOverdue: isOverdue,
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerDetailScreen(customer: customer)));
                          _loadData();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCustomerDialog,
        backgroundColor: AppTheme.primaryBlue,
        label: Text(l.newCustomer, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildHeroCard() {
    final l = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryBlue,
            AppTheme.primaryBlue.withBlue(200),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.totalOutstanding,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _totalUnpaid.toStringAsFixed(2),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.7)),
                  l.birr
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up_rounded, size: 16, color: AppTheme.accentGreen),
                const SizedBox(width: 8),
                Text(
                  l.activeCredit,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shield_moon_rounded, size: 100, color: AppTheme.textSecondary.withOpacity(0.1)),
          const SizedBox(height: 24),
          Text(
            l.noCustomersFound,
            style: TextStyle(
              color: AppTheme.textSecondary.withOpacity(0.3),
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCustomerDialog() {
    final l = AppLocalizations.of(context)!;
    final name = TextEditingController();
    DateTime? deadline;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          backgroundColor: AppTheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28), side: BorderSide(color: Colors.white.withOpacity(0.1))),
          title: Text(l.registerCustomer, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.2)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                style: const TextStyle(color: AppTheme.textPrimary),
                decoration: InputDecoration(labelText: l.fullName, prefixIcon: const Icon(Icons.person_outline, size: 20)),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final d = await showEthiopianDatePicker(
                    context: ctx,
                    initialDate: DateTime.now(),
                  );
                  if (d != null) setState(() => deadline = d);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.textSecondary.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 18, color: deadline != null ? AppTheme.primaryBlue : AppTheme.textSecondary.withOpacity(0.3)),
                      const SizedBox(width: 12),
                      Text(
                        deadline == null ? l.setPaymentDeadline : EthiopianCalendar.fromGregorian(deadline!).format(locale: Localizations.localeOf(ctx).languageCode),
                        style: TextStyle(color: deadline == null ? AppTheme.textSecondary.withOpacity(0.5) : AppTheme.textPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))),
            ElevatedButton(
              onPressed: () async {
                if (name.text.isEmpty) return;
                final c = Customer(name: name.text, deadline: deadline, createdAt: DateTime.now());
                final id = await DatabaseHelper.instance.insertCustomer(c);
                if (deadline != null) {
                  try {
                    await NotificationService().scheduleDeadlineNotification(id, c.name, deadline!);
                  } catch (e) {
                    debugPrint('Notification scheduling failed: $e');
                  }
                }
                if (context.mounted) { Navigator.pop(ctx); _loadData(); }
              },
              child: Text(l.register),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedCustomerTile extends StatelessWidget {
  final int index;
  final Customer customer;
  final double debt;
  final bool isOverdue;
  final VoidCallback onTap;

  const _AnimatedCustomerTile({required this.index, required this.customer, required this.debt, required this.isOverdue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 80)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isOverdue ? AppTheme.error.withOpacity(0.4) : AppTheme.textSecondary.withOpacity(0.1),
              width: isOverdue ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isOverdue
                      ? [AppTheme.error.withOpacity(0.2), AppTheme.error.withOpacity(0.05)]
                      : [AppTheme.primaryBlue.withOpacity(0.1), AppTheme.primaryBlue.withOpacity(0.02)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    customer.name[0].toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: isOverdue ? AppTheme.error : AppTheme.primaryBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: AppTheme.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isOverdue ? Icons.warning_amber_rounded : Icons.access_time_rounded,
                          size: 14,
                          color: isOverdue ? AppTheme.error : AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          customer.deadline != null
                            ? l.dueDate(EthiopianCalendar.fromGregorian(customer.deadline!).format(locale: Localizations.localeOf(context).languageCode))
                            : l.noDeadlineSet,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isOverdue ? AppTheme.error : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l.amountBirr(debt.toStringAsFixed(2)),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 19, color: AppTheme.accentGreen),
                  ),
                  if (isOverdue)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        l.overdue,
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: AppTheme.error, letterSpacing: 1),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

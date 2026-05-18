import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/customer.dart';
import '../models/app_transaction.dart';
import '../database/database_helper.dart';
import '../utils/theme.dart';
import 'add_transaction_screen.dart';
import '../services/notification_service.dart';
import '../utils/ethiopian_calendar.dart';

class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> with SingleTickerProviderStateMixin {
  List<AppTransaction> _transactions = [];
  bool _isLoading = true;
  double _totalDebt = 0.0;
  late AnimationController _headerController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);
    final txs = await DatabaseHelper.instance.getTransactionsForCustomer(widget.customer.id!, status: 0); 
    double total = 0;
    for (var tx in txs) {
      total += tx.total;
    }
    setState(() {
      _transactions = txs;
      _totalDebt = total;
      _isLoading = false;
    });
    _headerController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(widget.customer.name.toUpperCase()),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: AppTheme.error),
            onPressed: _deleteCustomer,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAnimatedHeader(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.receipt_long_rounded, color: AppTheme.primaryBlue, size: 16),
                const SizedBox(width: 8),
                Text(
                  l.creditHistory,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: AppTheme.textSecondary),
                ),
                const Spacer(),
                Text(
                  l.itemsCount(_transactions.length),
                  style: TextStyle(fontSize: 10, color: AppTheme.textSecondary.withOpacity(0.5), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue))
              : _buildTransactionList(),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    final l = AppLocalizations.of(context)!;
    return FadeTransition(
      opacity: _headerController,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          children: [
            Text(
              l.outstandingBalance,
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2),
            ),
            const SizedBox(height: 12),
            Text(
              '${l.birr}${_totalDebt.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppTheme.primaryBlue),
            ),
            if (widget.customer.deadline != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.error.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.event_busy_rounded, size: 16, color: AppTheme.error),
                    const SizedBox(width: 8),
                    Text(
                      'DUE: ${EthiopianCalendar.fromGregorian(widget.customer.deadline!).format(locale: Localizations.localeOf(context).languageCode)}',
                      style: const TextStyle(color: AppTheme.error, fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    final l = AppLocalizations.of(context)!;
    if (_transactions.isEmpty) {
      return Center(
        child: Text(l.noUnpaidItems, style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.2), fontWeight: FontWeight.bold, letterSpacing: 2)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final tx = _transactions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.textSecondary.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tx.itemName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppTheme.textPrimary)),
                    const SizedBox(height: 4),
                    Text(
                      l.quantityTimesPrice(tx.quantity, tx.price.toStringAsFixed(2)),
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Text(
                l.birrAmount(tx.total.toStringAsFixed(2)),
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: AppTheme.accentGreen),
              ),
              const SizedBox(width: 4),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded, color: AppTheme.textSecondary, size: 20),
                color: AppTheme.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _editTransaction(tx);
                      break;
                    case 'delete':
                      _deleteTransaction(tx);
                      break;
                    case 'pay':
                      _markTransactionAsPaid(tx);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Icons.edit_rounded, size: 18, color: AppTheme.primaryBlue),
                        const SizedBox(width: 10),
                        Text(l.edit, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'pay',
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 18, color: AppTheme.accentGreen),
                        const SizedBox(width: 10),
                        Text(l.payItem, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_rounded, size: 18, color: AppTheme.error),
                        const SizedBox(width: 10),
                        Text(l.deleteTx, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.error)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (_) => AddTransactionScreen(customerId: widget.customer.id!)));
                _loadTransactions();
              },
              icon: const Icon(Icons.add_shopping_cart_rounded, size: 20),
              label: Text(l.addCredit),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryBlue, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 18),
                foregroundColor: AppTheme.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _totalDebt > 0 ? _markAllAsPaid : null,
              icon: const Icon(Icons.check_circle_rounded, size: 20),
              label: Text(l.settleAll),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Edit Transaction ---
  Future<void> _editTransaction(AppTransaction tx) async {
    await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (_) => AddTransactionScreen(
          customerId: widget.customer.id!,
          existingTransaction: tx,
        ),
      ),
    );
    _loadTransactions();
  }

  // --- Delete Individual Transaction ---
  Future<void> _deleteTransaction(AppTransaction tx) async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l.deleteTransaction, style: const TextStyle(color: AppTheme.error, fontWeight: FontWeight.w900)), 
        content: Text(l.deleteTransactionConfirm), 
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error), 
            onPressed: () => Navigator.pop(ctx, true), 
            child: Text(l.delete)
          )
        ]
      )
    );
    if (ok == true) {
      await DatabaseHelper.instance.deleteTransaction(tx.id!);
      _loadTransactions();
    }
  }

  // --- Mark Individual Transaction as Paid ---
  Future<void> _markTransactionAsPaid(AppTransaction tx) async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l.markAsPaid, style: const TextStyle(fontWeight: FontWeight.w900)), 
        content: Text(l.markAsPaidConfirm), 
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))), 
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.confirm))
        ]
      )
    );
    if (ok == true) {
      await DatabaseHelper.instance.markTransactionAsPaid(tx.id!);
      _loadTransactions();
    }
  }

  // --- Mark All as Paid (existing feature preserved) ---
  Future<void> _markAllAsPaid() async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l.settleDebt, style: const TextStyle(fontWeight: FontWeight.w900)), 
        content: Text(l.markAllAsPaidConfirm), 
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))), 
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.confirm))
        ]
      )
    );
    if (ok == true) {
      await DatabaseHelper.instance.markAllCustomerTransactionsAsPaid(widget.customer.id!);
      await NotificationService().cancelNotification(widget.customer.id!);
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _deleteCustomer() async {
    final l = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l.deleteCustomer, style: const TextStyle(color: AppTheme.error, fontWeight: FontWeight.w900)), 
        content: Text(l.deleteCustomerConfirm), 
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error), 
            onPressed: () => Navigator.pop(ctx, true), 
            child: Text(l.delete)
          )
        ]
      )
    );
    if (ok == true) {
      await DatabaseHelper.instance.deleteCustomer(widget.customer.id!);
      await NotificationService().cancelNotification(widget.customer.id!);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../models/app_transaction.dart';
import '../database/database_helper.dart';
import '../utils/theme.dart';
import 'add_transaction_screen.dart';
import '../services/notification_service.dart';

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
                const Text(
                  'CREDIT HISTORY',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: AppTheme.textSecondary),
                ),
                const Spacer(),
                Text(
                  '${_transactions.length} ITEMS',
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
    return FadeTransition(
      opacity: _headerController,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppTheme.textSecondary.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'OUTSTANDING BALANCE',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2),
            ),
            const SizedBox(height: 12),
            Text(
              'Birr${_totalDebt.toStringAsFixed(2)}',
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
                      'DUE: ${DateFormat.yMMMMd().format(widget.customer.deadline!)}',
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
    if (_transactions.isEmpty) {
      return Center(
        child: Text('NO UNPAID ITEMS', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.2), fontWeight: FontWeight.bold, letterSpacing: 2)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final tx = _transactions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(20),
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
                      '${tx.quantity} x Birr ${tx.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Text(
                'Birr ${tx.total.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: AppTheme.accentGreen),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
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
              label: const Text('ADD CREDIT'),
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
              onPressed: _totalDebt > 0 ? _markAsPaid : null,
              icon: const Icon(Icons.check_circle_rounded, size: 20),
              label: const Text('SETTLE ALL'),
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

  Future<void> _markAsPaid() async {
    final ok = await showDialog<bool>(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('SETTLE DEBT', style: TextStyle(fontWeight: FontWeight.w900)), 
        content: const Text('Mark all items as paid and move to history?'), 
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCEL', style: TextStyle(color: AppTheme.textSecondary))), 
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('CONFIRM'))
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
    final ok = await showDialog<bool>(
      context: context, 
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('DELETE CUSTOMER', style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.w900)), 
        content: const Text('Permanently delete this customer and all their transaction records? This cannot be undone.'), 
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCEL', style: TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error), 
            onPressed: () => Navigator.pop(ctx, true), 
            child: const Text('DELETE')
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

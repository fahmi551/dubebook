import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/app_transaction.dart';
import '../database/database_helper.dart';
import '../utils/theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<AppTransaction> _paidTransactions = [];
  Map<int, String> _customerNames = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);
    final txs = await DatabaseHelper.instance.getAllTransactions(status: 1); // 1 = PAID
    final customers = await DatabaseHelper.instance.getCustomers();
    
    Map<int, String> names = {};
    for (var c in customers) {
      names[c.id!] = c.name;
    }

    setState(() {
      _paidTransactions = txs;
      _customerNames = names;
      _isLoading = false;
    });
  }

  Future<void> _deleteTx(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('DELETE RECORD?', style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text('This will permanently remove this transaction from the history.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCEL', style: TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            onPressed: () => Navigator.pop(ctx, true), 
            child: const Text('DELETE')
          ),
        ],
      )
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteTransaction(id);
      _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('PAID RECORDS'),
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue))
        : _paidTransactions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _paidTransactions.length,
              itemBuilder: (context, index) {
                final tx = _paidTransactions[index];
                final cName = _customerNames[tx.customerId] ?? 'Deleted Customer';
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                            Text(
                              cName.toUpperCase(),
                              style: const TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              tx.itemName,
                              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Paid on: ${DateFormat.yMMMd().add_jm().format(tx.date)}',
                              style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Birr ${tx.total.toStringAsFixed(2)}',
                            style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.error, size: 22),
                            onPressed: () => _deleteTx(tx.id!),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off_rounded, size: 80, color: AppTheme.textSecondary.withOpacity(0.1)),
          const SizedBox(height: 16),
          Text(
            'NO TRANSACTION HISTORY',
            style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.2), fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}

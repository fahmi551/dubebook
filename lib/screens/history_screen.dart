import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/app_transaction.dart';
import '../database/database_helper.dart';
import '../utils/theme.dart';
import '../utils/ethiopian_calendar.dart';

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
    final l = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(l.deleteRecord, style: const TextStyle(fontWeight: FontWeight.w900)),
        content: Text(l.deleteRecordConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel, style: const TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            onPressed: () => Navigator.pop(ctx, true), 
            child: Text(l.delete)
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
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(l.paidRecords),
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue))
        : _paidTransactions.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemCount: _paidTransactions.length,
              itemBuilder: (context, index) {
                final tx = _paidTransactions[index];
                final cName = _customerNames[tx.customerId] ?? l.deletedCustomer;
                
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
                              l.paidOn(EthiopianCalendar.fromGregorian(tx.date).format(locale: Localizations.localeOf(context).languageCode)),
                              style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            l.birrAmount(tx.total.toStringAsFixed(2)),
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
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off_rounded, size: 80, color: AppTheme.textSecondary.withOpacity(0.1)),
          const SizedBox(height: 16),
          Text(
            l.noTransactionHistory,
            style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.2), fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}

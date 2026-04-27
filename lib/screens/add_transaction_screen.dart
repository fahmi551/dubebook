import 'package:flutter/material.dart';
import '../models/app_transaction.dart';
import '../database/database_helper.dart';
import '../utils/theme.dart';

class AddTransactionScreen extends StatefulWidget {
  final int customerId;

  const AddTransactionScreen({super.key, required this.customerId});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();
  final _qtyController = TextEditingController(text: '1');
  final _priceController = TextEditingController();

  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _qtyController.addListener(_calculateTotal);
    _priceController.addListener(_calculateTotal);
  }

  void _calculateTotal() {
    final qty = int.tryParse(_qtyController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    setState(() {
      _total = qty * price;
    });
  }

  Future<void> _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      final tx = AppTransaction(
        customerId: widget.customerId,
        itemName: _itemController.text.trim(),
        quantity: int.parse(_qtyController.text),
        price: double.parse(_priceController.text),
        total: _total,
        date: DateTime.now(),
      );

      await DatabaseHelper.instance.insertTransaction(tx);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('NEW CREDIT')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildField(
                _itemController, 
                'What was taken?', 
                Icons.shopping_bag_rounded, 
                true
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 1, 
                    child: _buildField(
                      _qtyController, 
                      'Qty', 
                      Icons.numbers_rounded, 
                      false, 
                      isNumber: true
                    )
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2, 
                    child: _buildField(
                      _priceController, 
                      'Unit Price', 
                      Icons.payments_rounded, 
                      false, 
                      isNumber: true
                    )
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2), width: 1.5),
                  boxShadow: [
                    BoxShadow(color: AppTheme.primaryBlue.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL TRANSACTION AMOUNT', 
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2, color: AppTheme.textSecondary)
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text('Birr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.accentGreen)),
                        const SizedBox(width: 6),
                        Text(
                          _total.toStringAsFixed(2), 
                          style: const TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: AppTheme.accentGreen)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save_rounded, size: 22),
                      SizedBox(width: 12),
                      Text('SAVE TO RECORD'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController c, String l, IconData i, bool auto, {bool isNumber = false}) {
    return TextFormField(
      controller: c,
      autofocus: auto,
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: l,
        prefixIcon: Icon(i, color: AppTheme.primaryBlue, size: 22),
      ),
      validator: (v) => v!.isEmpty ? 'This field is required' : null,
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}

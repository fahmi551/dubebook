// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DUBE NOTE';

  @override
  String get appTagline => 'PROFESSIONAL SHOP ASSISTANT';

  @override
  String get version => 'Version 0.0.1 (Beta Release)';

  @override
  String get copyright => '© 2024 WECAN TEAM';

  @override
  String get selectLanguage => 'SELECT YOUR LANGUAGE';

  @override
  String get continueBtn => 'CONTINUE';

  @override
  String get enterPasswordPrompt => 'ENTER PASSWORD TO ENTER';

  @override
  String get passwordHint => '••••••';

  @override
  String get accessDenied => 'Access Denied';

  @override
  String get enter => 'ENTER';

  @override
  String get forgotPassword => 'FORGOT PASSWORD?';

  @override
  String get recovery => 'RECOVERY';

  @override
  String get placeOfBirth => 'Place of Birth';

  @override
  String get yearShopOpened => 'Year Shop Opened';

  @override
  String get createNewPassword => 'Create New Password';

  @override
  String get cancel => 'CANCEL';

  @override
  String get reset => 'RESET';

  @override
  String get securityAnswersIncorrect => 'SECURITY ANSWERS INCORRECT';

  @override
  String get passwordResetSuccess => 'Password reset successfully';

  @override
  String get secureSetup => 'SECURE SETUP';

  @override
  String get masterPassword => 'Master Password';

  @override
  String get recoveryQuestions => 'RECOVERY QUESTIONS';

  @override
  String get recoveryHelperText =>
      'Make sure to use an answer you will remember. This will be required when recovering your password.';

  @override
  String get birthCity => 'Birth City';

  @override
  String get openingYear => 'Opening Year (Ethiopian)';

  @override
  String get setUpMyShop => 'Set Up My Shop';

  @override
  String get dataSecureNote =>
      'Your data is stored securely on this device only.';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Must be at least 4 characters';

  @override
  String get birthCityRequired => 'Birth city is required';

  @override
  String get yearRequired => 'Year is required';

  @override
  String get yearExactDigits => 'Must be exactly 4 digits';

  @override
  String get invalidYearFormat => 'Invalid year format';

  @override
  String yearFuture(int year) {
    return 'Cannot be in the future ($year E.C.)';
  }

  @override
  String yearTooOld(int year) {
    return 'Too far in the past (Min: $year)';
  }

  @override
  String get totalOutstanding => 'TOTAL OUTSTANDING';

  @override
  String get birr => 'Birr';

  @override
  String get activeCredit => 'Active Credit';

  @override
  String get pendingDebts => 'PENDING DEBTS';

  @override
  String customersCount(int count) {
    return '$count CUSTOMERS';
  }

  @override
  String get noCustomersFound => 'NO CUSTOMERS FOUND';

  @override
  String get newCustomer => 'NEW CUSTOMER';

  @override
  String get registerCustomer => 'REGISTER CUSTOMER';

  @override
  String get fullName => 'Full Name';

  @override
  String get setPaymentDeadline => 'Set Payment Deadline';

  @override
  String get register => 'REGISTER';

  @override
  String get noDeadlineSet => 'No deadline set';

  @override
  String dueDate(String date) {
    return 'Due $date';
  }

  @override
  String get overdue => 'OVERDUE';

  @override
  String get outstandingBalance => 'OUTSTANDING BALANCE';

  @override
  String get creditHistory => 'CREDIT HISTORY';

  @override
  String itemsCount(int count) {
    return '$count ITEMS';
  }

  @override
  String get noUnpaidItems => 'NO UNPAID ITEMS';

  @override
  String get addCredit => 'ADD CREDIT';

  @override
  String get settleAll => 'SETTLE ALL';

  @override
  String get settleDebt => 'SETTLE DEBT';

  @override
  String get markAllAsPaidConfirm =>
      'Mark all items as paid and move to history?';

  @override
  String get confirm => 'CONFIRM';

  @override
  String get deleteCustomer => 'DELETE CUSTOMER';

  @override
  String get deleteCustomerConfirm =>
      'Permanently delete this customer and all their transaction records? This cannot be undone.';

  @override
  String get delete => 'DELETE';

  @override
  String get editTransaction => 'EDIT TRANSACTION';

  @override
  String get deleteTransaction => 'DELETE TRANSACTION';

  @override
  String get deleteTransactionConfirm =>
      'Permanently delete this transaction? The customer balance will be updated.';

  @override
  String get markAsPaid => 'MARK AS PAID';

  @override
  String get markAsPaidConfirm =>
      'Mark this transaction as paid and move to history?';

  @override
  String get edit => 'Edit';

  @override
  String get deleteTx => 'Delete';

  @override
  String get payItem => 'Pay This';

  @override
  String get newCredit => 'NEW CREDIT';

  @override
  String get editCredit => 'EDIT CREDIT';

  @override
  String get whatWasTaken => 'What was taken?';

  @override
  String get qty => 'Qty';

  @override
  String get unitPrice => 'Unit Price';

  @override
  String get totalTransactionAmount => 'TOTAL TRANSACTION AMOUNT';

  @override
  String get saveToRecord => 'SAVE TO RECORD';

  @override
  String get updateRecord => 'UPDATE RECORD';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get negativeNotAllowed => 'Negative value is not allowed';

  @override
  String get paidRecords => 'PAID RECORDS';

  @override
  String get deletedCustomer => 'Deleted Customer';

  @override
  String paidOn(String date) {
    return 'Paid on: $date';
  }

  @override
  String get deleteRecord => 'DELETE RECORD?';

  @override
  String get deleteRecordConfirm =>
      'This will permanently remove this transaction from the history.';

  @override
  String get noTransactionHistory => 'NO TRANSACTION HISTORY';

  @override
  String get settings => 'SETTINGS';

  @override
  String get databaseManagement => 'DATABASE MANAGEMENT';

  @override
  String get exportLocalBackup => 'Export Local Backup';

  @override
  String get exportDescription => 'Securely export your credit database file.';

  @override
  String get databaseExportSuccess => 'Database exported successfully';

  @override
  String exportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get applicationInfo => 'APPLICATION INFO';

  @override
  String get securityEngine => 'Security Engine';

  @override
  String get localOnlyArchitecture => 'Local-only data architecture';

  @override
  String get language => 'Language';

  @override
  String get languageDescription => 'Change application language';

  @override
  String get changeLanguage => 'CHANGE LANGUAGE';

  @override
  String quantityTimesPrice(int qty, String price) {
    return '$qty x Birr $price';
  }

  @override
  String birrAmount(String amount) {
    return 'Birr $amount';
  }

  @override
  String amountBirr(String amount) {
    return '$amount Birr';
  }
}

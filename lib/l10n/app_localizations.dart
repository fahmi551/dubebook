import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_om.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('om'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'DUBE NOTE'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'PROFESSIONAL SHOP ASSISTANT'**
  String get appTagline;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 0.0.1 (Beta Release)'**
  String get version;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 WECAN TEAM'**
  String get copyright;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'SELECT YOUR LANGUAGE'**
  String get selectLanguage;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueBtn;

  /// No description provided for @enterPasswordPrompt.
  ///
  /// In en, this message translates to:
  /// **'ENTER PASSWORD TO ENTER'**
  String get enterPasswordPrompt;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'••••••'**
  String get passwordHint;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get accessDenied;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'ENTER'**
  String get enter;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'FORGOT PASSWORD?'**
  String get forgotPassword;

  /// No description provided for @recovery.
  ///
  /// In en, this message translates to:
  /// **'RECOVERY'**
  String get recovery;

  /// No description provided for @placeOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Place of Birth'**
  String get placeOfBirth;

  /// No description provided for @yearShopOpened.
  ///
  /// In en, this message translates to:
  /// **'Year Shop Opened'**
  String get yearShopOpened;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'RESET'**
  String get reset;

  /// No description provided for @securityAnswersIncorrect.
  ///
  /// In en, this message translates to:
  /// **'SECURITY ANSWERS INCORRECT'**
  String get securityAnswersIncorrect;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully'**
  String get passwordResetSuccess;

  /// No description provided for @secureSetup.
  ///
  /// In en, this message translates to:
  /// **'SECURE SETUP'**
  String get secureSetup;

  /// No description provided for @masterPassword.
  ///
  /// In en, this message translates to:
  /// **'Master Password'**
  String get masterPassword;

  /// No description provided for @recoveryQuestions.
  ///
  /// In en, this message translates to:
  /// **'RECOVERY QUESTIONS'**
  String get recoveryQuestions;

  /// No description provided for @recoveryHelperText.
  ///
  /// In en, this message translates to:
  /// **'Make sure to use an answer you will remember. This will be required when recovering your password.'**
  String get recoveryHelperText;

  /// No description provided for @birthCity.
  ///
  /// In en, this message translates to:
  /// **'Birth City'**
  String get birthCity;

  /// No description provided for @openingYear.
  ///
  /// In en, this message translates to:
  /// **'Opening Year (Ethiopian)'**
  String get openingYear;

  /// No description provided for @setUpMyShop.
  ///
  /// In en, this message translates to:
  /// **'Set Up My Shop'**
  String get setUpMyShop;

  /// No description provided for @dataSecureNote.
  ///
  /// In en, this message translates to:
  /// **'Your data is stored securely on this device only.'**
  String get dataSecureNote;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 4 characters'**
  String get passwordMinLength;

  /// No description provided for @birthCityRequired.
  ///
  /// In en, this message translates to:
  /// **'Birth city is required'**
  String get birthCityRequired;

  /// No description provided for @yearRequired.
  ///
  /// In en, this message translates to:
  /// **'Year is required'**
  String get yearRequired;

  /// No description provided for @yearExactDigits.
  ///
  /// In en, this message translates to:
  /// **'Must be exactly 4 digits'**
  String get yearExactDigits;

  /// No description provided for @invalidYearFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid year format'**
  String get invalidYearFormat;

  /// No description provided for @yearFuture.
  ///
  /// In en, this message translates to:
  /// **'Cannot be in the future ({year} E.C.)'**
  String yearFuture(int year);

  /// No description provided for @yearTooOld.
  ///
  /// In en, this message translates to:
  /// **'Too far in the past (Min: {year})'**
  String yearTooOld(int year);

  /// No description provided for @totalOutstanding.
  ///
  /// In en, this message translates to:
  /// **'TOTAL OUTSTANDING'**
  String get totalOutstanding;

  /// No description provided for @birr.
  ///
  /// In en, this message translates to:
  /// **'Birr'**
  String get birr;

  /// No description provided for @activeCredit.
  ///
  /// In en, this message translates to:
  /// **'Active Credit'**
  String get activeCredit;

  /// No description provided for @pendingDebts.
  ///
  /// In en, this message translates to:
  /// **'PENDING DEBTS'**
  String get pendingDebts;

  /// No description provided for @customersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} CUSTOMERS'**
  String customersCount(int count);

  /// No description provided for @noCustomersFound.
  ///
  /// In en, this message translates to:
  /// **'NO CUSTOMERS FOUND'**
  String get noCustomersFound;

  /// No description provided for @newCustomer.
  ///
  /// In en, this message translates to:
  /// **'NEW CUSTOMER'**
  String get newCustomer;

  /// No description provided for @registerCustomer.
  ///
  /// In en, this message translates to:
  /// **'REGISTER CUSTOMER'**
  String get registerCustomer;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @setPaymentDeadline.
  ///
  /// In en, this message translates to:
  /// **'Set Payment Deadline'**
  String get setPaymentDeadline;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get register;

  /// No description provided for @noDeadlineSet.
  ///
  /// In en, this message translates to:
  /// **'No deadline set'**
  String get noDeadlineSet;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String dueDate(String date);

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'OVERDUE'**
  String get overdue;

  /// No description provided for @outstandingBalance.
  ///
  /// In en, this message translates to:
  /// **'OUTSTANDING BALANCE'**
  String get outstandingBalance;

  /// No description provided for @creditHistory.
  ///
  /// In en, this message translates to:
  /// **'CREDIT HISTORY'**
  String get creditHistory;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} ITEMS'**
  String itemsCount(int count);

  /// No description provided for @noUnpaidItems.
  ///
  /// In en, this message translates to:
  /// **'NO UNPAID ITEMS'**
  String get noUnpaidItems;

  /// No description provided for @addCredit.
  ///
  /// In en, this message translates to:
  /// **'ADD CREDIT'**
  String get addCredit;

  /// No description provided for @settleAll.
  ///
  /// In en, this message translates to:
  /// **'SETTLE ALL'**
  String get settleAll;

  /// No description provided for @settleDebt.
  ///
  /// In en, this message translates to:
  /// **'SETTLE DEBT'**
  String get settleDebt;

  /// No description provided for @markAllAsPaidConfirm.
  ///
  /// In en, this message translates to:
  /// **'Mark all items as paid and move to history?'**
  String get markAllAsPaidConfirm;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM'**
  String get confirm;

  /// No description provided for @deleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'DELETE CUSTOMER'**
  String get deleteCustomer;

  /// No description provided for @deleteCustomerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete this customer and all their transaction records? This cannot be undone.'**
  String get deleteCustomerConfirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get delete;

  /// No description provided for @editTransaction.
  ///
  /// In en, this message translates to:
  /// **'EDIT TRANSACTION'**
  String get editTransaction;

  /// No description provided for @deleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'DELETE TRANSACTION'**
  String get deleteTransaction;

  /// No description provided for @deleteTransactionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete this transaction? The customer balance will be updated.'**
  String get deleteTransactionConfirm;

  /// No description provided for @markAsPaid.
  ///
  /// In en, this message translates to:
  /// **'MARK AS PAID'**
  String get markAsPaid;

  /// No description provided for @markAsPaidConfirm.
  ///
  /// In en, this message translates to:
  /// **'Mark this transaction as paid and move to history?'**
  String get markAsPaidConfirm;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @deleteTx.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteTx;

  /// No description provided for @payItem.
  ///
  /// In en, this message translates to:
  /// **'Pay This'**
  String get payItem;

  /// No description provided for @newCredit.
  ///
  /// In en, this message translates to:
  /// **'NEW CREDIT'**
  String get newCredit;

  /// No description provided for @editCredit.
  ///
  /// In en, this message translates to:
  /// **'EDIT CREDIT'**
  String get editCredit;

  /// No description provided for @whatWasTaken.
  ///
  /// In en, this message translates to:
  /// **'What was taken?'**
  String get whatWasTaken;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qty;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// No description provided for @totalTransactionAmount.
  ///
  /// In en, this message translates to:
  /// **'TOTAL TRANSACTION AMOUNT'**
  String get totalTransactionAmount;

  /// No description provided for @saveToRecord.
  ///
  /// In en, this message translates to:
  /// **'SAVE TO RECORD'**
  String get saveToRecord;

  /// No description provided for @updateRecord.
  ///
  /// In en, this message translates to:
  /// **'UPDATE RECORD'**
  String get updateRecord;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @negativeNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Negative value is not allowed'**
  String get negativeNotAllowed;

  /// No description provided for @paidRecords.
  ///
  /// In en, this message translates to:
  /// **'PAID RECORDS'**
  String get paidRecords;

  /// No description provided for @deletedCustomer.
  ///
  /// In en, this message translates to:
  /// **'Deleted Customer'**
  String get deletedCustomer;

  /// No description provided for @paidOn.
  ///
  /// In en, this message translates to:
  /// **'Paid on: {date}'**
  String paidOn(String date);

  /// No description provided for @deleteRecord.
  ///
  /// In en, this message translates to:
  /// **'DELETE RECORD?'**
  String get deleteRecord;

  /// No description provided for @deleteRecordConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove this transaction from the history.'**
  String get deleteRecordConfirm;

  /// No description provided for @noTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'NO TRANSACTION HISTORY'**
  String get noTransactionHistory;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings;

  /// No description provided for @databaseManagement.
  ///
  /// In en, this message translates to:
  /// **'DATABASE MANAGEMENT'**
  String get databaseManagement;

  /// No description provided for @exportLocalBackup.
  ///
  /// In en, this message translates to:
  /// **'Export Local Backup'**
  String get exportLocalBackup;

  /// No description provided for @exportDescription.
  ///
  /// In en, this message translates to:
  /// **'Securely export your credit database file.'**
  String get exportDescription;

  /// No description provided for @databaseExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Database exported successfully'**
  String get databaseExportSuccess;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String exportFailed(String error);

  /// No description provided for @applicationInfo.
  ///
  /// In en, this message translates to:
  /// **'APPLICATION INFO'**
  String get applicationInfo;

  /// No description provided for @securityEngine.
  ///
  /// In en, this message translates to:
  /// **'Security Engine'**
  String get securityEngine;

  /// No description provided for @localOnlyArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Local-only data architecture'**
  String get localOnlyArchitecture;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Change application language'**
  String get languageDescription;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'CHANGE LANGUAGE'**
  String get changeLanguage;

  /// No description provided for @quantityTimesPrice.
  ///
  /// In en, this message translates to:
  /// **'{qty} x Birr {price}'**
  String quantityTimesPrice(int qty, String price);

  /// No description provided for @birrAmount.
  ///
  /// In en, this message translates to:
  /// **'Birr {amount}'**
  String birrAmount(String amount);

  /// No description provided for @amountBirr.
  ///
  /// In en, this message translates to:
  /// **'{amount} Birr'**
  String amountBirr(String amount);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en', 'om'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'om':
      return AppLocalizationsOm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

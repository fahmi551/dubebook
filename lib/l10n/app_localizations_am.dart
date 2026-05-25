// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appName => 'ዱቤ ማስታወሻ';

  @override
  String get appTagline => 'ባለሙያ የሱቅ ረዳት';

  @override
  String get version => 'ስሪት 0.0.1 (ቅድመ-ልቀት)';

  @override
  String get copyright => '© 2024 WECAN TEAM';

  @override
  String get selectLanguage => 'ቋንቋ ይምረጡ';

  @override
  String get continueBtn => 'ቀጥል';

  @override
  String get enterPasswordPrompt => 'ለመግባት የይለፍ ቃል ያስገቡ';

  @override
  String get passwordHint => '••••••';

  @override
  String get accessDenied => 'ገንቢ ተከልክሏል';

  @override
  String get enter => 'ግባ';

  @override
  String get forgotPassword => 'የይለፍ ቃል ረስተዋል?';

  @override
  String get recovery => 'መልሶ ማግኘት';

  @override
  String get placeOfBirth => 'የትውልድ ቦታ';

  @override
  String get yearShopOpened => 'ሱቅ የተከፈተበት ዓመት';

  @override
  String get createNewPassword => 'አዲስ የይለፍ ቃል ፍጠር';

  @override
  String get cancel => 'ሰርዝ';

  @override
  String get reset => 'ዳግም አስጀምር';

  @override
  String get securityAnswersIncorrect => 'የጥበቃ መልሶች ትክክል አይደሉም';

  @override
  String get passwordResetSuccess => 'የይለፍ ቃል በተሳካ ሁኔታ ተቀይሯል';

  @override
  String get secureSetup => 'ደህንነት ማዋቀር';

  @override
  String get masterPassword => 'ዋና የይለፍ ቃል';

  @override
  String get recoveryQuestions => 'የማግኛ ጥያቄዎች';

  @override
  String get recoveryHelperText =>
      'ዳግም ሊያስታውሱት የሚችሉትን መልስ መጠቀምዎን ያረጋግጡ። ይህ የይለፍ ቃልዎን መልሰው ሲያገኙ ያስፈልጋል።';

  @override
  String get birthCity => 'የትውልድ ከተማ';

  @override
  String get openingYear => 'የመክፈቻ ዓመት (ኢትዮጵያ)';

  @override
  String get setUpMyShop => 'ሱቄን አዋቅር';

  @override
  String get dataSecureNote => 'መረጃዎ በዚህ መሣሪያ ላይ ብቻ ተከማችቷል።';

  @override
  String get passwordRequired => 'የይለፍ ቃል ያስፈልጋል';

  @override
  String get passwordMinLength => 'ቢያንስ 4 ቁምፊዎች መሆን አለበት';

  @override
  String get birthCityRequired => 'የትውልድ ከተማ ያስፈልጋል';

  @override
  String get yearRequired => 'ዓመት ያስፈልጋል';

  @override
  String get yearExactDigits => 'በትክክል 4 አሃዞች መሆን አለበት';

  @override
  String get invalidYearFormat => 'ልክ ያልሆነ ዓመት ቅርጸት';

  @override
  String yearFuture(int year) {
    return 'ወደፊት ሊሆን አይችልም ($year ዓ.ም.)';
  }

  @override
  String yearTooOld(int year) {
    return 'በጣም ያረጀ (ዝቅተኛ: $year)';
  }

  @override
  String get totalOutstanding => 'ጠቅላላ ያልተከፈለ';

  @override
  String get birr => 'ብር';

  @override
  String get activeCredit => 'ንቁ ብድር';

  @override
  String get pendingDebts => 'ያልተከፈሉ ዕዳዎች';

  @override
  String customersCount(int count) {
    return '$count ደንበኞች';
  }

  @override
  String get noCustomersFound => 'ደንበኞች አልተገኙም';

  @override
  String get newCustomer => 'አዲስ ደንበኛ';

  @override
  String get registerCustomer => 'ደንበኛ ይመዝገቡ';

  @override
  String get fullName => 'ሙሉ ስም';

  @override
  String get setPaymentDeadline => 'የክፍያ ግዜ ያዘጋጁ';

  @override
  String get register => 'መዝግብ';

  @override
  String get noDeadlineSet => 'ግዜ አልተዘጋጀም';

  @override
  String dueDate(String date) {
    return 'ቀነ-ገደብ $date';
  }

  @override
  String get overdue => 'ጊዜው ያለፈ';

  @override
  String get outstandingBalance => 'ያልተከፈለ ቀሪ ሂሳብ';

  @override
  String get creditHistory => 'የብድር ታሪክ';

  @override
  String itemsCount(int count) {
    return '$count ዕቃዎች';
  }

  @override
  String get noUnpaidItems => 'ያልተከፈሉ ዕቃዎች የሉም';

  @override
  String get addCredit => 'ብድር ጨምር';

  @override
  String get settleAll => 'ሁሉንም ክፈል';

  @override
  String get settleDebt => 'ዕዳ ክፈል';

  @override
  String get markAllAsPaidConfirm => 'ሁሉንም ዕቃዎች እንደ ተከፈለ ምልክት ማድረግ ይፈልጋሉ?';

  @override
  String get confirm => 'አረጋግጥ';

  @override
  String get deleteCustomer => 'ደንበኛ ሰርዝ';

  @override
  String get deleteCustomerConfirm =>
      'ይህን ደንበኛና ሁሉንም የግብይት ሪከርዶቻቸውን እስከመጨረሻው ይሰርዛል? ይህ ሊቀለበስ አይችልም።';

  @override
  String get delete => 'ሰርዝ';

  @override
  String get editTransaction => 'ግብይት አስተካክል';

  @override
  String get deleteTransaction => 'ግብይት ሰርዝ';

  @override
  String get deleteTransactionConfirm =>
      'ይህን ግብይት እስከመጨረሻው ይሰርዛል? የደንበኛው ቀሪ ሂሳብ ይዘምናል።';

  @override
  String get markAsPaid => 'ተከፍሏል ምልክት አድርግ';

  @override
  String get markAsPaidConfirm => 'ይህን ግብይት ተከፍሏል ብለው ምልክት ያድርጉ?';

  @override
  String get edit => 'አስተካክል';

  @override
  String get deleteTx => 'ሰርዝ';

  @override
  String get payItem => 'ይህን ክፈል';

  @override
  String get newCredit => 'አዲስ ብድር';

  @override
  String get editCredit => 'ብድር አስተካክል';

  @override
  String get whatWasTaken => 'ምን ተወሰደ?';

  @override
  String get qty => 'ብዛት';

  @override
  String get unitPrice => 'የአንዱ ዋጋ';

  @override
  String get totalTransactionAmount => 'ጠቅላላ የግብይት መጠን';

  @override
  String get saveToRecord => 'ወደ ሪከርድ አስቀምጥ';

  @override
  String get updateRecord => 'ሪከርድ አዘምን';

  @override
  String get fieldRequired => 'ይህ መስክ ያስፈልጋል';

  @override
  String get negativeNotAllowed => 'አሉታዊ ዋጋ አይፈቀድም';

  @override
  String get paidRecords => 'የተከፈሉ ሪከርዶች';

  @override
  String get deletedCustomer => 'የተሰረዘ ደንበኛ';

  @override
  String paidOn(String date) {
    return 'የተከፈለ: $date';
  }

  @override
  String get deleteRecord => 'ሪከርድ ይሰረዝ?';

  @override
  String get deleteRecordConfirm => 'ይህ ግብይት ከታሪክ ዘላቂ ይሰረዛል።';

  @override
  String get noTransactionHistory => 'የግብይት ታሪክ የለም';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String get databaseManagement => 'የመረጃ ቋት አስተዳደር';

  @override
  String get exportLocalBackup => 'ስሪት ውጣ';

  @override
  String get exportDescription => 'የብድር መረጃ ቋትዎን በደህንነት ያስወጡ።';

  @override
  String get databaseExportSuccess => 'መረጃ ቋት በተሳካ ሁኔታ ተልኳል';

  @override
  String exportFailed(String error) {
    return 'ማስወጣት አልተሳካም: $error';
  }

  @override
  String get applicationInfo => 'የመተግበሪያ መረጃ';

  @override
  String get securityEngine => 'የጥበቃ ስርዓት';

  @override
  String get localOnlyArchitecture => 'በመሣሪያው ላይ ብቻ የተከማቸ';

  @override
  String get language => 'ቋንቋ';

  @override
  String get languageDescription => 'የመተግበሪያ ቋንቋ ይቀይሩ';

  @override
  String get changeLanguage => 'ቋንቋ ቀይር';

  @override
  String quantityTimesPrice(int qty, String price) {
    return '$qty x ብር $price';
  }

  @override
  String birrAmount(String amount) {
    return 'ብር $amount';
  }

  @override
  String amountBirr(String amount) {
    return '$amount ብር';
  }
}

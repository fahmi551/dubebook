// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oromo (`om`).
class AppLocalizationsOm extends AppLocalizations {
  AppLocalizationsOm([String locale = 'om']) : super(locale);

  @override
  String get appName => 'DUBE NOTE';

  @override
  String get appTagline => 'GARGAARSA SUUQII OGUMMAA';

  @override
  String get version => 'Gosa 0.0.1 (Beta)';

  @override
  String get copyright => '© 2024 WECAN TEAM';

  @override
  String get selectLanguage => 'AFAAN FILADHU';

  @override
  String get continueBtn => 'ITTI FUFI';

  @override
  String get enterPasswordPrompt => 'SEENUUF JECHA DARBII GALCHI';

  @override
  String get passwordHint => '••••••';

  @override
  String get accessDenied => 'Hayyamni Dhorkame';

  @override
  String get enter => 'SEENI';

  @override
  String get forgotPassword => 'JECHA DARBII DAGATTEE?';

  @override
  String get recovery => 'DEEBISUU';

  @override
  String get placeOfBirth => 'Bakka Dhalootaa';

  @override
  String get yearShopOpened => 'Bara Suuqiin Baname';

  @override
  String get createNewPassword => 'Jecha Darbii Haaraa Uumi';

  @override
  String get cancel => 'HAQI';

  @override
  String get reset => 'HAAROMSI';

  @override
  String get securityAnswersIncorrect => 'DEEBIIN NAGEENYA SIRRII MITI';

  @override
  String get passwordResetSuccess => 'Jechni darbii milkaa\'inaan jijjiirame';

  @override
  String get secureSetup => 'QINDAA\'INA NAGEENYA';

  @override
  String get masterPassword => 'Jecha Darbii Jalqabaa';

  @override
  String get recoveryQuestions => 'GAAFFILEE DEEBISUU';

  @override
  String get recoveryHelperText =>
      'Deebii booda yaadachuu dandeessan galchuudhaaf qabaa. Kun yeroo jecha darbii deebistan isin barbaachisa.';

  @override
  String get birthCity => 'Magaalaa Dhalootaa';

  @override
  String get openingYear => 'Bara Banamsaa (Itoophiyaa)';

  @override
  String get setUpMyShop => 'Suuqii Koo Qindeessi';

  @override
  String get dataSecureNote =>
      'Daataan keessan meeshaa kana qofa irratti kuufame.';

  @override
  String get passwordRequired => 'Jechni darbii barbaachisaadha';

  @override
  String get passwordMinLength => 'Yoo xiqqaate arfii 4 ta\'uu qaba';

  @override
  String get birthCityRequired => 'Magaalaan dhalootaa barbaachisaadha';

  @override
  String get yearRequired => 'Barri barbaachisaadha';

  @override
  String get yearExactDigits => 'Lakkoofsa 4 qofa ta\'uu qaba';

  @override
  String get invalidYearFormat => 'Boca baraa sirrii miti';

  @override
  String yearFuture(int year) {
    return 'Gara fuulduraatti ta\'uu hin danda\'u ($year)';
  }

  @override
  String yearTooOld(int year) {
    return 'Baay\'ee durii (Xiqqaate: $year)';
  }

  @override
  String get totalOutstanding => 'WALIIGALA HIN KAFFALAMNE';

  @override
  String get birr => 'Birrii';

  @override
  String get activeCredit => 'Liqii Hojii Irra Jiru';

  @override
  String get pendingDebts => 'LIQII HIN KAFFALAMNE';

  @override
  String customersCount(int count) {
    return 'MAAMILOOTA $count';
  }

  @override
  String get noCustomersFound => 'MAAMILNI HIN ARGAMNE';

  @override
  String get newCustomer => 'MAAMILA HAARAA';

  @override
  String get registerCustomer => 'MAAMILA GALMEESSI';

  @override
  String get fullName => 'Maqaa Guutuu';

  @override
  String get setPaymentDeadline => 'Beellama Kaffaltii Qindeessi';

  @override
  String get register => 'GALMEESSI';

  @override
  String get noDeadlineSet => 'Beellamni hin qindaa\'in';

  @override
  String dueDate(String date) {
    return 'Guyyaa $date';
  }

  @override
  String get overdue => 'YEROON DARBE';

  @override
  String get outstandingBalance => 'HAFTEE HIN KAFFALAMNE';

  @override
  String get creditHistory => 'SEENAA LIQII';

  @override
  String itemsCount(int count) {
    return 'MEESHAALEE $count';
  }

  @override
  String get noUnpaidItems => 'MEESHAAN HIN KAFFALAMNE HIN JIRU';

  @override
  String get addCredit => 'LIQII DABALII';

  @override
  String get settleAll => 'HUNDA KAFFALI';

  @override
  String get settleDebt => 'LIQII KAFFALI';

  @override
  String get markAllAsPaidConfirm =>
      'Meeshaalee hunda akka kaffalameetti mallattoo gochuu barbaaddaa?';

  @override
  String get confirm => 'MIRKANEESSI';

  @override
  String get deleteCustomer => 'MAAMILA HAQI';

  @override
  String get deleteCustomerConfirm =>
      'Maamila kana fi galmee daldalaa hunda haquuf? Kun deebi\'uu hin danda\'u.';

  @override
  String get delete => 'HAQI';

  @override
  String get editTransaction => 'DALDALAA SIRREESSI';

  @override
  String get deleteTransaction => 'DALDALAA HAQI';

  @override
  String get deleteTransactionConfirm =>
      'Daldalaa kana haquuf? Hafteen maamila ni haaromsa.';

  @override
  String get markAsPaid => 'KAFFALAME JEDHI';

  @override
  String get markAsPaidConfirm =>
      'Daldalaa kana kaffalame jettee mallattoo godhuu barbaaddaa?';

  @override
  String get edit => 'Sirreessi';

  @override
  String get deleteTx => 'Haqi';

  @override
  String get payItem => 'Kana Kaffali';

  @override
  String get newCredit => 'LIQII HAARAA';

  @override
  String get editCredit => 'LIQII SIRREESSI';

  @override
  String get whatWasTaken => 'Maaltu fudhatame?';

  @override
  String get qty => 'Bay.';

  @override
  String get unitPrice => 'Gatii Tokkoo';

  @override
  String get totalTransactionAmount => 'WALIIGALA GATII DALDALAA';

  @override
  String get saveToRecord => 'GALMEETTI OLKAA\'I';

  @override
  String get updateRecord => 'GALMEE HAAROMSI';

  @override
  String get fieldRequired => 'Dirreen kun barbaachisaadha';

  @override
  String get negativeNotAllowed => 'Gatiin negaatiivii hin hayyamamu';

  @override
  String get paidRecords => 'GALMEE KAFFALAME';

  @override
  String get deletedCustomer => 'Maamila Haqame';

  @override
  String paidOn(String date) {
    return 'Kaffalame: $date';
  }

  @override
  String get deleteRecord => 'GALMEE HAQI?';

  @override
  String get deleteRecordConfirm =>
      'Daldalaan kun seenaa keessaa dhaabbataan ni haqama.';

  @override
  String get noTransactionHistory => 'SEENAAN DALDALAA HIN JIRU';

  @override
  String get settings => 'QINDAA\'INA';

  @override
  String get databaseManagement => 'BULCHIINSA KUUSAA';

  @override
  String get exportLocalBackup => 'Kuusaa Olbaasi';

  @override
  String get exportDescription => 'Kuusaa liqii keessan nagaan olbaasaa.';

  @override
  String get databaseExportSuccess => 'Kuusaan milkaa\'inaan ergame';

  @override
  String exportFailed(String error) {
    return 'Olbaasuun hin milkoofne: $error';
  }

  @override
  String get applicationInfo => 'ODEEFFANNOO APPII';

  @override
  String get securityEngine => 'Mootiira Nageenya';

  @override
  String get localOnlyArchitecture => 'Meeshaa kana qofa irratti kuufame';

  @override
  String get language => 'Afaan';

  @override
  String get languageDescription => 'Afaan appii jijjiiri';

  @override
  String get changeLanguage => 'AFAAN JIJJIIRI';

  @override
  String quantityTimesPrice(int qty, String price) {
    return '$qty x Birrii $price';
  }

  @override
  String birrAmount(String amount) {
    return 'Birrii $amount';
  }

  @override
  String amountBirr(String amount) {
    return '$amount Birrii';
  }
}

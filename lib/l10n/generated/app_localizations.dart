import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @keyword_locale.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get keyword_locale;

  /// No description provided for @keyword_local_language.
  ///
  /// In en, this message translates to:
  /// **'en_US'**
  String get keyword_local_language;

  /// No description provided for @keyword_country.
  ///
  /// In en, this message translates to:
  /// **'England'**
  String get keyword_country;

  /// No description provided for @keyword_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get keyword_username;

  /// No description provided for @keyword_enter_username.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get keyword_enter_username;

  /// No description provided for @keyword_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get keyword_password;

  /// No description provided for @keyword_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get keyword_enter_password;

  /// No description provided for @keyword_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get keyword_forgot_password;

  /// No description provided for @keyword_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get keyword_login;

  /// No description provided for @keyword_no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get keyword_no_account;

  /// No description provided for @keyword_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get keyword_sign_up;

  /// No description provided for @keyword_or_sigin_with.
  ///
  /// In en, this message translates to:
  /// **'Or sigin with'**
  String get keyword_or_sigin_with;

  /// No description provided for @keyword_access_to_purchased_tickets.
  ///
  /// In en, this message translates to:
  /// **'Access to purchased tickets'**
  String get keyword_access_to_purchased_tickets;

  /// No description provided for @keyword_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get keyword_continue;

  /// No description provided for @keyword_enter_the_password_from_the_SMS.
  ///
  /// In en, this message translates to:
  /// **'Enter the password from the SMS'**
  String get keyword_enter_the_password_from_the_SMS;

  /// No description provided for @keyword_change_number.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get keyword_change_number;

  /// No description provided for @keyword_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get keyword_resend;

  /// No description provided for @keyword_national_language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get keyword_national_language;

  /// No description provided for @keyword_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get keyword_search;

  /// No description provided for @keyword_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get keyword_upcoming;

  /// No description provided for @keyword_view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get keyword_view_all;

  /// No description provided for @keyword_now_in_cinemas.
  ///
  /// In en, this message translates to:
  /// **'Now in cinemas'**
  String get keyword_now_in_cinemas;

  /// No description provided for @keyword_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get keyword_profile;

  /// No description provided for @keyword_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get keyword_about;

  /// No description provided for @keyword_sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get keyword_sessions;

  /// No description provided for @keyword_certificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get keyword_certificate;

  /// No description provided for @keyword_release.
  ///
  /// In en, this message translates to:
  /// **'Release'**
  String get keyword_release;

  /// No description provided for @keyword_genre.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get keyword_genre;

  /// No description provided for @keyword_director.
  ///
  /// In en, this message translates to:
  /// **'Director'**
  String get keyword_director;

  /// No description provided for @keyword_cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get keyword_cast;

  /// No description provided for @keyword_select_session.
  ///
  /// In en, this message translates to:
  /// **'Select session'**
  String get keyword_select_session;

  /// No description provided for @keyword_time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get keyword_time;

  /// No description provided for @keyword_sort_by.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get keyword_sort_by;

  /// No description provided for @keyword_distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get keyword_distance;

  /// No description provided for @keyword_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get keyword_price;

  /// No description provided for @keyword_order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get keyword_order;

  /// No description provided for @keyword_ascending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get keyword_ascending;

  /// No description provided for @keyword_descending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get keyword_descending;

  /// No description provided for @keyword_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get keyword_apply;

  /// No description provided for @keyword_by_cinema.
  ///
  /// In en, this message translates to:
  /// **'By cinema'**
  String get keyword_by_cinema;

  /// No description provided for @keyword_available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get keyword_available;

  /// No description provided for @keyword_occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get keyword_occupied;

  /// No description provided for @keyword_chosen.
  ///
  /// In en, this message translates to:
  /// **'Chosen'**
  String get keyword_chosen;

  /// No description provided for @keyword_screen.
  ///
  /// In en, this message translates to:
  /// **'Screen'**
  String get keyword_screen;

  /// No description provided for @keyword_select_ticket_type.
  ///
  /// In en, this message translates to:
  /// **'Select ticket type'**
  String get keyword_select_ticket_type;

  /// No description provided for @keyword_adult.
  ///
  /// In en, this message translates to:
  /// **'Adult'**
  String get keyword_adult;

  /// No description provided for @keyword_child.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get keyword_child;

  /// No description provided for @keyword_student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get keyword_student;

  /// No description provided for @keyword_this_seat_is_unavailable.
  ///
  /// In en, this message translates to:
  /// **'This seat is unavailable'**
  String get keyword_this_seat_is_unavailable;

  /// No description provided for @keyword_buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get keyword_buy;

  /// No description provided for @keyword_ticket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get keyword_ticket;

  /// No description provided for @keyword_tickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get keyword_tickets;

  /// No description provided for @keyword_deselect_this_seat.
  ///
  /// In en, this message translates to:
  /// **'Deselect this seat'**
  String get keyword_deselect_this_seat;

  /// No description provided for @keyword_pay_for_ticket.
  ///
  /// In en, this message translates to:
  /// **'Pay for ticket'**
  String get keyword_pay_for_ticket;

  /// No description provided for @keyword_cinema.
  ///
  /// In en, this message translates to:
  /// **'Cinema'**
  String get keyword_cinema;

  /// No description provided for @keyword_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get keyword_date;

  /// No description provided for @keyword_runtime.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get keyword_runtime;

  /// No description provided for @keyword_seats.
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get keyword_seats;

  /// No description provided for @keyword_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get keyword_total;

  /// No description provided for @keyword_bank_card.
  ///
  /// In en, this message translates to:
  /// **'Bank card'**
  String get keyword_bank_card;

  /// No description provided for @keyword_remove_card.
  ///
  /// In en, this message translates to:
  /// **'Remove card'**
  String get keyword_remove_card;

  /// No description provided for @keyword_add_card.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get keyword_add_card;

  /// No description provided for @keyword_card_number.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get keyword_card_number;

  /// No description provided for @keyword_mm.
  ///
  /// In en, this message translates to:
  /// **'MM'**
  String get keyword_mm;

  /// No description provided for @keyword_yy.
  ///
  /// In en, this message translates to:
  /// **'YY'**
  String get keyword_yy;

  /// No description provided for @keyword_cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get keyword_cvv;

  /// No description provided for @keyword_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get keyword_phone_number;

  /// No description provided for @keyword_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get keyword_email;

  /// No description provided for @keyword_your_tickets.
  ///
  /// In en, this message translates to:
  /// **'Your tickets'**
  String get keyword_your_tickets;

  /// No description provided for @keyword_show_this_to_the_gatekeeper_at_the_cinema.
  ///
  /// In en, this message translates to:
  /// **'Show this to the gatekeeper at the cinema'**
  String get keyword_show_this_to_the_gatekeeper_at_the_cinema;

  /// No description provided for @keyword_hall.
  ///
  /// In en, this message translates to:
  /// **'Hall'**
  String get keyword_hall;

  /// No description provided for @keyword_cost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get keyword_cost;

  /// No description provided for @keyword_refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get keyword_refund;

  /// No description provided for @keyword_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get keyword_send;

  /// No description provided for @keyword_save_cards.
  ///
  /// In en, this message translates to:
  /// **'Save cards'**
  String get keyword_save_cards;

  /// No description provided for @keyword_add_new_card.
  ///
  /// In en, this message translates to:
  /// **'Add new card'**
  String get keyword_add_new_card;

  /// No description provided for @keyword_payment_history.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get keyword_payment_history;

  /// No description provided for @keyword_information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get keyword_information;

  /// No description provided for @keyword_full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get keyword_full_name;

  /// No description provided for @keyword_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get keyword_date_of_birth;

  /// No description provided for @keyword_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get keyword_gender;

  /// No description provided for @keyword_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get keyword_male;

  /// No description provided for @keyword_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get keyword_female;

  /// No description provided for @keyword_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get keyword_other;

  /// No description provided for @keyword_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get keyword_location;

  /// No description provided for @keyword_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get keyword_save;

  /// No description provided for @keyword_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get keyword_settings;

  /// No description provided for @keyword_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get keyword_language;

  /// No description provided for @keyword_recieve_notifications.
  ///
  /// In en, this message translates to:
  /// **'Recieve notifications'**
  String get keyword_recieve_notifications;

  /// No description provided for @error_validate.
  ///
  /// In en, this message translates to:
  /// **'ERROR_validate'**
  String get error_validate;

  /// No description provided for @error_username_required.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be empty'**
  String get error_username_required;

  /// No description provided for @error_username_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get error_username_invalid;

  /// No description provided for @error_password_required.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get error_password_required;

  /// No description provided for @error_password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get error_password_min_length;

  /// No description provided for @error_phone_required.
  ///
  /// In en, this message translates to:
  /// **'Phone number cannot be empty'**
  String get error_phone_required;

  /// No description provided for @error_phone_invalid_length.
  ///
  /// In en, this message translates to:
  /// **'Phone number must have 10 digits'**
  String get error_phone_invalid_length;

  /// No description provided for @error_phone_invalid_pattern.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain only digits'**
  String get error_phone_invalid_pattern;

  /// No description provided for @error_field_required.
  ///
  /// In en, this message translates to:
  /// **'{fieldName} cannot be empty'**
  String error_field_required(Object fieldName);

  /// No description provided for @error_generic_field_required.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get error_generic_field_required;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Birth Day`
  String get birthday {
    return Intl.message('Birth Day', name: 'birthday', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Sign Up with Google`
  String get sign_up_with_google {
    return Intl.message(
      'Sign Up with Google',
      name: 'sign_up_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your Account`
  String get sign_in {
    return Intl.message(
      'Sign in to your Account',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and password to log in `
  String get enter_your_email_and_password {
    return Intl.message(
      'Enter your email and password to log in ',
      name: 'enter_your_email_and_password',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continue_with_google {
    return Intl.message(
      'Continue with Google',
      name: 'continue_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Or login with`
  String get or_login_with {
    return Intl.message(
      'Or login with',
      name: 'or_login_with',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password ?`
  String get forgot_password {
    return Intl.message(
      'Forgot password ?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message('Remember me', name: 'remember_me', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get Dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'Dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up2 {
    return Intl.message('Sign Up', name: 'sign_up2', desc: '', args: []);
  }

  /// `Login`
  String get login2 {
    return Intl.message('Login', name: 'login2', desc: '', args: []);
  }

  /// ` ع `
  String get english {
    return Intl.message(' ع ', name: 'english', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Empty cell`
  String get empty_cell {
    return Intl.message('Empty cell', name: 'empty_cell', desc: '', args: []);
  }

  /// `Password must be at least 6 characters`
  String get password_length {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_length',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid name`
  String get invalid_name {
    return Intl.message(
      'Invalid name',
      name: 'invalid_name',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone`
  String get invalid_phone {
    return Intl.message(
      'Invalid phone',
      name: 'invalid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Password not match`
  String get password_not_match {
    return Intl.message(
      'Password not match',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weak_password {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get account_exists {
    return Intl.message(
      'The account already exists for that email.',
      name: 'account_exists',
      desc: '',
      args: [],
    );
  }

  /// `Error login, please try again`
  String get error_login {
    return Intl.message(
      'Error login, please try again',
      name: 'error_login',
      desc: '',
      args: [],
    );
  }

  /// `verification email sent`
  String get verify_email {
    return Intl.message(
      'verification email sent',
      name: 'verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email to verify your account`
  String get desc_verify_email {
    return Intl.message(
      'Please check your email to verify your account',
      name: 'desc_verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in aborted`
  String get google_error {
    return Intl.message(
      'Google sign-in aborted',
      name: 'google_error',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to reset the password`
  String get enter_your_email_to_reset {
    return Intl.message(
      'Please enter your email to reset the password',
      name: 'enter_your_email_to_reset',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get your_email {
    return Intl.message('Your Email', name: 'your_email', desc: '', args: []);
  }

  /// `Enter your email`
  String get enter_your_email2 {
    return Intl.message(
      'Enter your email',
      name: 'enter_your_email2',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get forget_password2 {
    return Intl.message(
      'Forget Password',
      name: 'forget_password2',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Error reset password, please try again`
  String get error_reset_password {
    return Intl.message(
      'Error reset password, please try again',
      name: 'error_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Check your mail`
  String get check_your_mail {
    return Intl.message(
      'Check your mail',
      name: 'check_your_mail',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a password recover instruction to your email.`
  String get password_instruction {
    return Intl.message(
      'We have sent a password recover instruction to your email.',
      name: 'password_instruction',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Favorites`
  String get Favorites {
    return Intl.message('Favorites', name: 'Favorites', desc: '', args: []);
  }

  /// `Hi`
  String get hi {
    return Intl.message('Hi', name: 'hi', desc: '', args: []);
  }

  /// `John Doe`
  String get someone_name {
    return Intl.message('John Doe', name: 'someone_name', desc: '', args: []);
  }

  /// `Let's go shopping`
  String get lets_go_shopping {
    return Intl.message(
      'Let\'s go shopping',
      name: 'lets_go_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Choose language`
  String get Choose_language {
    return Intl.message(
      'Choose language',
      name: 'Choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password2 {
    return Intl.message('Password', name: 'password2', desc: '', args: []);
  }

  /// `Password should be:`
  String get password_instruction2 {
    return Intl.message(
      'Password should be:',
      name: 'password_instruction2',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 characters`
  String get password_length2 {
    return Intl.message(
      'At least 6 characters',
      name: 'password_length2',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 uppercase letter (A-Z)`
  String get password_uppercase {
    return Intl.message(
      'At least 1 uppercase letter (A-Z)',
      name: 'password_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 lowercase letter (a-z)`
  String get password_lowercase {
    return Intl.message(
      'At least 1 lowercase letter (a-z)',
      name: 'password_lowercase',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 number (0-9)`
  String get password_number {
    return Intl.message(
      'At least 1 number (0-9)',
      name: 'password_number',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 special character (_!@#$%^&*)`
  String get password_special {
    return Intl.message(
      'At least 1 special character (_!@#\$%^&*)',
      name: 'password_special',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Change password successfully`
  String get change_password_successfully {
    return Intl.message(
      'Change password successfully',
      name: 'change_password_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Don't forget your new password`
  String get dont_forget_new_password {
    return Intl.message(
      'Don\'t forget your new password',
      name: 'dont_forget_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personal_info {
    return Intl.message(
      'Personal information',
      name: 'personal_info',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Save changes`
  String get save_changes {
    return Intl.message(
      'Save changes',
      name: 'save_changes',
      desc: '',
      args: [],
    );
  }

  /// `New Arrival🔥`
  String get new_arrival {
    return Intl.message(
      'New Arrival🔥',
      name: 'new_arrival',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get best_seller {
    return Intl.message('Best Seller', name: 'best_seller', desc: '', args: []);
  }

  /// `Most Popular`
  String get most_popular {
    return Intl.message(
      'Most Popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

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

  /// `Category`
  String get category2 {
    return Intl.message('Category', name: 'category2', desc: '', args: []);
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

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message('Add to Cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Added to Cart`
  String get added_to_cart {
    return Intl.message(
      'Added to Cart',
      name: 'added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Show More`
  String get show_more {
    return Intl.message('Show More', name: 'show_more', desc: '', args: []);
  }

  /// `Show Less`
  String get show_less {
    return Intl.message('Show Less', name: 'show_less', desc: '', args: []);
  }

  /// `No favorite item's found`
  String get no_favorite_item {
    return Intl.message(
      'No favorite item\'s found',
      name: 'no_favorite_item',
      desc: '',
      args: [],
    );
  }

  /// `You can add items to your favorite list by clicking the heart icon`
  String get you_can_add_items {
    return Intl.message(
      'You can add items to your favorite list by clicking the heart icon',
      name: 'you_can_add_items',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_card2 {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_card2',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Added`
  String get added {
    return Intl.message('Added', name: 'added', desc: '', args: []);
  }

  /// `Search something...`
  String get search_something {
    return Intl.message(
      'Search something...',
      name: 'search_something',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a search term`
  String get please_enter_a_search_term {
    return Intl.message(
      'Please enter a search term',
      name: 'please_enter_a_search_term',
      desc: '',
      args: [],
    );
  }

  /// `Delete All`
  String get delete_all {
    return Intl.message('Delete All', name: 'delete_all', desc: '', args: []);
  }

  /// `Confirm Deletion`
  String get confirm_deletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirm_deletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all Favorite products?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure you want to delete all Favorite products?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all cart Items?`
  String get are_you_sure2 {
    return Intl.message(
      'Are you sure you want to delete all cart Items?',
      name: 'are_you_sure2',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Your cart is Empty`
  String get your_cart_is_empty {
    return Intl.message(
      'Your cart is Empty',
      name: 'your_cart_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you haven't added anything to your cart yet`
  String get looks_like_you_havent_added {
    return Intl.message(
      'Looks like you haven\'t added anything to your cart yet',
      name: 'looks_like_you_havent_added',
      desc: '',
      args: [],
    );
  }

  /// `Go to Checkout`
  String get go_to_checkout {
    return Intl.message(
      'Go to Checkout',
      name: 'go_to_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout2 {
    return Intl.message('Checkout', name: 'checkout2', desc: '', args: []);
  }

  /// `Total amount`
  String get total_amount {
    return Intl.message(
      'Total amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Shipping fees`
  String get shipping_fees {
    return Intl.message(
      'Shipping fees',
      name: 'shipping_fees',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `Free`
  String get free {
    return Intl.message('Free', name: 'free', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `New Address`
  String get address_new {
    return Intl.message('New Address', name: 'address_new', desc: '', args: []);
  }

  /// `Choose your location`
  String get choose_your_location {
    return Intl.message(
      'Choose your location',
      name: 'choose_your_location',
      desc: '',
      args: [],
    );
  }

  /// `Enter your address details to ensure your order reaches your doorstep.`
  String get make_sure_to_choose_your_location {
    return Intl.message(
      'Enter your address details to ensure your order reaches your doorstep.',
      name: 'make_sure_to_choose_your_location',
      desc: '',
      args: [],
    );
  }

  /// `Enter your address`
  String get enter_your_address {
    return Intl.message(
      'Enter your address',
      name: 'enter_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get selecet_location {
    return Intl.message(
      'Select Location',
      name: 'selecet_location',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Street`
  String get street {
    return Intl.message('Street', name: 'street', desc: '', args: []);
  }

  /// `Street`
  String get street2 {
    return Intl.message('Street', name: 'street2', desc: '', args: []);
  }

  /// `Area`
  String get area {
    return Intl.message('Area', name: 'area', desc: '', args: []);
  }

  /// `Building`
  String get building {
    return Intl.message('Building', name: 'building', desc: '', args: []);
  }

  /// `Egypt`
  String get egypt {
    return Intl.message('Egypt', name: 'egypt', desc: '', args: []);
  }

  /// `Palestine`
  String get palestine {
    return Intl.message('Palestine', name: 'palestine', desc: '', args: []);
  }

  /// `Saudi Arabia`
  String get saudi_arabia {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudi_arabia',
      desc: '',
      args: [],
    );
  }

  /// `Qatar`
  String get qatar {
    return Intl.message('Qatar', name: 'qatar', desc: '', args: []);
  }

  /// `Bahrain`
  String get bahrain {
    return Intl.message('Bahrain', name: 'bahrain', desc: '', args: []);
  }

  /// `Cairo`
  String get cairo {
    return Intl.message('Cairo', name: 'cairo', desc: '', args: []);
  }

  /// `Giza`
  String get giza {
    return Intl.message('Giza', name: 'giza', desc: '', args: []);
  }

  /// `Alexandria`
  String get alexandria {
    return Intl.message('Alexandria', name: 'alexandria', desc: '', args: []);
  }

  /// `Tanta`
  String get tanta {
    return Intl.message('Tanta', name: 'tanta', desc: '', args: []);
  }

  /// `Behera`
  String get behera {
    return Intl.message('Behera', name: 'behera', desc: '', args: []);
  }

  /// `Mansoura`
  String get mansoura {
    return Intl.message('Mansoura', name: 'mansoura', desc: '', args: []);
  }

  /// `Suez`
  String get suez {
    return Intl.message('Suez', name: 'suez', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Type your address`
  String get type_your_address {
    return Intl.message(
      'Type your address',
      name: 'type_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submet {
    return Intl.message('Submit', name: 'submet', desc: '', args: []);
  }

  /// `Choose the address where you would like to receive your orders.`
  String get choose_the_address {
    return Intl.message(
      'Choose the address where you would like to receive your orders.',
      name: 'choose_the_address',
      desc: '',
      args: [],
    );
  }

  /// `No Saved Address`
  String get no_saved_addresses {
    return Intl.message(
      'No Saved Address',
      name: 'no_saved_addresses',
      desc: '',
      args: [],
    );
  }

  /// `You haven't saved an address yet. Add one now to receive your orders smoothly!`
  String get you_havenot_saved_any_address {
    return Intl.message(
      'You haven\'t saved an address yet. Add one now to receive your orders smoothly!',
      name: 'you_havenot_saved_any_address',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get add_new_address {
    return Intl.message(
      'Add New Address',
      name: 'add_new_address',
      desc: '',
      args: [],
    );
  }

  /// `Edit Address`
  String get edit_address {
    return Intl.message(
      'Edit Address',
      name: 'edit_address',
      desc: '',
      args: [],
    );
  }

  /// `Please select the exact address where you would like to receive your orders to ensure fast and smooth delivery.`
  String get please_select_axact_address {
    return Intl.message(
      'Please select the exact address where you would like to receive your orders to ensure fast and smooth delivery.',
      name: 'please_select_axact_address',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `There is no description for this product`
  String get no_description {
    return Intl.message(
      'There is no description for this product',
      name: 'no_description',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `No reviews yet`
  String get no_reviews {
    return Intl.message(
      'No reviews yet',
      name: 'no_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Enter Verification Code`
  String get verify_email_1 {
    return Intl.message(
      'Enter Verification Code',
      name: 'verify_email_1',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a verification code to your email, please enter it below to verify your account.`
  String get verify_email_2 {
    return Intl.message(
      'We have sent a verification code to your email, please enter it below to verify your account.',
      name: 'verify_email_2',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get verify_email_3 {
    return Intl.message(
      'Resend Code',
      name: 'verify_email_3',
      desc: '',
      args: [],
    );
  }

  /// `Did not receive the code?`
  String get verify_email_4 {
    return Intl.message(
      'Did not receive the code?',
      name: 'verify_email_4',
      desc: '',
      args: [],
    );
  }

  /// `Error verification code, please try again`
  String get error_verification_code {
    return Intl.message(
      'Error verification code, please try again',
      name: 'error_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify email successfully`
  String get verify_email_successfully {
    return Intl.message(
      'Verify email successfully',
      name: 'verify_email_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP code successfully`
  String get verify_otp_code_successfully {
    return Intl.message(
      'Verify OTP code successfully',
      name: 'verify_otp_code_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Set New Password`
  String get assign_new_password {
    return Intl.message(
      'Set New Password',
      name: 'assign_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password to assign it to your account.`
  String get assign_new_password_desc {
    return Intl.message(
      'Please enter your new password to assign it to your account.',
      name: 'assign_new_password_desc',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset password successfully`
  String get reset_password_successfully {
    return Intl.message(
      'Reset password successfully',
      name: 'reset_password_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP code successfully`
  String get resend_otp_code_successfully {
    return Intl.message(
      'Resend OTP code successfully',
      name: 'resend_otp_code_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postal_code {
    return Intl.message('Postal Code', name: 'postal_code', desc: '', args: []);
  }

  /// `Please enter your postal code to ensure fast and smooth delivery.`
  String get postal_code_desc {
    return Intl.message(
      'Please enter your postal code to ensure fast and smooth delivery.',
      name: 'postal_code_desc',
      desc: '',
      args: [],
    );
  }

  /// `Enter your postal code`
  String get enter_your_postal_code {
    return Intl.message(
      'Enter your postal code',
      name: 'enter_your_postal_code',
      desc: '',
      args: [],
    );
  }

  /// `Invalid postal code`
  String get invalid_postal_code {
    return Intl.message(
      'Invalid postal code',
      name: 'invalid_postal_code',
      desc: '',
      args: [],
    );
  }

  /// `No matching products found.`
  String get no_matching_products {
    return Intl.message(
      'No matching products found.',
      name: 'no_matching_products',
      desc: '',
      args: [],
    );
  }

  /// `Search in your favorite`
  String get search_in_your_favorite {
    return Intl.message(
      'Search in your favorite',
      name: 'search_in_your_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Error updating quantity, please try again`
  String get error_updating_quantity {
    return Intl.message(
      'Error updating quantity, please try again',
      name: 'error_updating_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Change Address`
  String get change_address {
    return Intl.message(
      'Change Address',
      name: 'change_address',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clear_all {
    return Intl.message('Clear All', name: 'clear_all', desc: '', args: []);
  }

  /// `Last Search`
  String get last_search {
    return Intl.message('Last Search', name: 'last_search', desc: '', args: []);
  }

  /// `Search...`
  String get search_ {
    return Intl.message('Search...', name: 'search_', desc: '', args: []);
  }

  /// `EGP`
  String get egyption_currency {
    return Intl.message('EGP', name: 'egyption_currency', desc: '', args: []);
  }

  /// `No ratings yet`
  String get no_reatings {
    return Intl.message(
      'No ratings yet',
      name: 'no_reatings',
      desc: '',
      args: [],
    );
  }

  /// `Search result for`
  String get search_result_for {
    return Intl.message(
      'Search result for',
      name: 'search_result_for',
      desc: '',
      args: [],
    );
  }

  /// `No recent searches`
  String get no_recent_searches {
    return Intl.message(
      'No recent searches',
      name: 'no_recent_searches',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get no_products_found {
    return Intl.message(
      'No products found',
      name: 'no_products_found',
      desc: '',
      args: [],
    );
  }

  /// `Filter Options`
  String get filter_options {
    return Intl.message(
      'Filter Options',
      name: 'filter_options',
      desc: '',
      args: [],
    );
  }

  /// `Clear Filters`
  String get clear_filters {
    return Intl.message(
      'Clear Filters',
      name: 'clear_filters',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filters`
  String get apply_filters {
    return Intl.message(
      'Apply Filters',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sort_by {
    return Intl.message('Sort by', name: 'sort_by', desc: '', args: []);
  }

  /// `Most Recent`
  String get most_recent {
    return Intl.message('Most Recent', name: 'most_recent', desc: '', args: []);
  }

  /// `Lowest Price`
  String get lowest_price {
    return Intl.message(
      'Lowest Price',
      name: 'lowest_price',
      desc: '',
      args: [],
    );
  }

  /// `Highest Price`
  String get highest_price {
    return Intl.message(
      'Highest Price',
      name: 'highest_price',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message('My Orders', name: 'my_orders', desc: '', args: []);
  }

  /// `Confirm Order`
  String get confirm_order {
    return Intl.message(
      'Confirm Order',
      name: 'confirm_order',
      desc: '',
      args: [],
    );
  }

  /// `Order Confirmed`
  String get order_confirmed {
    return Intl.message(
      'Order Confirmed',
      name: 'order_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get order_status {
    return Intl.message(
      'Order Status',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Payment Process`
  String get payment_process {
    return Intl.message(
      'Payment Process',
      name: 'payment_process',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get the_address {
    return Intl.message('Address', name: 'the_address', desc: '', args: []);
  }

  /// `Delivery to`
  String get delivery_to {
    return Intl.message('Delivery to', name: 'delivery_to', desc: '', args: []);
  }

  /// `No address found`
  String get no_address_found {
    return Intl.message(
      'No address found',
      name: 'no_address_found',
      desc: '',
      args: [],
    );
  }

  /// `No orders found`
  String get no_orders_found {
    return Intl.message(
      'No orders found',
      name: 'no_orders_found',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Confirm and Pay`
  String get confirm_and_pay {
    return Intl.message(
      'Confirm and Pay',
      name: 'confirm_and_pay',
      desc: '',
      args: [],
    );
  }

  /// `Choose Delivery Method`
  String get choose_delivery_method {
    return Intl.message(
      'Choose Delivery Method',
      name: 'choose_delivery_method',
      desc: '',
      args: [],
    );
  }

  /// `Standard Delivery`
  String get standard_delivery {
    return Intl.message(
      'Standard Delivery',
      name: 'standard_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Express Delivery`
  String get express_delivery {
    return Intl.message(
      'Express Delivery',
      name: 'express_delivery',
      desc: '',
      args: [],
    );
  }

  /// `business days`
  String get business_days {
    return Intl.message(
      'business days',
      name: 'business_days',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message('Order', name: 'order', desc: '', args: []);
  }

  /// `Number`
  String get number {
    return Intl.message('Number', name: 'number', desc: '', args: []);
  }

  /// `Order created successfully`
  String get order_created_successfully {
    return Intl.message(
      'Order created successfully',
      name: 'order_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error creating order, please try again`
  String get error_creating_order {
    return Intl.message(
      'Error creating order, please try again',
      name: 'error_creating_order',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `filter by price`
  String get filter_by_price {
    return Intl.message(
      'filter by price',
      name: 'filter_by_price',
      desc: '',
      args: [],
    );
  }

  /// `Sort by name`
  String get sort_by_name {
    return Intl.message(
      'Sort by name',
      name: 'sort_by_name',
      desc: '',
      args: [],
    );
  }

  /// `Min Price`
  String get min_price {
    return Intl.message('Min Price', name: 'min_price', desc: '', args: []);
  }

  /// `Max Price`
  String get max_price {
    return Intl.message('Max Price', name: 'max_price', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Please enter a valid value`
  String get please_enter_a_valid_value {
    return Intl.message(
      'Please enter a valid value',
      name: 'please_enter_a_valid_value',
      desc: '',
      args: [],
    );
  }

  /// `Max must be greater than min`
  String get max_must_be_greater_than_min {
    return Intl.message(
      'Max must be greater than min',
      name: 'max_must_be_greater_than_min',
      desc: '',
      args: [],
    );
  }

  /// `Sort by rating`
  String get sort_by_rating {
    return Intl.message(
      'Sort by rating',
      name: 'sort_by_rating',
      desc: '',
      args: [],
    );
  }

  /// `Sort price low to high`
  String get sort_price_low_to_high {
    return Intl.message(
      'Sort price low to high',
      name: 'sort_price_low_to_high',
      desc: '',
      args: [],
    );
  }

  /// `Sort price high to low`
  String get sort_price_high_to_low {
    return Intl.message(
      'Sort price high to low',
      name: 'sort_price_high_to_low',
      desc: '',
      args: [],
    );
  }

  /// `Shop by Category`
  String get shop_by_category {
    return Intl.message(
      'Shop by Category',
      name: 'shop_by_category',
      desc: '',
      args: [],
    );
  }

  /// `Shop by Brand`
  String get shop_by_brand {
    return Intl.message(
      'Shop by Brand',
      name: 'shop_by_brand',
      desc: '',
      args: [],
    );
  }

  /// `Recommended for you`
  String get recommended_for_you {
    return Intl.message(
      'Recommended for you',
      name: 'recommended_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message('Recommended', name: 'recommended', desc: '', args: []);
  }

  /// `Too many requests, please try again later`
  String get too_many_requests {
    return Intl.message(
      'Too many requests, please try again later',
      name: 'too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `It seems that the internet connection is currently unavailable 📡. Please try again once the connection is restored.`
  String get lost_connection {
    return Intl.message(
      'It seems that the internet connection is currently unavailable 📡. Please try again once the connection is restored.',
      name: 'lost_connection',
      desc: '',
      args: [],
    );
  }

  /// `Start speaking to search...`
  String get start_speaking {
    return Intl.message(
      'Start speaking to search...',
      name: 'start_speaking',
      desc: '',
      args: [],
    );
  }

  /// `Search by voice`
  String get search_by_voice {
    return Intl.message(
      'Search by voice',
      name: 'search_by_voice',
      desc: '',
      args: [],
    );
  }

  /// `Tap to speak`
  String get tap_to_speak {
    return Intl.message(
      'Tap to speak',
      name: 'tap_to_speak',
      desc: '',
      args: [],
    );
  }

  /// `Listening...`
  String get Listening {
    return Intl.message('Listening...', name: 'Listening', desc: '', args: []);
  }

  /// `Too many requests`
  String get too_many_requests2 {
    return Intl.message(
      'Too many requests',
      name: 'too_many_requests2',
      desc: '',
      args: [],
    );
  }

  /// `You are sending too many requests, Please wait a few seconds and try again.`
  String get you_are_sending_too_many_requests {
    return Intl.message(
      'You are sending too many requests, Please wait a few seconds and try again.',
      name: 'you_are_sending_too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Try again`
  String get try_again {
    return Intl.message('Try again', name: 'try_again', desc: '', args: []);
  }

  /// `Need help? Contact support`
  String get need_help {
    return Intl.message(
      'Need help? Contact support',
      name: 'need_help',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again later.`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong, please try again later.',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `We encountered an unexpected issue. Please try again or return to the home page.`
  String get error_description {
    return Intl.message(
      'We encountered an unexpected issue. Please try again or return to the home page.',
      name: 'error_description',
      desc: '',
      args: [],
    );
  }

  /// `Try using different keywords or browsing categories`
  String get try_different_search {
    return Intl.message(
      'Try using different keywords or browsing categories',
      name: 'try_different_search',
      desc: '',
      args: [],
    );
  }

  /// `Please add an address to proceed.`
  String get empty_address {
    return Intl.message(
      'Please add an address to proceed.',
      name: 'empty_address',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get coninue_shopping {
    return Intl.message(
      'Continue Shopping',
      name: 'coninue_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your order! Your order has been successfully placed and is being processed. You will receive a confirmation email shortly.`
  String get order_confirmed_desc {
    return Intl.message(
      'Thank you for your order! Your order has been successfully placed and is being processed. You will receive a confirmation email shortly.',
      name: 'order_confirmed_desc',
      desc: '',
      args: [],
    );
  }

  /// `Order Confirmed`
  String get order_confirmed_title {
    return Intl.message(
      'Order Confirmed',
      name: 'order_confirmed_title',
      desc: '',
      args: [],
    );
  }

  /// `Track Your Order`
  String get track_your_order {
    return Intl.message(
      'Track Your Order',
      name: 'track_your_order',
      desc: '',
      args: [],
    );
  }

  /// `Have any questions? Reach directly to our `
  String get have_questions {
    return Intl.message(
      'Have any questions? Reach directly to our ',
      name: 'have_questions',
      desc: '',
      args: [],
    );
  }

  /// `support team`
  String get support_team {
    return Intl.message(
      'support team',
      name: 'support_team',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `Product Added Successfully!`
  String get product_added_successfully {
    return Intl.message(
      'Product Added Successfully!',
      name: 'product_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `What would you like to do next?`
  String get what_would_you_like_to_do_next {
    return Intl.message(
      'What would you like to do next?',
      name: 'what_would_you_like_to_do_next',
      desc: '',
      args: [],
    );
  }

  /// `Go to Cart`
  String get go_to_cart {
    return Intl.message('Go to Cart', name: 'go_to_cart', desc: '', args: []);
  }

  /// `Continue Shopping`
  String get continue_shopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continue_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Overall Rating`
  String get overall_rating {
    return Intl.message(
      'Overall Rating',
      name: 'overall_rating',
      desc: '',
      args: [],
    );
  }

  /// `Based on`
  String get based_on {
    return Intl.message('Based on', name: 'based_on', desc: '', args: []);
  }

  /// `All Reviews`
  String get all_reviews {
    return Intl.message('All Reviews', name: 'all_reviews', desc: '', args: []);
  }

  /// `Anonymous User`
  String get anonymous_user {
    return Intl.message(
      'Anonymous User',
      name: 'anonymous_user',
      desc: '',
      args: [],
    );
  }

  /// `No reviews yet`
  String get no_reviews_yet {
    return Intl.message(
      'No reviews yet',
      name: 'no_reviews_yet',
      desc: '',
      args: [],
    );
  }

  /// `Be the first to review this product`
  String get be_first_to_review {
    return Intl.message(
      'Be the first to review this product',
      name: 'be_first_to_review',
      desc: '',
      args: [],
    );
  }

  /// `Product Reviews`
  String get product_reviews {
    return Intl.message(
      'Product Reviews',
      name: 'product_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Write a Review`
  String get write_a_review {
    return Intl.message(
      'Write a Review',
      name: 'write_a_review',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get add_review {
    return Intl.message('Add Review', name: 'add_review', desc: '', args: []);
  }

  /// `Reviewing Product`
  String get reviewing_product {
    return Intl.message(
      'Reviewing Product',
      name: 'reviewing_product',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get product_name {
    return Intl.message(
      'Product Name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Tap to rate`
  String get tap_to_rate {
    return Intl.message('Tap to rate', name: 'tap_to_rate', desc: '', args: []);
  }

  /// `Please select a rating`
  String get please_select_rating {
    return Intl.message(
      'Please select a rating',
      name: 'please_select_rating',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get your_name {
    return Intl.message('Your Name', name: 'your_name', desc: '', args: []);
  }

  /// `Optional`
  String get optional {
    return Intl.message('Optional', name: 'optional', desc: '', args: []);
  }

  /// `Your Review`
  String get your_review {
    return Intl.message('Your Review', name: 'your_review', desc: '', args: []);
  }

  /// `Please enter your review`
  String get please_enter_review {
    return Intl.message(
      'Please enter your review',
      name: 'please_enter_review',
      desc: '',
      args: [],
    );
  }

  /// `Review is too short, please write at least 10 characters`
  String get review_too_short {
    return Intl.message(
      'Review is too short, please write at least 10 characters',
      name: 'review_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Share your experience with this product`
  String get share_your_experience {
    return Intl.message(
      'Share your experience with this product',
      name: 'share_your_experience',
      desc: '',
      args: [],
    );
  }

  /// `Submit Review`
  String get submit_review {
    return Intl.message(
      'Submit Review',
      name: 'submit_review',
      desc: '',
      args: [],
    );
  }

  /// `Poor`
  String get poor {
    return Intl.message('Poor', name: 'poor', desc: '', args: []);
  }

  /// `Fair`
  String get fair {
    return Intl.message('Fair', name: 'fair', desc: '', args: []);
  }

  /// `Good`
  String get good {
    return Intl.message('Good', name: 'good', desc: '', args: []);
  }

  /// `Very Good`
  String get very_good {
    return Intl.message('Very Good', name: 'very_good', desc: '', args: []);
  }

  /// `Excellent`
  String get excellent {
    return Intl.message('Excellent', name: 'excellent', desc: '', args: []);
  }

  /// `Please select a rating to submit your review`
  String get please_select_rating_2 {
    return Intl.message(
      'Please select a rating to submit your review',
      name: 'please_select_rating_2',
      desc: '',
      args: [],
    );
  }

  /// `Review submitted successfully`
  String get review_submitted_successfully {
    return Intl.message(
      'Review submitted successfully',
      name: 'review_submitted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to submit review, please try again`
  String get failed_to_submit_review {
    return Intl.message(
      'Failed to submit review, please try again',
      name: 'failed_to_submit_review',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Review is too long, please limit it to 50 characters`
  String get review_too_long {
    return Intl.message(
      'Review is too long, please limit it to 50 characters',
      name: 'review_too_long',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet`
  String get no_notifications_yet {
    return Intl.message(
      'No notifications yet',
      name: 'no_notifications_yet',
      desc: '',
      args: [],
    );
  }

  /// `You will receive notifications about your orders, products, and more here.`
  String get notification_empty_message {
    return Intl.message(
      'You will receive notifications about your orders, products, and more here.',
      name: 'notification_empty_message',
      desc: '',
      args: [],
    );
  }

  /// `minutes ago`
  String get minutes_ago {
    return Intl.message('minutes ago', name: 'minutes_ago', desc: '', args: []);
  }

  /// `hours ago`
  String get hours_ago {
    return Intl.message('hours ago', name: 'hours_ago', desc: '', args: []);
  }

  /// `days ago`
  String get days_ago {
    return Intl.message('days ago', name: 'days_ago', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Just now`
  String get just_now {
    return Intl.message('Just now', name: 'just_now', desc: '', args: []);
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

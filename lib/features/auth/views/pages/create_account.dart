import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/core/widgets/my_or_devider.dart';
import 'package:e_commerce_graduation/core/widgets/my_text_form_field.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/auth/background1.svg',
              height: size.height * 0.5,
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: size.height * 0.07,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    S.of(context).sign_up,
                    style: FontHelper.fontText(
                        size: 36, weight: FontWeight.w900, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${S.of(context).already_have_an_account} ${S.of(context).login}',
                    style: FontHelper.fontText(
                        size: 12, weight: FontWeight.w900, color: Colors.white),
                  ),
                ],
              )),
          Positioned(
            top: size.height * 0.18,
            left: 0,
            right: 0,
            bottom: size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Container(
                width: size.width,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyTextFormField(
                              width: size.width * 0.39,
                              hint: S.of(context).first_name,
                            ),
                            MyTextFormField(
                              width: size.width * 0.39,
                              hint: S.of(context).last_name,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).email,
                        ),
                        SizedBox(height: 16),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).birthday,
                          suffIcon: Iconsax.calendar_1,
                        ),
                        SizedBox(height: 16),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).phone,
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '+20',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 1,
                                height: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).password,
                        ),
                        SizedBox(height: 16),
                        MyTextFormField(
                          width: size.width * 0.8,
                          hint: S.of(context).confirm_password,
                        ),
                        SizedBox(height: 16),
                        MyButton1(
                          buttonTitle: S.of(context).create_account,
                          height: 50,
                          width: size.width * 0.8,
                        ),
                        SizedBox(height: 16),
                        MyOrDevider(size: size.width * 0.02),
                        SizedBox(height: 16),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/auth/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(width: 16),
                                  Text(S.of(context).sign_up_with_google,
                                      style: FontHelper.fontText(
                                          size: 16,
                                          weight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

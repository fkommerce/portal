import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../app.routes.dart';
import '../../../../config/constants.dart';
import '../../../../config/size.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/themes/themes.dart';

class IntroPart extends StatelessWidget {
  const IntroPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainMin,
      crossAxisAlignment: crossStart,
      mainAxisAlignment: mainStart,
      children: [
        Image.asset(
          'assets/icons/app-icon-1024x1024.png',
          height: 80,
          width: 80,
        ),
        const SizedBox(height: defaultPadding / 2),
        RichText(
          text: TextSpan(
            text: 'Fkommerce ',
            style: context.text.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.theme.primaryColor,
            ),
            children: [
              TextSpan(
                text: 'Portal',
                style: context.text.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          'Welcome to Fkommerce! Join us today and revolutionize your business operations. Our comprehensive platform empowers you to manage product sourcing, inventory, customer relations, accounting, and more—all in one convenient place. Unlock your business potential and achieve success with Fkommerce!',
          textAlign: TextAlign.justify,
          style: context.text.bodyMedium?.copyWith(
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        Text(
          '- Powered & developed by Algoramming. An inhouse product of Algoramming. ©2024 All rights reserved.',
          style: context.text.bodyMedium?.copyWith(
            letterSpacing: 1.0,
            fontWeight: FontWeight.w500,
            color: context.theme.dividerColor,
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        RichText(
          text: TextSpan(
            text: 'For any queries or assistance, contact us at ',
            style: context.text.bodyMedium?.copyWith(
              color: context.theme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: 'contact@algoramming.com',
                style: context.text.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    const Shadow(
                      color: kSecondaryColor,
                      offset: Offset(0, -2.5),
                    ),
                  ],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: kSecondaryColor,
                  decorationThickness: 2.5,
                  decorationStyle: TextDecorationStyle.solid,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.beamPush(AppRoutes.registerRoute),
              ),
            ],
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}

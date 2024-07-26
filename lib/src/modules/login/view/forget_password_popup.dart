import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../config/constants.dart';
import '../../../shared/animations_widget/animated_popup.dart';
import '../../../shared/show_toast/awsome_snackbar/awesome_snackbar.dart';
import '../../../shared/show_toast/awsome_snackbar/show_awesome_snackbar.dart';
import '../../../utils/extensions/extensions.dart';

class ForgetPasswordPopup extends StatefulWidget {
  const ForgetPasswordPopup({super.key});

  @override
  State<ForgetPasswordPopup> createState() => _ForgetPasswordPopupState();
}

class _ForgetPasswordPopupState extends State<ForgetPasswordPopup> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Forget Password'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: mainMin,
              children: [
                const Text(
                    'A reset password link will be sent to your email address.'),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: emailCntrlr,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  onFieldSubmitted: (_) async => submit(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Email is required';
                    }
                    if (!v.isEmail) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () async => await submit().then((_) {
              context.pop();
              showAwesomeSnackbar(
                context,
                'Success',
                'A reset password link has been sent to your email address.',
                MessageType.success,
              );
            }),
            child: Text('Send Email',
                style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      await Future.delayed(const Duration(seconds: 5));
      EasyLoading.dismiss();
    }
  }
}

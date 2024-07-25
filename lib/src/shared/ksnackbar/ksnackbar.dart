import 'package:flutter/material.dart';
import 'package:portal/src/config/constants.dart';
import 'package:portal/src/utils/extensions/extensions.dart';

class KSnackbar {
  static hideSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static showSnackBar(
    BuildContext context,
    String content, {
    int second = 4,
    Alignment? alignment,
    TextStyle? contentTextStyle,
  }) {
    hideSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _Content(
          content: content,
          second: second,
          contentTextStyle: contentTextStyle,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: second),
        animation: const AlwaysStoppedAnimation(1.0),
        padding: const EdgeInsets.all(0.0),
        margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
        showCloseIcon: false,
        shape: roundedRectangleBorder5,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    /// Main body message
    required this.content,

    /// default time set 4 seconds.
    required this.second,

    /// default TextStyle is none.
    this.contentTextStyle,
  });

  final String content;
  final int second;
  final TextStyle? contentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (context.isScreenDesktop)
          const Expanded(flex: 2, child: SizedBox.shrink()),
        Expanded(
          flex: context.isScreenDesktop ? 3 : 1,
          child: Card(
            elevation: 5.0,
            shape: roundedRectangleBorder5,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxHeight: 27.0),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0, end: second * 1000.toDouble()),
                      duration: Duration(seconds: second),
                      builder: (context, double value, child) {
                        return Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                value: value / (second * 1000),
                                color: context.theme.primaryColor,
                                backgroundColor: context.theme.cardColor,
                              ),
                            ),
                            Center(
                              child: Text(
                                  (second - (value / 1000)).toInt().toString(),
                                  textScaler: const TextScaler.linear(0.85),
                                  style: contentTextStyle ??
                                      context.text.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w600)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      content,
                      style: contentTextStyle ??
                          context.text.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  InkWell(
                    borderRadius: borderRadius45,
                    onTap: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    child: const Icon(
                      Icons.close,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (context.isScreenDesktop)
          const Expanded(flex: 2, child: SizedBox.shrink()),
      ],
    );
  }
}

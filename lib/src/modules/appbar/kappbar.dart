import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../config/constants.dart';
import '../../config/size.dart';
import 'components/more_section.dart';
import '../../utils/extensions/extensions.dart';

import 'components/branch_selector.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title ?? appName,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.primaryColor,
                ),
              ),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: mainEnd,
                children: [
                  BranchSelector(),
                  SizedBox(width: defaultPadding / 2),
                  MoreSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

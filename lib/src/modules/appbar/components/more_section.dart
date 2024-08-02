import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../config/constants.dart';
import '../../../config/size.dart';
import '../../../shared/riverpod/helper.dart';
import '../../management/provider/management.dart';
import '../../settings/view/basic/signout_tile.dart';

class MoreSection extends ConsumerWidget {
  const MoreSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: borderRadius60,
        border: Border.all(color: context.theme.primaryColor, width: 1.5),
      ),
      child: ref.watch(currentManagementProvider).when(
            error: (e, _) =>
                Text(e.toString(), style: const TextStyle(color: Colors.red)),
            loading: riverpodLoading,
            data: (_) {
              final notifier = ref.read(currentManagementProvider.notifier);
              return PopupMenuButton<String>(
                tooltip: '',
                position: PopupMenuPosition.under,
                offset: const Offset(0, defaultPadding / 2),
                onSelected: (v) async {
                  if (v == 'view-profile') {
                    //
                  } else if (v == 'log-out') {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const SignoutPopup(),
                    );
                  }
                },
                itemBuilder: (_) => <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    value: 'view-profile',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/account-selected.svg',
                          width: 22,
                          height: 22,
                          colorFilter: context.theme.primaryColor.toColorFilter,
                        ),
                        const SizedBox(width: defaultPadding / 2),
                        Text('Profile', style: context.text.titleMedium),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'log-out',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/signout.svg',
                          width: 20,
                          height: 20,
                          colorFilter: Colors.red.toColorFilter,
                        ),
                        const SizedBox(width: defaultPadding / 2),
                        Text('Log out',
                            style: context.text.titleMedium!
                                .copyWith(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                child: ClipRRect(
                  borderRadius: borderRadius60,
                  child: FastCachedImage(
                    key: ValueKey(notifier.management.avatar),
                    url: notifier.management.avatar ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => ClipRRect(
                      borderRadius: borderRadius60,
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}

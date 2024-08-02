import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/size.dart';
import '../../branch/provider/branch.dart';
import '../../../utils/extensions/extensions.dart';

import '../../../config/constants.dart';
import '../../../shared/riverpod/helper.dart';

class BranchSelector extends ConsumerWidget {
  const BranchSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: borderRadius10,
        border: Border.all(color: context.theme.primaryColor, width: 1.5),
      ),
      child: ref.watch(branchProvider).when(
            loading: riverpodLoading,
            error: riverpodError,
            data: (_) {
              final notifier = ref.read(branchProvider.notifier);
              return PopupMenuButton<String>(
                tooltip: '',
                initialValue: notifier.selectedBranch.id,
                position: PopupMenuPosition.under,
                offset: const Offset(0, defaultPadding / 2),
                onSelected: (v) async {},
                itemBuilder: (_) => <PopupMenuEntry<String>>[
                  ...List.generate(
                    notifier.branches.length,
                    (index) => PopupMenuItem(
                      value: notifier.branches[index].id,
                      child: Text(
                        notifier.branches[index].name,
                        style: context.text.titleMedium,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'add-branch',
                    child: Row(
                      children: [
                        const Icon(Icons.add_circle_outline_outlined),
                        const SizedBox(width: defaultPadding / 4),
                        Text('Add Branch', style: context.text.titleMedium),
                      ],
                    ),
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          notifier.selectedBranch.name,
                          style: context.text.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 4),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}

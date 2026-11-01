import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_icon.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';
import 'content_actions.dart';

class PostCard extends ConsumerWidget {
  const PostCard({super.key, required this.post, this.onOpen, this.onDeleted});

  final Post post;

  /// Opens the post. Null on the post's own detail screen.
  final VoidCallback? onOpen;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final repository = ref.read(communityRepositoryProvider);
    final now = ref.read(clockProvider)();
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              MemberAvatar(name: post.authorName),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1,
                  children: [
                    Text(
                      post.authorName ?? l10n.anonymous,
                      style: AppText.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${l10n.topicLabel(post.topic)} · '
                      '${l10n.timeAgo(post.createdAt, now)}',
                      style: AppText.small.copyWith(
                        color: DayColors.textMuted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 130),
                child: _Tag(l10n.feelingTag(post.mood)),
              ),
              Transform.translate(
                offset: const Offset(10, 0),
                child: ContentActionsButton(
                  target: ReportTarget.post,
                  id: post.id,
                  isMine: post.isMine,
                  onDelete: () async {
                    await repository.deletePost(post.id);
                    onDeleted?.call();
                  },
                  onBlocked: onDeleted,
                ),
              ),
            ],
          ),
          if (post.awaitingReview) AwaitingReviewNote(l10n.awaitingReview),
          Text(post.text, style: AppText.bodySmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PostButton(
                icon: AppIcons.heart,
                label: l10n.relateCount(post.relateCount),
                active: post.relatedByMe,
                onTap: () => repository.toggleRelate(post.id),
              ),
              _PostButton(
                icon: AppIcons.comment,
                label: l10n.replyCount(post.replyCount),
                onTap: onOpen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AwaitingReviewNote extends StatelessWidget {
  const AwaitingReviewNote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: DayColors.warnBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: AppText.small.copyWith(color: DayColors.warnText),
      ),
    );
  }
}

class MemberAvatar extends StatelessWidget {
  const MemberAvatar({super.key, required this.name});

  /// Null when the member is anonymous.
  final String? name;

  static const _colours = [
    (DayColors.selectedTile, DayColors.primary),
    (DayColors.successBg, DayColors.successText),
  ];

  String get _initials {
    final parts = name!.trim().split(RegExp(r'\s+'));
    return parts
        .take(2)
        .map((part) => part.characters.first.toUpperCase())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = name == null
        ? (DayColors.warnBg, DayColors.warnText)
        : _colours[name!.codeUnits.fold(0, (a, b) => a + b) % _colours.length];
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: background),
      child: Text(
        name == null ? '?' : _initials,
        style: AppText.bodySmall.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: DayColors.tagBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: AppText.small.copyWith(
          color: DayColors.textBody,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PostButton extends StatelessWidget {
  const _PostButton({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final AppIcons icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = active ? DayColors.primary : DayColors.textBody;
    return Semantics(
      button: true,
      selected: active,
      child: Material(
        color: active ? DayColors.selectedTile : DayColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: DayColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 36),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  AppIcon(icon, size: 18, color: foreground),
                  Text(label, style: AppText.chip.copyWith(color: foreground)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

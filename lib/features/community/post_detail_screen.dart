import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/state_views.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';
import 'content_actions.dart';
import 'post_card.dart';

/// No wireframe. Built from the post card on screen 02.
class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _reply = TextEditingController();
  var _sending = false;

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _reply.text.trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final outcome = await ref
        .read(communityRepositoryProvider)
        .createReply(widget.postId, text);
    if (!mounted) return;
    if (outcome == PublishOutcome.heldForReview) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.postHeld)));
    }
    _reply.clear();
    setState(() => _sending = false);
  }

  void _leave() {
    if (mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final posts = ref.watch(postsProvider);
    final replies = ref.watch(repliesProvider(widget.postId));
    final post = posts.value
        ?.where((post) => post.id == widget.postId)
        .firstOrNull;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: l10n.actionBack,
                  onPressed: _leave,
                  icon: const AppIcon(AppIcons.back),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSizes.screenPadding),
                children: [
                  if (post != null) ...[
                    PostCard(post: post, onDeleted: _leave),
                    const SizedBox(height: 12),
                    const CautionText(),
                    const SizedBox(height: 16),
                    ...replies.when(
                      loading: () => const [LoadingView()],
                      error: (_, _) => [
                        ErrorView(
                          onRetry: () =>
                              ref.invalidate(repliesProvider(widget.postId)),
                        ),
                      ],
                      data: (items) => items.isEmpty
                          ? [
                              EmptyView(
                                title: l10n.repliesEmptyTitle,
                                body: l10n.repliesEmptyBody,
                              ),
                            ]
                          : [
                              for (final reply in items)
                                _ReplyRow(reply: reply),
                            ],
                    ),
                  ] else if (posts.isLoading)
                    const LoadingView()
                  else
                    EmptyView(
                      title: l10n.postGoneTitle,
                      body: l10n.postGoneBody,
                    ),
                ],
              ),
            ),
            if (post != null)
              Container(
                decoration: const BoxDecoration(
                  color: DayColors.surface,
                  border: Border(top: BorderSide(color: DayColors.border)),
                ),
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _reply,
                        hint: l10n.replyHint,
                        maxLines: 4,
                        minLines: 1,
                        maxLength: 500,
                        borderColor: DayColors.borderStrong,
                      ),
                    ),
                    IconButton.filled(
                      tooltip: l10n.replySend,
                      onPressed: _sending ? null : _send,
                      style: IconButton.styleFrom(
                        backgroundColor: DayColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.arrow_upward),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReplyRow extends ConsumerWidget {
  const _ReplyRow({required this.reply});

  final Reply reply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = ref.read(clockProvider)();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          MemberAvatar(name: reply.authorName),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  '${reply.authorName} · ${l10n.timeAgo(reply.createdAt, now)}',
                  style: AppText.small.copyWith(
                    color: DayColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (reply.awaitingReview)
                  AwaitingReviewNote(l10n.awaitingReview),
                Text(reply.text, style: AppText.bodySmall),
              ],
            ),
          ),
          ContentActionsButton(
            target: ReportTarget.reply,
            id: reply.id,
            isMine: reply.isMine,
            onDelete: () =>
                ref.read(communityRepositoryProvider).deleteReply(reply.id),
          ),
        ],
      ),
    );
  }
}

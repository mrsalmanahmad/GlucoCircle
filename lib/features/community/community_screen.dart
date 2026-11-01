import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_chip.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/caution_text.dart';
import '../../core/widgets/page_header.dart';
import '../../core/widgets/round_icon_button.dart';
import '../../core/widgets/state_views.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../data/session_controller.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';
import 'post_card.dart';

/// Screen 02.
class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  /// Null means All. If someone follows exactly one topic, start on it.
  late Topic? _topic = () {
    final topics = (ref.read(sessionProvider)?.interests ?? const <Interest>{})
        .map((interest) => interest.topic)
        .nonNulls
        .toSet();
    return topics.length == 1 ? topics.first : null;
  }();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final posts = ref.watch(postsProvider);
    return Scaffold(
      floatingActionButton: _ShareStoryButton(
        label: l10n.communityShareStory,
        onPressed: () => context.push(Routes.share),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.screenPadding,
                AppSizes.screenPadding,
                AppSizes.screenPadding,
                0,
              ),
              sliver: SliverToBoxAdapter(
                child: PageHeader(
                  title: l10n.communityTitle,
                  subtitle: l10n.communitySubtitle,
                  actions: [
                    RoundIconButton(
                      icon: AppIcons.settings,
                      label: l10n.settingsTitle,
                      onPressed: () => context.push(Routes.settings),
                    ),
                    RoundIconButton(
                      icon: AppIcons.bell,
                      label: l10n.notificationsTitle,
                      onPressed: () => context.push(Routes.notifications),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.screenPadding,
                  8,
                  AppSizes.screenPadding,
                  4,
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    AppChip(
                      label: l10n.topicAll,
                      selected: _topic == null,
                      onTap: () => setState(() => _topic = null),
                    ),
                    for (final topic in Topic.values)
                      AppChip(
                        label: l10n.topicLabel(topic),
                        selected: _topic == topic,
                        onTap: () => setState(() => _topic = topic),
                      ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPadding,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    _FirefliesBanner(
                      onTap: () => context.push(Routes.fireflies),
                    ),
                    const CautionText(),
                    const SizedBox(height: 0),
                  ],
                ),
              ),
            ),
            ...posts.when(
              loading: () => const [SliverToBoxAdapter(child: LoadingView())],
              error: (_, _) => [
                SliverToBoxAdapter(
                  child: ErrorView(
                    onRetry: () => ref.invalidate(postsProvider),
                  ),
                ),
              ],
              data: _feed,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _feed(List<Post> all) {
    final l10n = AppLocalizations.of(context);
    final posts = _topic == null
        ? all
        : all.where((post) => post.topic == _topic).toList();
    if (posts.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: _topic == null
              ? EmptyView(title: l10n.feedEmptyTitle, body: l10n.feedEmptyBody)
              : EmptyView(
                  title: l10n.feedEmptyTopicTitle,
                  body: l10n.feedEmptyBody,
                ),
        ),
      ];
    }
    return [
      SliverPadding(
        // Space so the floating button doesn't cover the last post.
        padding: const EdgeInsets.fromLTRB(
          AppSizes.screenPadding,
          0,
          AppSizes.screenPadding,
          88,
        ),
        sliver: SliverList.separated(
          itemCount: posts.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCard(
              post: post,
              onOpen: () => context.push(Routes.post(post.id)),
            );
          },
        ),
      ),
    ];
  }
}

class _FirefliesBanner extends StatelessWidget {
  const _FirefliesBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: NightColors.background,
      borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            spacing: 14,
            children: [
              const _BannerSky(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      l10n.firefliesBannerTitle,
                      style: AppText.rowTitle.copyWith(
                        color: NightColors.cream,
                      ),
                    ),
                    Text(
                      l10n.firefliesBannerBody,
                      style: AppText.chip.copyWith(
                        color: NightColors.sub,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const AppIcon(
                AppIcons.chevronRight,
                size: 20,
                color: NightColors.glow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerSky extends StatelessWidget {
  const _BannerSky();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.minTapTarget,
      height: AppSizes.minTapTarget,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NightColors.surface,
      ),
      child: const Stack(
        children: [
          Positioned(left: 10, top: 12, child: _Dot(size: 8)),
          Positioned(left: 26, top: 20, child: _Dot(size: 6)),
          Positioned(left: 16, top: 28, child: _Dot(size: 5)),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NightColors.glow,
        boxShadow: [
          BoxShadow(color: Color(0x8CFFC857), blurRadius: 8, spreadRadius: 3),
        ],
      ),
    );
  }
}

class _ShareStoryButton extends StatelessWidget {
  const _ShareStoryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.floatingButtonHeight / 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D1E4FD8),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: palette.accent,
          foregroundColor: palette.onAccent,
          minimumSize: const Size(0, AppSizes.floatingButtonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          textStyle: AppText.rowTitle,
        ),
        icon: const Icon(Icons.add, size: 20),
        label: Text(label),
      ),
    );
  }
}

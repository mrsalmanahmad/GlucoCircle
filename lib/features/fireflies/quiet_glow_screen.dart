import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/firefly_glow.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/state_views.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../community/content_actions.dart';
import 'fireflies_refresh.dart';

/// Screen 12, Lite: warmth only, with no way to start a chat.
class QuietGlowScreen extends StatelessWidget {
  const QuietGlowScreen({super.key});

  @override
  Widget build(BuildContext context) => const NightMood(child: _Body());
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> with FirefliesRefresh {
  static const _sparks = [
    Alignment(-0.52, -0.56),
    Alignment(0.44, -0.4),
    Alignment(-0.4, 0.48),
    Alignment(0.36, 0.4),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final myGlow = ref.watch(myGlowProvider);
    final now = ref.read(clockProvider)();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.screenPadding,
            8,
            AppSizes.screenPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 18,
            children: [
              Row(
                children: [
                  Transform.translate(
                    offset: const Offset(-10, 0),
                    child: IconButton(
                      tooltip: l10n.actionBack,
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const AppIcon(AppIcons.back),
                    ),
                  ),
                  const Spacer(),
                  if (myGlow.value case final current?)
                    Text(
                      l10n.glowingTimeLeft(
                        current.glow.expiresAt.difference(now).inMinutes + 1,
                      ),
                      style: AppText.chip.copyWith(color: NightColors.muted),
                    ),
                ],
              ),
              ...myGlow.when(
                loading: () => const [LoadingView()],
                error: (_, _) => [
                  ErrorView(onRetry: () => ref.invalidate(myGlowProvider)),
                ],
                data: (current) => current == null
                    ? _faded(l10n)
                    : _glowing(l10n, current, now),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _faded(AppLocalizations l10n) {
    return [
      EmptyView(title: l10n.glowFadedTitle, body: l10n.glowFadedBody),
      PrimaryButton(
        label: l10n.actionDone,
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    ];
  }

  List<Widget> _glowing(AppLocalizations l10n, MyGlow current, DateTime now) {
    final warmth = current.warmth;
    return [
      SizedBox(
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const _Ring(),
            const _Ring(startAt: 0.5),
            const FireflyGlow(size: 34),
            // One spark for each person who sent warmth, up to four.
            for (final spark in _sparks.take(warmth.length))
              Align(alignment: spark, child: const FireflyGlow(size: 6)),
          ],
        ),
      ),
      Column(
        spacing: 6,
        children: [
          Text(
            l10n.quietTitle,
            textAlign: TextAlign.center,
            style: AppText.nightHeading,
          ),
          Text(
            l10n.quietBody,
            textAlign: TextAlign.center,
            style: AppText.bodySmall.copyWith(color: NightColors.sub),
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 10),
        decoration: BoxDecoration(
          color: NightColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          border: Border.all(color: NightColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 4,
          children: [
            Text(
              warmth.isEmpty
                  ? l10n.quietNoWarmth
                  : l10n.quietWarmthCount(warmth.length),
              style: AppText.rowTitle,
            ),
            for (final warm in warmth) _WarmthRow(warm: warm, now: now),
          ],
        ),
      ),
      OutlinedButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          await ref.read(firefliesRepositoryProvider).dimMyGlow();
          navigator.maybePop();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: NightColors.chipText,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: NightColors.border),
          textStyle: AppText.rowTitle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        child: Text(l10n.quietDim),
      ),
    ];
  }
}

/// Ripples out from the glow: scale 0.6 to 1.6 while fading, every 3.6 s.
class _Ring extends StatefulWidget {
  const _Ring({this.startAt = 0});

  /// Where in the ripple to begin, so two rings don't move together.
  final double startAt;

  @override
  State<_Ring> createState() => _RingState();
}

class _RingState extends State<_Ring> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3600),
    value: widget.startAt,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = widget.startAt;
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = Curves.easeOut.transform(_controller.value);
        return Opacity(
          opacity: 0.7 * (1 - value),
          child: Transform.scale(scale: 0.6 + value, child: child),
        );
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0x99FFC857)),
        ),
      ),
    );
  }
}

class _WarmthRow extends ConsumerWidget {
  const _WarmthRow({required this.warm, required this.now});

  final Warmth warm;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Row(
        spacing: 12,
        children: [
          const FireflyGlow(size: 8, animate: false),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1,
              children: [
                Text(
                  warm.nickname,
                  style: AppText.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  warm.country,
                  style: AppText.small.copyWith(
                    color: NightColors.muted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: warm.glowedBack
                ? null
                : () => ref.read(firefliesRepositoryProvider).glowBack(warm.id),
            style: OutlinedButton.styleFrom(
              foregroundColor: NightColors.glowLight,
              disabledForegroundColor: NightColors.onGlow,
              disabledBackgroundColor: NightColors.glow,
              minimumSize: const Size(0, 36),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              side: const BorderSide(color: Color(0xFF5A4A20)),
              textStyle: AppText.small.copyWith(fontWeight: FontWeight.w700),
            ),
            child: Text(warm.glowedBack ? l10n.warmthSent : l10n.quietGlowBack),
          ),
          ContentActionsButton(
            target: ReportTarget.warmth,
            id: warm.id,
            isMine: false,
            color: NightColors.muted,
          ),
        ],
      ),
    );
  }
}

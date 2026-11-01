import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_chip.dart';
import '../../core/widgets/app_icon.dart';
import '../../core/widgets/firefly_glow.dart';
import '../../core/widgets/state_views.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';
import '../community/content_actions.dart';
import 'fireflies_refresh.dart';

/// Screen 09, Lite: real glows and warmth only. No chat, no constellations.
class FirefliesScreen extends StatelessWidget {
  const FirefliesScreen({super.key});

  @override
  Widget build(BuildContext context) => const NightMood(child: _Body());
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> with FirefliesRefresh {
  GlowFeeling? _filter;
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final glows = ref.watch(glowsProvider);
    final myGlow = ref.watch(myGlowProvider).value;
    final now = ref.read(clockProvider)();
    final visible = (glows.value ?? const <Glow>[])
        .where((glow) => _filter == null || glow.feeling == _filter)
        .toList();
    final selected =
        visible.where((glow) => glow.id == _selectedId).firstOrNull ??
        visible.firstOrNull;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.screenPadding,
                      ),
                      child: _Header(
                        now: now,
                        count: glows.value == null ? null : visible.length,
                        anyFilter: _filter != null,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.screenPadding,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          AppChip(
                            label: l10n.topicAll,
                            selected: _filter == null,
                            onTap: () => setState(() => _filter = null),
                          ),
                          for (final feeling in GlowFeeling.values)
                            AppChip(
                              label: l10n.glowFeelingLabel(feeling),
                              selected: _filter == feeling,
                              onTap: () => setState(() => _filter = feeling),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.screenPadding,
                      ),
                      child: Text(
                        l10n.skyLegend,
                        style: AppText.small.copyWith(
                          color: NightColors.muted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    if (glows.hasError)
                      ErrorView(onRetry: () => ref.invalidate(glowsProvider))
                    else
                      _Sky(
                        glows: visible,
                        selectedId: selected?.id,
                        now: now,
                        onSelect: (id) => setState(() => _selectedId = id),
                      ),
                    if (selected != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: _PersonCard(
                          key: ValueKey(selected.id),
                          glow: selected,
                          now: now,
                          onNext: visible.length < 2
                              ? null
                              : () {
                                  final next =
                                      (visible.indexOf(selected) + 1) %
                                      visible.length;
                                  setState(
                                    () => _selectedId = visible[next].id,
                                  );
                                },
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: _LightButton(
                label: myGlow == null ? l10n.lightMyGlow : l10n.seeMyGlow,
                onTap: () => context.push(
                  myGlow == null ? Routes.lightGlow : Routes.quietGlow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.now,
    required this.count,
    required this.anyFilter,
  });

  final DateTime now;

  /// Null while loading.
  final int? count;
  final bool anyFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final time = MaterialLocalizations.of(context)
        .formatTimeOfDay(TimeOfDay.fromDateTime(now));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
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
            Text(
              '$time · $launchCountry',
              style: AppText.small.copyWith(
                color: NightColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(l10n.firefliesTitle, style: AppText.nightTitle),
        if (count != null)
          Text(
            // Real counts only. See issue S5 in docs/wireframes/README.md.
            switch ((count!, anyFilter)) {
              (0, false) => l10n.skyEmptyAll,
              (0, true) => l10n.skyEmptyFilter,
              _ => l10n.skyCount(count!),
            },
            style: AppText.body.copyWith(color: NightColors.sub),
          ),
      ],
    );
  }
}

class _Sky extends StatefulWidget {
  const _Sky({
    required this.glows,
    required this.selectedId,
    required this.now,
    required this.onSelect,
  });

  final List<Glow> glows;
  final String? selectedId;
  final DateTime now;
  final ValueChanged<String> onSelect;

  @override
  State<_Sky> createState() => _SkyState();
}

class _SkyState extends State<_Sky> with SingleTickerProviderStateMixin {
  static const _height = 270.0;

  // Where the wireframe places people, as fractions of the sky.
  static const _slots = [
    Alignment(-0.56, -0.64),
    Alignment(0.36, -0.76),
    Alignment(-0.2, -0.8),
    Alignment(0.68, -0.48),
    Alignment(0.08, -0.04),
    Alignment(-0.76, 0.16),
    Alignment(-0.36, 0.56),
    Alignment(0.32, 0.72),
    Alignment(0.76, 0.44),
  ];

  late final _drift = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 24),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _drift.stop();
    } else {
      _drift.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: -160,
            right: -160,
            top: 236,
            height: 700,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: NightColors.horizon,
                shape: OvalBorder(
                  side: BorderSide(color: NightColors.horizonBorder),
                ),
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: _StarsPainter())),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _drift,
              builder: (context, child) => Transform.translate(
                offset: Offset(6 - 12 * _drift.value, 0),
                child: child,
              ),
              child: Stack(
                children: [
                  for (final (index, glow) in widget.glows.indexed)
                    Align(
                      alignment: _slots[index % _slots.length],
                      child: _Firefly(
                        glow: glow,
                        selected: glow.id == widget.selectedId,
                        delay: Duration(milliseconds: index * 450),
                        now: widget.now,
                        onTap: () => widget.onSelect(glow.id),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Firefly extends StatelessWidget {
  const _Firefly({
    required this.glow,
    required this.selected,
    required this.delay,
    required this.now,
    required this.onTap,
  });

  final Glow glow;
  final bool selected;
  final Duration delay;
  final DateTime now;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final waited = now.difference(glow.startedAt).inMinutes;
    // Brighter and bigger means waiting longer. Formula from the wireframe.
    final size = (8 + (waited / 4).round()).clamp(8, 20).toDouble();
    final opacity = (0.55 + waited.clamp(0, 50) / 110).clamp(0.0, 1.0);
    return Semantics(
      button: true,
      selected: selected,
      label: '${glow.nickname}, ${l10n.glowFeelingLabel(glow.feeling)}',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox.square(
          dimension: 52,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: selected
                        ? const Color(0xF2FFC857)
                        : Colors.transparent,
                  ),
                ),
              ),
              Opacity(
                opacity: opacity,
                child: FireflyGlow(size: size, delay: delay),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (var k = 0; k < 18; k++) {
      final x = ((k * 37 + 11) % 97) / 100 * size.width;
      final y = ((k * 53 + 7) % 92) / 100 * size.height;
      final opacity = 0.25 + ((k * 7) % 5) * 0.12;
      canvas.drawCircle(
        Offset(x, y),
        1,
        Paint()..color = NightColors.hint.withValues(alpha: opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter oldDelegate) => false;
}

class _PersonCard extends ConsumerWidget {
  const _PersonCard({
    super.key,
    required this.glow,
    required this.now,
    required this.onNext,
  });

  final Glow glow;
  final DateTime now;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return _CardPop(
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
        decoration: BoxDecoration(
          color: NightColors.cream,
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [
            BoxShadow(
              color: Color(0x73000000),
              offset: Offset(0, 18),
              blurRadius: 40,
            ),
          ],
        ),
        child: DefaultTextStyle.merge(
          style: const TextStyle(color: NightColors.cardInk),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 1,
                      children: [
                        Text(
                          glow.nickname,
                          style: AppText.cardTitle.copyWith(
                            fontWeight: FontWeight.w800,
                            color: NightColors.cardInk,
                          ),
                        ),
                        Text(
                          l10n.glowMeta(
                            glow.country,
                            now.difference(glow.startedAt).inMinutes,
                          ),
                          style: AppText.small.copyWith(
                            color: DayColors.textMuted,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9B8),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      l10n.glowFeelingLabel(glow.feeling),
                      style: AppText.small.copyWith(
                        color: const Color(0xFF6B4300),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(8, 0),
                    child: ContentActionsButton(
                      target: ReportTarget.glow,
                      id: glow.id,
                      isMine: false,
                      color: NightColors.cardInk,
                    ),
                  ),
                ],
              ),
              if (glow.line.isNotEmpty)
                Text(
                  '“${glow.line}”',
                  style: AppText.quote.copyWith(color: NightColors.cardInk),
                ),
              Row(
                spacing: 8,
                children: [
                  if (onNext != null)
                    SizedBox.square(
                      dimension: 50,
                      child: OutlinedButton(
                        onPressed: onNext,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: const BorderSide(color: Color(0xFFC9CBD8)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Semantics(
                          label: l10n.skyNext,
                          child: const AppIcon(
                            AppIcons.chevronRight,
                            color: NightColors.cardInk,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: FilledButton(
                      onPressed: glow.warmedByMe
                          ? null
                          : () => ref
                                .read(firefliesRepositoryProvider)
                                .sendWarmth(glow.id),
                      style: FilledButton.styleFrom(
                        backgroundColor: NightColors.cardInk,
                        foregroundColor: NightColors.glow,
                        disabledBackgroundColor: const Color(0xFFFFE9B8),
                        disabledForegroundColor: NightColors.cardInk,
                        minimumSize: const Size.fromHeight(50),
                        textStyle: AppText.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        glow.warmedByMe ? l10n.warmthSent : l10n.sendWarmth,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The card rises and fades in. Skipped when reduced motion is on.
class _CardPop extends StatelessWidget {
  const _CardPop({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 16 * (1 - value)),
          child: child,
        ),
      ),
    );
  }
}

class _LightButton extends StatelessWidget {
  const _LightButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: palette.accent,
        minimumSize: const Size.fromHeight(52),
        side: BorderSide(width: 1.5, color: palette.accent),
        textStyle: AppText.button,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          const FireflyGlow(size: 10),
          Flexible(child: Text(label)),
        ],
      ),
    );
  }
}

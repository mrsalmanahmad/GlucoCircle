import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text.dart';
import '../../core/widgets/app_chip.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/app_toggle.dart';
import '../../data/models.dart';
import '../../data/providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/labels.dart';

/// Screen 03.
class ShareScreen extends ConsumerStatefulWidget {
  const ShareScreen({super.key});

  @override
  ConsumerState<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends ConsumerState<ShareScreen> {
  static const _moodColours = {
    Mood.good: DayColors.moodGood,
    Mood.okay: DayColors.moodOkay,
    Mood.low: DayColors.moodLow,
    Mood.struggling: DayColors.moodStruggling,
  };

  final _text = TextEditingController();
  var _mood = Mood.okay;
  Topic? _topic;
  var _anonymous = false;
  var _posting = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _canPost =>
      !_posting && _topic != null && _text.text.trim().isNotEmpty;

  Future<void> _post() async {
    setState(() => _posting = true);
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final outcome = await ref
        .read(communityRepositoryProvider)
        .createPost(
          mood: _mood,
          topic: _topic!,
          text: _text.text.trim(),
          anonymous: _anonymous,
        );
    if (outcome == PublishOutcome.heldForReview) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.postHeld)));
    }
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: DayColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: TextButton.styleFrom(
                      foregroundColor: DayColors.textBody,
                      textStyle: AppText.rowTitle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(l10n.actionCancel),
                  ),
                  Expanded(
                    child: Text(
                      l10n.shareTitle,
                      textAlign: TextAlign.center,
                      style: AppText.cardTitle.copyWith(fontSize: 17),
                    ),
                  ),
                  FilledButton(
                    onPressed: _canPost ? _post : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: DayColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: AppText.rowTitle,
                    ),
                    child: Text(l10n.actionPost),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: DayColors.divider),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 12,
                      children: [
                        Text(l10n.shareMoodQuestion, style: AppText.cardTitle),
                        Row(
                          spacing: 8,
                          children: [
                            for (final mood in Mood.values)
                              Expanded(
                                child: _MoodTile(
                                  label: l10n.moodLabel(mood),
                                  colour: _moodColours[mood]!,
                                  selected: _mood == mood,
                                  onTap: () => setState(() => _mood = mood),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        Text(l10n.shareTextQuestion, style: AppText.cardTitle),
                        AppTextField(
                          controller: _text,
                          hint: l10n.shareTextHint,
                          minLines: 6,
                          maxLines: 10,
                          maxLength: 1000,
                          fillColor: const Color(0xFFF9FAFC),
                          borderColor: DayColors.borderStrong,
                          onChanged: (_) => setState(() {}),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 2,
                      children: [
                        Text(l10n.shareTopic, style: AppText.cardTitle),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final topic in Topic.values)
                              AppChip(
                                label: l10n.topicLabel(topic),
                                selected: _topic == topic,
                                onTap: () => setState(() => _topic = topic),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: DayColors.border),
                      ),
                      child: Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  l10n.shareAnonTitle,
                                  style: AppText.rowTitle,
                                ),
                                Text(
                                  l10n.shareAnonBody,
                                  style: AppText.chip.copyWith(
                                    color: DayColors.textMuted,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppToggle(
                            value: _anonymous,
                            semanticLabel: l10n.shareAnonTitle,
                            onChanged: (value) =>
                                setState(() => _anonymous = value),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      l10n.shareKindNote,
                      style: AppText.chip.copyWith(
                        color: DayColors.textMuted,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodTile extends StatelessWidget {
  const _MoodTile({
    required this.label,
    required this.colour,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color colour;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? DayColors.selectedTile : DayColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            width: 2,
            color: selected ? DayColors.primary : DayColors.border,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 76),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colour,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(label, style: AppText.chip),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

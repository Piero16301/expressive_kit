import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/section_header.dart';

class FontsPage extends StatefulWidget {
  const FontsPage({
    required this.selectedFont,
    required this.onFontChanged,
    required this.onShowFeedback,
    super.key,
  });

  final String selectedFont;
  final ValueChanged<String> onFontChanged;
  final ValueChanged<String> onShowFeedback;

  @override
  State<FontsPage> createState() => _FontsPageState();
}

class _FontsPageState extends State<FontsPage> {
  final TextEditingController _customTextController = TextEditingController(
    text: 'The quick brown fox jumps over the lazy dog.',
  );

  static const _fontDescriptions = <String, String>{
    'Google Sans Flex': "Modern geometric UI font with adaptive optical weights. Google's signature typeface.",
    'Merriweather': 'Designed to be a pleasant, highly readable serif on screens with mild contrast.',
    'Montserrat': 'Urban geometric sans-serif inspired by posters and signage of Buenos Aires.',
    'Nunito': 'Well-balanced rounded terminal sans-serif, warm, approachable, and playful.',
    'Open Sans': 'Neutral yet friendly humanist sans-serif optimized for mobile and web interfaces.',
    'Orbitron':
        'Geometric sci-fi display typeface with futuristic angular curves.',
    'Playfair Display':
        'High-contrast transitional serif with classical editorial elegance.',
    'Roboto': "Google's versatile neo-grotesque sans-serif with natural reading rhythm and clear shapes.",
    'Source Code Pro': 'Monospaced font family designed specifically for code editing and UI terminals.',
  };

  static const _fontCategories = <String, String>{
    'Google Sans Flex': 'Sans-Serif • Default',
    'Merriweather': 'Serif • Editorial',
    'Montserrat': 'Geometric • Punchy',
    'Nunito': 'Rounded • Friendly',
    'Open Sans': 'Humanist • Neutral',
    'Orbitron': 'Display • Sci-Fi',
    'Playfair Display': 'Serif • Classical',
    'Roboto': 'Neo-Grotesque • Workhorse',
    'Source Code Pro': 'Monospace • Code',
  };

  @override
  void dispose() {
    _customTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const availableFonts = ExpressiveFonts.availableFonts;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SectionHeader(
          title: 'Typography & Variable Fonts',
          subtitle: '9 curated variable fonts bundled with zero network latency. Tap any font to apply it to the entire application.',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedTextFont,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Active Application Font',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          availableFonts.entries
                              .firstWhere(
                                (e) => e.value == widget.selectedFont,
                                orElse: () => availableFonts.entries.first,
                              )
                              .key,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Quick switcher:',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: availableFonts.entries.map((entry) {
                  final isSelected = widget.selectedFont == entry.value;
                  return ChoiceChip(
                    label: Text(entry.key),
                    selected: isSelected,
                    onSelected: (_) {
                      widget.onFontChanged(entry.value);
                      widget.onShowFeedback('Theme font set to ${entry.key}');
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(
          title: 'Live Preview Text',
          subtitle: 'Type custom text below to preview it dynamically across all 9 fonts.',
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _customTextController,
          decoration: InputDecoration(
            hintText: 'Type sample text...',
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            prefixIcon: const SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: HugeIcon(icon: HugeIcons.strokeRoundedEdit02, size: 20),
              ),
            ),
            suffixIcon: IconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedCancel01,
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  _customTextController.text =
                      'The quick brown fox jumps over the lazy dog.';
                });
              },
            ),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Bundled Font Specimens',
          subtitle: 'Inspect letterforms, optical weights, and glyph details for each variable font family.',
        ),
        const SizedBox(height: 12),
        ...availableFonts.entries.map((entry) {
          final fontName = entry.key;
          final fontFamily = entry.value;
          final isSelected = widget.selectedFont == fontFamily;
          final category = _fontCategories[fontName] ?? 'Variable Font';
          final description = _fontDescriptions[fontName] ?? '';
          final previewText = _customTextController.text.trim().isEmpty
              ? 'The quick brown fox jumps over the lazy dog.'
              : _customTextController.text;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primaryContainer.withValues(alpha: 0.25)
                  : theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fontName,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            category,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedCheckmarkBadge01,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Active',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Divider(height: 24),
                Text(
                  previewText,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    r'Aa Bb Cc Gg Jj Qq Ww Zz 0123456789 &€$@#%',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13,
                      letterSpacing: 0.5,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Weight variations:',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    Text(
                      'Light (300)',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Regular (400)',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Medium (500)',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Bold (700)',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Italic',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ExpressiveButton(
                    label: isSelected ? 'Active App Font' : 'Apply to Gallery',
                    icon: HugeIcon(
                      icon: isSelected
                          ? HugeIcons.strokeRoundedCheckmarkBadge01
                          : HugeIcons.strokeRoundedCheckmarkCircle02,
                      size: 16,
                    ),
                    variant: isSelected
                        ? ExpressiveButtonVariant.filled
                        : ExpressiveButtonVariant.tonal,
                    onPressed: () {
                      widget.onFontChanged(fontFamily);
                      widget.onShowFeedback(
                        '$fontName applied to the gallery theme',
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        const SectionHeader(
          title: 'Active Type Scale Hierarchy',
          subtitle: 'Standard Material 3 Expressive typography scale rendered in the active font.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Display Large',
                style: theme.textTheme.displayLarge?.copyWith(fontSize: 32),
              ),
              const Divider(height: 20),
              Text('Headline Medium', style: theme.textTheme.headlineMedium),
              const Divider(height: 20),
              Text('Title Large', style: theme.textTheme.titleLarge),
              const Divider(height: 20),
              Text('Body Large', style: theme.textTheme.bodyLarge),
              const Divider(height: 20),
              Text('Label Medium', style: theme.textTheme.labelMedium),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

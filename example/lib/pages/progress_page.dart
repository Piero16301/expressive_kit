import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/section_header.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({required this.onShowFeedback, super.key});

  final ValueChanged<String> onShowFeedback;

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  double _sliderVal = 65.0;
  double _scaleBouncy = 1.0;
  double _scaleGentle = 1.0;
  double _scaleSnappy = 1.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SectionHeader(
          title: 'Material 3 Expressive Progress Indicators',
          subtitle: 'Wavy progress indicators in Determinate (Column 1) and Indeterminate (Column 2) modes.',
        ),
        const SizedBox(height: 16),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant
                      .withValues(alpha: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 36,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ExpressiveLinearProgressIndicator(
                              value: _sliderVal / 100,
                            ),
                          ),
                          const SizedBox(height: 36),
                          ExpressiveCircularProgressIndicator(
                            value: _sliderVal / 100,
                          ),
                          const SizedBox(height: 28),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Determinate (${_sliderVal.toInt()}%)',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: ExpressiveLinearProgressIndicator(),
                          ),
                          const SizedBox(height: 36),
                          const ExpressiveCircularProgressIndicator(),
                          const SizedBox(height: 28),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Indeterminate',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Determinate Progress Control (${_sliderVal.toInt()}%):'),
        Slider(
          value: _sliderVal,
          max: 100,
          divisions: 100,
          label: '${_sliderVal.toInt()}%',
          onChanged: (v) => setState(() => _sliderVal = v),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [0.0, 25.0, 50.0, 75.0, 95.0, 100.0].map((preset) {
            return OutlinedButton(
              onPressed: () => setState(() => _sliderVal = preset),
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              child: Text('${preset.toInt()}%'),
            );
          }).toList(),
        ),
        const SizedBox(height: 28),
        const SectionHeader(
          title: 'Motion Physics & Curves (ExpressiveMotion & ExpressivePressable)',
          subtitle: 'Official animation tokens with spring bounce physics (Spring Physics).',
        ),
        const SizedBox(height: 12),
        _MotionCard(
          title: 'ExpressiveMotion.springBouncy',
          subtitle:
              'Cubic(0.34, 1.35, 0.64, 1) — Smooth and energetic overshoot.',
          scale: _scaleBouncy,
          curve: ExpressiveMotion.springBouncy,
          color: const Color(0xFF1E88E5),
          onTap: () async {
            setState(() => _scaleBouncy = 0.85);
            await Future.delayed(ExpressiveMotion.durationShort);
            if (mounted) setState(() => _scaleBouncy = 1.0);
          },
        ),
        const SizedBox(height: 12),
        _MotionCard(
          title: 'ExpressiveMotion.springGentle',
          subtitle: 'Cubic(0.2, 0, 0, 1) — Smooth and progressive damping.',
          scale: _scaleGentle,
          curve: ExpressiveMotion.springGentle,
          color: const Color(0xFF7B1FA2),
          onTap: () async {
            setState(() => _scaleGentle = 0.85);
            await Future.delayed(ExpressiveMotion.durationShort);
            if (mounted) setState(() => _scaleGentle = 1.0);
          },
        ),
        const SizedBox(height: 12),
        _MotionCard(
          title: 'ExpressiveMotion.emphasized',
          subtitle: 'Curves.easeInOutCubicEmphasized — State transition and morphing.',
          scale: _scaleSnappy,
          curve: ExpressiveMotion.emphasized,
          color: const Color(0xFF00897B),
          onTap: () async {
            setState(() => _scaleSnappy = 0.85);
            await Future.delayed(ExpressiveMotion.durationShort);
            if (mounted) setState(() => _scaleSnappy = 1.0);
          },
        ),
        const SizedBox(height: 16),
        ExpressivePressable(
          onTap: () => widget.onShowFeedback(
            'ExpressivePressable pressed with tactile feedback',
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedCursorPointer01,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Text(
                  'ExpressivePressable (Spring press effect)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _MotionCard extends StatelessWidget {
  const _MotionCard({
    required this.title,
    required this.subtitle,
    required this.scale,
    required this.curve,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final double scale;
  final Curve curve;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: scale,
        duration: ExpressiveMotion.durationShort,
        curve: curve,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCursorPointer01,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const Text(
                'Tap!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

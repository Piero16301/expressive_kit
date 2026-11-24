import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/section_header.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({required this.onShowFeedback, super.key});

  final ValueChanged<String> onShowFeedback;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SectionHeader(
          title:
              'Floating Action Buttons (ExpressiveFab & ExpressiveExtendedFab)',
          subtitle: 'Sizes: small (44dp), regular (56dp), large (80dp), and extended.',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ExpressiveFab(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
              size: ExpressiveFabSize.small,
              tooltip: 'Small FAB (44dp)',
              onPressed: () => onShowFeedback('Small FAB pressed'),
            ),
            ExpressiveFab(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedEdit02),
              size: ExpressiveFabSize.regular,
              tooltip: 'Regular FAB (56dp)',
              onPressed: () => onShowFeedback('Regular FAB pressed'),
            ),
            ExpressiveFab(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedPaintBrush01),
              size: ExpressiveFabSize.large,
              tooltip: 'Large FAB (80dp)',
              onPressed: () => onShowFeedback('Large FAB pressed'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ExpressiveExtendedFab(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedTaskAdd01),
          label: 'New Expressive Task',
          onPressed: () => onShowFeedback('Extended FAB pressed'),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Expandable Floating Menu (ExpressiveFabMenu)',
          subtitle: 'Quick action speed dial menu animated with spring bounce physics.',
        ),
        const SizedBox(height: 8),
        const ExpressiveCard(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              HugeIcon(icon: HugeIcons.strokeRoundedCursorPointer01, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The "+" floating button located at the bottom-right corner expands an interactive ExpressiveFabMenu with quick action options.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Bottom Navigation Bar (ExpressiveNavigationBar)',
          subtitle: 'Pill indicator animated with spring bounce, badges, and tonal elevation.',
        ),
        const SizedBox(height: 8),
        const ExpressiveCard(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              HugeIcon(icon: HugeIcons.strokeRoundedLayers01, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The active bottom navigation bar is an ExpressiveNavigationBar instance controlling the 5 tabs of this gallery.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Expressive Top App Bar (ExpressiveTopAppBar)',
          subtitle: 'Flat surface without unnecessary elevation, action support, and adaptive navigation back button.',
        ),
        const SizedBox(height: 8),
        ExpressiveCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Standard Variant vs Large Variant',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 6),
              const Text(
                'Allows configuring large titles, custom leading widgets, and automatic navigation buttons.',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              ExpressiveButton(
                label: 'View Large TopAppBar Demo',
                variant: ExpressiveButtonVariant.tonal,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: ExpressiveTopAppBar.large(
                          titleText: 'Large TopAppBar',
                          actions: [
                            ExpressiveIconButton.circle(
                              icon: const HugeIcon(
                                icon: HugeIcons.strokeRoundedInformationCircle,
                              ),
                              onPressed: () => onShowFeedback('Info modal'),
                            ),
                          ],
                        ),
                        body: const Center(
                          child: Text('Secondary screen with TopAppBar.large'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

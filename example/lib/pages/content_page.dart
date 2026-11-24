import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/section_header.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onShowFeedback,
    super.key,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final ValueChanged<String> onShowFeedback;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SectionHeader(
          title: 'Search Bar (ExpressiveSearchBar)',
          subtitle: '28dp pill container with search icon and embedded trailing actions.',
        ),
        const SizedBox(height: 12),
        ExpressiveSearchBar(
          hintText: 'Search components, colors, or settings...',
          margin: EdgeInsets.zero,
          trailing: ExpressiveIconButton.circle(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedMic01, size: 20),
            tooltip: 'Voice search',
            onPressed: () => onShowFeedback('Voice search activated'),
          ),
          onSubmitted: (query) => onShowFeedback('Searching: "$query"'),
        ),
        const SizedBox(height: 12),
        ExpressiveSearchBar(
          hintText: 'Read-only mode (Tap to explore)',
          readOnly: true,
          margin: EdgeInsets.zero,
          trailing: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowRight01,
            size: 16,
          ),
          onTap: () => onShowFeedback('Search modal opened'),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Multi-Browse Carousel (ExpressiveCarousel)',
          subtitle: 'Smooth horizontal scrolling with 24dp adaptive corners and spring physics.',
        ),
        const SizedBox(height: 12),
        ExpressiveCarousel(
          height: 160,
          itemExtent: 220,
          items: [
            ExpressiveCarouselItem(
              onTap: () => onShowFeedback('Card 1 selected'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedPaintBoard,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Material 3\nExpressive Theme',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpressiveCarouselItem(
              onTap: () => onShowFeedback('Card 2 selected'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedMagicWand01,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Spring Bouncy\nPhysics Motion',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpressiveCarouselItem(
              onTap: () => onShowFeedback('Card 3 selected'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00897B), Color(0xFF4DB6AC)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCube,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      '17 Native\nComponents & Tests',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Card Group & List Tiles (ExpressiveCardGroup & ExpressiveListTile)',
          subtitle: 'Pixel Settings list style with vibrant circular badges and automatic dividers.',
        ),
        const SizedBox(height: 12),
        ExpressiveCardGroup(
          title: 'Connectivity Preferences',
          margin: EdgeInsets.zero,
          children: [
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedWifi01,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF1E88E5),
                foregroundColor: Colors.white,
              ),
              title: const Text('Internet & network'),
              subtitle: const Text('Home Wi-Fi 5GHz connected'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              onTap: () => onShowFeedback('Wi-Fi settings'),
            ),
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedBluetooth,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF5E35B1),
                foregroundColor: Colors.white,
              ),
              title: const Text('Connected devices'),
              subtitle: const Text('Pixel Buds Pro headphones'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              onTap: () => onShowFeedback('Bluetooth settings'),
            ),
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedShield01,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF2E7D32),
                foregroundColor: Colors.white,
              ),
              title: const Text('Security & privacy'),
              subtitle: const Text('Device protected and up to date'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              onTap: () => onShowFeedback('Security settings'),
            ),
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedMoon02,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFFEF6C00),
                foregroundColor: Colors.white,
              ),
              title: const Text('Dark theme'),
              subtitle: const Text('Toggle visual appearance'),
              showSplitDivider: true,
              onTap: onToggleTheme,
              secondaryTrailing: ExpressiveSwitch(
                value: isDarkMode,
                onChanged: (_) => onToggleTheme(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Standalone Card (ExpressiveCard)',
          subtitle: 'Elevated surface with smooth 24dp corners and responsive touch reaction.',
        ),
        const SizedBox(height: 12),
        ExpressiveCard(
          margin: EdgeInsets.zero,
          onTap: () => onShowFeedback('Standalone card pressed'),
          child: const Row(
            children: [
              ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedStar,
                  color: Colors.black87,
                  size: 20,
                ),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expressive Experience',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Modern design language inspired by Material Design 3 Expressive guidelines.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

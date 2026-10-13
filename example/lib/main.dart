import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expressive Kit Gallery',
      debugShowCheckedModeBanner: false,
      theme: ExpressiveTheme.light(baseColor: const Color(0xFF1E88E5)),
      darkTheme: ExpressiveTheme.dark(baseColor: const Color(0xFF1E88E5)),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: GalleryScreen(isDarkMode: _isDarkMode, onToggleTheme: _toggleTheme),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    required this.isDarkMode,
    required this.onToggleTheme,
    super.key,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _selectedTab = 0;

  // Controls state
  bool _btnLoading = false;
  String _selectedFrequency = 'Weekly';
  bool _switchVal1 = true;
  bool _switchVal2 = false;
  double _sliderVal = 65.0;
  double _sliderStepVal = 3.0;
  int _badgeCount = 3;

  // Motion playground state
  double _scaleBouncy = 1.0;
  double _scaleGentle = 1.0;
  double _scaleSnappy = 1.0;

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExpressiveTopAppBar(
        title: const Text('Expressive Kit Gallery'),
        actions: [
          ExpressiveIconButton.circle(
            icon: HugeIcon(
              icon: widget.isDarkMode
                  ? HugeIcons.strokeRoundedSun03
                  : HugeIcons.strokeRoundedMoon02,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            tooltip: widget.isDarkMode ? 'Light mode' : 'Dark mode',
            onPressed: widget.onToggleTheme,
          ),
          ExpressiveIconButton.circle(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedNotification01),
            badgeText: '$_badgeCount',
            tooltip: 'Notifications',
            onPressed: () {
              setState(() => _badgeCount = (_badgeCount + 1) % 10);
              _showFeedback('Notifications: $_badgeCount');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildControlsTab(),
          _buildContentTab(),
          _buildProgressAndMotionTab(),
          _buildNavigationAndFabTab(),
        ],
      ),
      bottomNavigationBar: ExpressiveNavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() => _selectedTab = index);
        },
        destinations: const [
          ExpressiveNavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedCursorPointer01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedCursorPointer01,
            ),
            label: 'Controls',
          ),
          ExpressiveNavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedGridTable),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedDashboardSquare01,
            ),
            label: 'Content',
          ),
          ExpressiveNavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedDashboardSpeed01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedDashboardSpeed01,
            ),
            label: 'Progress',
          ),
          ExpressiveNavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedNavigation03),
            selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedNavigation03),
            label: 'Navigation',
            showBadgeDot: true,
          ),
        ],
      ),
      floatingActionButton: ExpressiveFabMenu(
        items: [
          ExpressiveFabMenuItem(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedShare01),
            label: 'Share',
            onTap: () => _showFeedback('Action: Share'),
          ),
          ExpressiveFabMenuItem(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedBookmark02),
            label: 'Save',
            onTap: () => _showFeedback('Action: Save'),
          ),
          ExpressiveFabMenuItem(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
            label: 'New item',
            onTap: () => _showFeedback('Action: New item'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 1: BUTTONS AND CONTROLS
  // ---------------------------------------------------------------------------
  Widget _buildControlsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSectionHeader(
          'Buttons (ExpressiveButton)',
          'Material 3 variants with spring curves and responsive interactive states.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton(
              label: 'Filled',
              variant: ExpressiveButtonVariant.filled,
              onPressed: () => _showFeedback('Filled button pressed'),
            ),
            ExpressiveButton(
              label: 'Tonal',
              variant: ExpressiveButtonVariant.tonal,
              onPressed: () => _showFeedback('Tonal button pressed'),
            ),
            ExpressiveButton(
              label: 'Outlined',
              variant: ExpressiveButtonVariant.outlined,
              onPressed: () => _showFeedback('Outlined button pressed'),
            ),
            ExpressiveButton(
              label: 'Elevated',
              variant: ExpressiveButtonVariant.elevated,
              onPressed: () => _showFeedback('Elevated button pressed'),
            ),
            ExpressiveButton(
              label: 'Text',
              variant: ExpressiveButtonVariant.text,
              onPressed: () => _showFeedback('Text button pressed'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton(
              label: 'With Icon',
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedStar, size: 20),
              variant: ExpressiveButtonVariant.filled,
              onPressed: () => _showFeedback('Button with icon pressed'),
            ),
            ExpressiveButton(
              label: 'Next',
              trailingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              variant: ExpressiveButtonVariant.tonal,
              onPressed: () => _showFeedback('Next button pressed'),
            ),
            ExpressiveButton(
              label: _btnLoading ? 'Loading...' : 'Load Data',
              isLoading: _btnLoading,
              variant: ExpressiveButtonVariant.outlined,
              onPressed: () {
                setState(() => _btnLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) setState(() => _btnLoading = false);
                });
              },
            ),
            const ExpressiveButton(label: 'Disabled', onPressed: null),
          ],
        ),
        const SizedBox(height: 12),
        ExpressiveButton(
          label: 'Expanded Button (Full Width)',
          isExpanded: true,
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedCheckmarkCircle01,
            size: 20,
          ),
          variant: ExpressiveButtonVariant.filled,
          onPressed: () => _showFeedback('Expanded button pressed'),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Split Button (ExpressiveSplitButton)',
          'Continuous primary action with an expandable secondary dropdown.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ExpressiveSplitButton(
              label: 'Save File',
              leadingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedFloppyDisk,
                size: 20,
              ),
              variant: ExpressiveButtonVariant.filled,
              onPressed: () => _showFeedback('Save file'),
              onTrailingPressed: () => _showFeedback('More save options'),
            ),
            ExpressiveSplitButton(
              label: 'Export Data',
              variant: ExpressiveButtonVariant.tonal,
              onPressed: () => _showFeedback('Export data'),
              onTrailingPressed: () => _showFeedback('Export format'),
            ),
            ExpressiveSplitButton(
              label: 'Send',
              variant: ExpressiveButtonVariant.outlined,
              onPressed: () => _showFeedback('Send'),
              onTrailingPressed: () => _showFeedback('Schedule send'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Segmented Picker (ExpressiveButtonGroup)',
          'Button group with single selection and continuous sliding pill indicator.',
        ),
        const SizedBox(height: 12),
        ExpressiveButtonGroup<String>(
          selectedValue: _selectedFrequency,
          onSelected: (val) {
            setState(() => _selectedFrequency = val);
            _showFeedback('Selected frequency: $val');
          },
          items: const [
            ExpressiveButtonGroupItem(
              value: 'Daily',
              label: 'Daily',
              icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar01, size: 18),
            ),
            ExpressiveButtonGroupItem(
              value: 'Weekly',
              label: 'Weekly',
              icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar02, size: 18),
            ),
            ExpressiveButtonGroupItem(
              value: 'Monthly',
              label: 'Monthly',
              icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar03, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Icon Buttons (ExpressiveIconButton)',
          'Shapes: circular, squircle, and rounded rectangle, with badge options.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedFavourite),
              variant: ExpressiveIconButtonVariant.filled,
              tooltip: 'Favorite (Filled Circle)',
              onPressed: () => _showFeedback('Favorite pressed'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedShare01),
              variant: ExpressiveIconButtonVariant.tonal,
              tooltip: 'Share (Tonal Circle)',
              onPressed: () => _showFeedback('Share pressed'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedBookmark02),
              variant: ExpressiveIconButtonVariant.outlined,
              tooltip: 'Bookmark (Outlined Circle)',
              onPressed: () => _showFeedback('Bookmark pressed'),
            ),
            ExpressiveIconButton.squircle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedCamera01),
              variant: ExpressiveIconButtonVariant.filled,
              tooltip: 'Camera (Squircle Filled)',
              onPressed: () => _showFeedback('Camera pressed'),
            ),
            ExpressiveIconButton.squircle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedImage01),
              variant: ExpressiveIconButtonVariant.tonal,
              tooltip: 'Gallery (Squircle Tonal)',
              onPressed: () => _showFeedback('Gallery pressed'),
            ),
            ExpressiveIconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedSlidersHorizontal,
              ),
              shape: ExpressiveIconButtonShape.roundedRectangle,
              variant: ExpressiveIconButtonVariant.filled,
              tooltip: 'Settings (Rounded Rect)',
              onPressed: () => _showFeedback('Settings pressed'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedMail01),
              variant: ExpressiveIconButtonVariant.tonal,
              badgeText: '9+',
              tooltip: 'Messages with Badge',
              onPressed: () => _showFeedback('Messages: 9+ unread'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedNotification01),
              showBadgeDot: true,
              tooltip: 'Alert with Dot',
              onPressed: () => _showFeedback('Active alert'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Switches (ExpressiveSwitch)',
          'Capsule track with check/cross icons in the thumb and spring physics.',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ExpressiveSwitch(
              value: _switchVal1,
              onChanged: (val) => setState(() => _switchVal1 = val),
            ),
            const SizedBox(width: 12),
            Text(
              _switchVal1 ? 'Enabled (With icons)' : 'Disabled (With icons)',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ExpressiveSwitch(
              value: _switchVal2,
              showIcons: false,
              onChanged: (val) => setState(() => _switchVal2 = val),
            ),
            const SizedBox(width: 12),
            Text(
              _switchVal2 ? 'Enabled (No icons)' : 'Disabled (No icons)',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Sliders (ExpressiveSlider)',
          'Thick capsule track with pill thumb indicator and stepper buttons (+/-).',
        ),
        const SizedBox(height: 8),
        ExpressiveSlider(
          value: _sliderVal,
          min: 0,
          max: 100,
          title: 'Media volume',
          subtitle: 'Current level: ${_sliderVal.toInt()}%',
          onChanged: (val) => setState(() => _sliderVal = val),
        ),
        const SizedBox(height: 12),
        ExpressiveSlider(
          value: _sliderStepVal,
          min: 1,
          max: 5,
          divisions: 4,
          title: 'Graphics quality (Discrete)',
          subtitle: 'Level: ${_sliderStepVal.toInt()} of 5 stars',
          onChanged: (val) => setState(() => _sliderStepVal = val),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 2: CONTENT, CARDS AND LISTS
  // ---------------------------------------------------------------------------
  Widget _buildContentTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSectionHeader(
          'Search Bar (ExpressiveSearchBar)',
          '28dp pill container with search icon and embedded trailing actions.',
        ),
        const SizedBox(height: 12),
        ExpressiveSearchBar(
          hintText: 'Search components, colors, or settings...',
          margin: EdgeInsets.zero,
          trailing: ExpressiveIconButton.circle(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedMic01, size: 20),
            tooltip: 'Voice search',
            onPressed: () => _showFeedback('Voice search activated'),
          ),
          onSubmitted: (query) => _showFeedback('Searching: "$query"'),
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
          onTap: () => _showFeedback('Search modal opened'),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Multi-Browse Carousel (ExpressiveCarousel)',
          'Smooth horizontal scrolling with 24dp adaptive corners and spring physics.',
        ),
        const SizedBox(height: 12),
        ExpressiveCarousel(
          height: 160,
          itemExtent: 220,
          items: [
            ExpressiveCarouselItem(
              onTap: () => _showFeedback('Card 1 selected'),
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
              onTap: () => _showFeedback('Card 2 selected'),
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
              onTap: () => _showFeedback('Card 3 selected'),
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
                      '15 Native\nComponents & Tests',
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
        _buildSectionHeader(
          'Card Group & List Tiles (ExpressiveCardGroup & ExpressiveListTile)',
          'Pixel Settings list style with vibrant circular badges and automatic dividers.',
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
              onTap: () => _showFeedback('Wi-Fi settings'),
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
              onTap: () => _showFeedback('Bluetooth settings'),
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
              onTap: () => _showFeedback('Security settings'),
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
              onTap: widget.onToggleTheme,
              secondaryTrailing: ExpressiveSwitch(
                value: widget.isDarkMode,
                onChanged: (_) => widget.onToggleTheme(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Standalone Card (ExpressiveCard)',
          'Elevated surface with smooth 24dp corners and responsive touch reaction.',
        ),
        const SizedBox(height: 12),
        ExpressiveCard(
          margin: EdgeInsets.zero,
          onTap: () => _showFeedback('Standalone card pressed'),
          child: Row(
            children: [
              const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedStar,
                  color: Colors.black87,
                  size: 20,
                ),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
              ),
              const SizedBox(width: 16),
              const Expanded(
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
              const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 3: PROGRESS AND MOTION TOKENS
  // ---------------------------------------------------------------------------
  Widget _buildProgressAndMotionTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSectionHeader(
          'Material 3 Expressive Progress Indicators',
          'Wavy progress indicators in Determinate (Column 1) and Indeterminate (Column 2) modes.',
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
                    // Column 1: Determinate
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
                    // Column 2: Indeterminate
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
        _buildSectionHeader(
          'Motion Physics & Curves (ExpressiveMotion & ExpressivePressable)',
          'Official animation tokens with spring bounce physics (Spring Physics).',
        ),
        const SizedBox(height: 12),
        _buildMotionCard(
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
        _buildMotionCard(
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
        _buildMotionCard(
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
          onTap: () => _showFeedback(
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

  // ---------------------------------------------------------------------------
  // TAB 4: NAVIGATION AND FLOATING ACTION BUTTONS (FAB)
  // ---------------------------------------------------------------------------
  Widget _buildNavigationAndFabTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSectionHeader(
          'Floating Action Buttons (ExpressiveFab & ExpressiveExtendedFab)',
          'Sizes: small (44dp), regular (56dp), large (80dp), and extended.',
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
              onPressed: () => _showFeedback('Small FAB pressed'),
            ),
            ExpressiveFab(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedEdit02),
              size: ExpressiveFabSize.regular,
              tooltip: 'Regular FAB (56dp)',
              onPressed: () => _showFeedback('Regular FAB pressed'),
            ),
            ExpressiveFab(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedPaintBrush01),
              size: ExpressiveFabSize.large,
              tooltip: 'Large FAB (80dp)',
              onPressed: () => _showFeedback('Large FAB pressed'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ExpressiveExtendedFab(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedTaskAdd01),
          label: 'New Expressive Task',
          onPressed: () => _showFeedback('Extended FAB pressed'),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Expandable Floating Menu (ExpressiveFabMenu)',
          'Quick action speed dial menu animated with spring bounce physics.',
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
        _buildSectionHeader(
          'Bottom Navigation Bar (ExpressiveNavigationBar)',
          'Pill indicator animated with spring bounce, badges, and tonal elevation.',
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
                  'The active bottom navigation bar is an ExpressiveNavigationBar instance controlling the 4 tabs of this gallery.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader(
          'Expressive Top App Bar (ExpressiveTopAppBar)',
          'Flat surface without unnecessary elevation, action support, and adaptive navigation back button.',
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
                              onPressed: () => _showFeedback('Info modal'),
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

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------
  Widget _buildSectionHeader(String title, String subtitle) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildMotionCard({
    required String title,
    required String subtitle,
    required double scale,
    required Curve curve,
    required Color color,
    required VoidCallback onTap,
  }) {
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

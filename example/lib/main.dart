import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import 'pages/pages.dart';

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
  String _selectedFontFamily = ExpressiveFonts.googleSansFlex;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  void _changeFont(String newFont) {
    setState(() => _selectedFontFamily = newFont);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expressive Kit Gallery',
      debugShowCheckedModeBanner: false,
      theme: ExpressiveTheme.light(
        baseColor: const Color(0xFF1E88E5),
        fontFamily: _selectedFontFamily,
      ),
      darkTheme: ExpressiveTheme.dark(
        baseColor: const Color(0xFF1E88E5),
        fontFamily: _selectedFontFamily,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        ExpressiveLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: ExpressiveLocalizations.supportedLocales,
      home: GalleryScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
        selectedFont: _selectedFontFamily,
        onFontChanged: _changeFont,
      ),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.selectedFont,
    required this.onFontChanged,
    super.key,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final String selectedFont;
  final ValueChanged<String> onFontChanged;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _selectedTab = 0;
  int _badgeCount = 3;

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
          ControlsPage(onShowFeedback: _showFeedback),
          ContentPage(
            isDarkMode: widget.isDarkMode,
            onToggleTheme: widget.onToggleTheme,
            onShowFeedback: _showFeedback,
          ),
          ProgressPage(onShowFeedback: _showFeedback),
          NavigationPage(onShowFeedback: _showFeedback),
          FontsPage(
            selectedFont: widget.selectedFont,
            onFontChanged: widget.onFontChanged,
            onShowFeedback: _showFeedback,
          ),
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
          ExpressiveNavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedTextFont),
            selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedTextFont),
            label: 'Fonts',
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
}

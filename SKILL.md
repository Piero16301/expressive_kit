---
name: expressive-kit
description: Use this skill to implement, style, or migrate Flutter applications using expressive_kit (Material 3 Expressive design system, themes, typography, and motion).
---

# Expressive Kit — AI Agent Skill & Implementation Guide

`expressive_kit` is a Flutter design system implementing **Material 3 Expressive** guidelines. It provides expressive shapes (24dp+ rounded corners, organic pills), authentic spring physics, wavy progress indicators, curated variable fonts, and high-cohesion interactive components.

Use this guide to:
1. Initialize or configure themes and fonts in any Flutter app.
2. Build new UI interfaces using `expressive_kit` components.
3. Migrate and replace standard Flutter widgets (Material/Cupertino) or third-party libraries with `expressive_kit` equivalents.

---

## 1. Quick Setup & Dependencies

Always ensure `pubspec.yaml` has the required dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  expressive_kit: ^0.0.2
  hugeicons: ^1.2.0
```

> **CRITICAL RULE FOR ICONS**: All components in `expressive_kit` use **HugeIcons**. Never use Flutter's default `Icons.xxx` (Material Icons) inside `expressive_kit` components; always use:
> ```dart
> import 'package:hugeicons/hugeicons.dart';
> 
> HugeIcon(
>   icon: HugeIcons.strokeRoundedSparkles,
>   color: Colors.white,
>   size: 20,
> )
> ```

---

## 2. Theme & Typography Configuration

### 2.1 Applying `ExpressiveTheme`
Replace standard `ThemeData` inside `MaterialApp`:

```dart
import 'package:material_ui/material_ui.dart';
import 'package:expressive_kit/expressive_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6750A4); // Any brand color

    return MaterialApp(
      title: 'Expressive App',
      theme: ExpressiveTheme.light(
        baseColor: ExpressiveColors.defaultColor,
        fontFamily: ExpressiveFonts.defaultFont,
      ),
      darkTheme: ExpressiveTheme.dark(
        baseColor: ExpressiveColors.defaultColor,
        fontFamily: ExpressiveFonts.defaultFont,
      ),
      themeMode: ExpressiveTheme.defaultTheme,
      localizationsDelegates: ExpressiveLocalizations.localizationsDelegates,
      supportedLocales: ExpressiveLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
```

### 2.2 Bundled Variable Fonts (`ExpressiveFonts`)
The package includes 9 bundled variable font families ready to use without external network requests:

| Constant | Font Name | Best For |
| :--- | :--- | :--- |
| `ExpressiveFonts.googleSansFlex` | Google Sans Flex | Modern, clean UI & headings (`defaultFont`) |
| `ExpressiveFonts.merriweather` | Merriweather | Serif • Editorial reading |
| `ExpressiveFonts.montserrat` | Montserrat | Geometric, punchy branding & cards |
| `ExpressiveFonts.nunito` | Nunito | Rounded sans • Friendly & playful |
| `ExpressiveFonts.openSans` | Open Sans | Humanist sans • Neutral mobile UI |
| `ExpressiveFonts.orbitron` | Orbitron | Futuristic, tech, crypto, numbers |
| `ExpressiveFonts.playfairDisplay` | Playfair Display | High-contrast classical serif |
| `ExpressiveFonts.roboto` | Roboto | Neo-grotesque sans • Standard copy |
| `ExpressiveFonts.sourceCodePro` | Source Code Pro | Monospace • Code & terminals |

To inspect all available fonts:
```dart
final allFonts = ExpressiveFonts.availableFonts; // static const Map<String, String>
```

To apply to individual text styles:
```dart
Text(
  'Expressive Heading',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontFamily: ExpressiveFonts.orbitron,
    fontWeight: FontWeight.bold,
  ),
);
```

### 2.3 Color Palette & Helpers (`ExpressiveColors`)
Dynamic color palette with standard keys and color-matching:

```dart
// Predefined default color
final defaultColor = ExpressiveColors.defaultColor; // Colors.teal

// Lookup color by key or get key from Color
final redColor = ExpressiveColors.fromKey('RED');
final colorKey = ExpressiveColors.toKey(Colors.teal); // 'TEAL'
final palette = ExpressiveColors.palette; // 19 curated colors
```

### 2.4 Built-in Localization (`ExpressiveLocalizations`)
Ready-to-use localizations across 6 locales (`en`, `es`, `it`, `de`, `fr`, `pt`):

```dart
// Context extensions via ExpressiveLocalizationExtensions
final themeLabel = ThemeMode.system.localizedName(context);       // e.g. "Sistema" / "System"
final localeLabel = const Locale('it').localizedName(context);    // e.g. "Italiano" / "Italian"
final colorLabel = Colors.teal.localizedName(context);            // e.g. "Turquesa" / "Teal"
```

---

## 3. Motion & Animation Tokens (`ExpressiveMotion`)

Use `ExpressiveMotion` tokens for smooth, physical spring transitions:

```dart
// Curves
ExpressiveMotion.springBouncy    // Spring curve for playful taps & pills
ExpressiveMotion.springGentle    // Gentle spring for smooth transitions
ExpressiveMotion.emphasized      // Emphasized M3 curve

// Durations
ExpressiveMotion.shortDuration    // 150ms
ExpressiveMotion.mediumDuration   // 300ms
ExpressiveMotion.longDuration     // 500ms

// Radii
ExpressiveMotion.expressivePillRadius  // 999.0 (Capsule/Pill)
ExpressiveMotion.cardRadius            // 24.0
ExpressiveMotion.sheetRadius           // 28.0
```

---

## 4. Components Catalog & Usage

### 4.1 Buttons & Triggers

#### • `ExpressiveButton`
Action buttons with filled, tonal, and outlined styles, full-width support, and built-in loading spinners:

```dart
ExpressiveButton(
  label: 'Get Started',
  icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, size: 20),
  variant: ExpressiveButtonVariant.filled, // or .tonal, .outlined
  isLoading: false,
  isFullWidth: false,
  onPressed: () {},
)
```

#### • `ExpressiveSplitButton`
Combined primary action with expandable secondary dropdown trigger:

```dart
ExpressiveSplitButton(
  label: 'Export Document',
  leadingIcon: const HugeIcon(icon: HugeIcons.strokeRoundedDownload01, size: 20),
  variant: ExpressiveButtonVariant.filled,
  onPressed: () => print('Primary export clicked'),
  onTrailingPressed: () => print('Open export formats dropdown'),
)
```

#### • `ExpressiveButtonGroup`
Segmented selection control with spring-animated sliding pill:

```dart
ExpressiveButtonGroup<String>(
  selectedValue: currentFilter,
  onSelected: (val) => setState(() => currentFilter = val),
  items: const [
    ExpressiveButtonGroupItem(
      value: 'all',
      label: 'All',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedFilter, size: 18),
    ),
    ExpressiveButtonGroupItem(
      value: 'active',
      label: 'Active',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedFlash, size: 18),
    ),
  ],
)
```

#### • `ExpressiveIconButton`
Icon buttons with distinctive expressive shapes and optional notification badges:

```dart
// Circle
ExpressiveIconButton.circle(
  icon: const HugeIcon(icon: HugeIcons.strokeRoundedFavourite),
  variant: ExpressiveIconButtonVariant.filled,
  onPressed: () {},
)

// Squircle (Smooth Rounded Corner)
ExpressiveIconButton.squircle(
  icon: const HugeIcon(icon: HugeIcons.strokeRoundedCamera01),
  variant: ExpressiveIconButtonVariant.tonal,
  badgeText: '3',
  onPressed: () {},
)

// Rounded Rectangle
ExpressiveIconButton.roundedRectangle(
  icon: const HugeIcon(icon: HugeIcons.strokeRoundedSettings01),
  variant: ExpressiveIconButtonVariant.outlined,
  showBadgeDot: true,
  onPressed: () {},
)
```

---

### 4.2 Form & Interactive Controls

#### • `ExpressiveSwitch`
Organic toggle with animated custom icons and tactile bounce:

```dart
ExpressiveSwitch(
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
  activeIcon: const HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkBadge01, size: 16),
  inactiveIcon: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01, size: 16),
)
```

#### • `ExpressiveSlider`
Slider with floating value callout, custom step divisions, and spring drag responses:

```dart
ExpressiveSlider(
  value: sliderValue, // 0.0 - 100.0
  min: 0,
  max: 100,
  divisions: 10,
  prefixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedVolumeLow, size: 20),
  suffixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedVolumeHigh, size: 20),
  onChanged: (val) => setState(() => sliderValue = val),
)
```

#### • `ExpressiveSearchBar`
Curved search input with dynamic leading/trailing actions and clear button:

```dart
ExpressiveSearchBar(
  hintText: 'Search documents, files...',
  onChanged: (query) => filterItems(query),
  onTrailingPressed: () => openFilterModal(),
  trailingIcon: const HugeIcon(icon: HugeIcons.strokeRoundedFilter, size: 20),
)
```

---

### 4.3 Progress & Feedback

#### • `ExpressiveLoadingIndicator`
Wavy sinusoidal loading indicators (Linear and Circular), supporting determinate and indeterminate states:

```dart
// Circular Wavy Indeterminate
const ExpressiveLoadingIndicator.circular(
  isWavy: true,
  size: 48,
  strokeWidth: 4,
)

// Linear Wavy Determinate Progress (e.g. 75%)
const ExpressiveLoadingIndicator.linear(
  value: 0.75,
  isWavy: true,
  trackSpacing: 6,
)
```

---

### 4.4 Structure & Navigation

#### • `ExpressiveTopAppBar`
Expressive header with large titles, rounded container, and action icons:

```dart
ExpressiveTopAppBar(
  title: 'Dashboard',
  subtitle: 'Welcome back, Alex',
  leading: ExpressiveIconButton.circle(
    icon: const HugeIcon(icon: HugeIcons.strokeRoundedMenu01),
    variant: ExpressiveIconButtonVariant.ghost,
    onPressed: () => Scaffold.of(context).openDrawer(),
  ),
  actions: [
    ExpressiveIconButton.circle(
      icon: const HugeIcon(icon: HugeIcons.strokeRoundedNotification01),
      variant: ExpressiveIconButtonVariant.tonal,
      badgeText: '5',
      onPressed: () {},
    ),
  ],
)
```

#### • `ExpressiveNavigationBar`
Bottom navigation bar featuring animated pill indicators:

```dart
ExpressiveNavigationBar(
  selectedIndex: currentIndex,
  onDestinationSelected: (index) => setState(() => currentIndex = index),
  destinations: const [
    ExpressiveNavigationDestination(
      label: 'Home',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
      selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedHome02),
    ),
    ExpressiveNavigationDestination(
      label: 'Analytics',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedChartBar),
      badgeText: 'NEW',
    ),
    ExpressiveNavigationDestination(
      label: 'Profile',
      icon: HugeIcon(icon: HugeIcons.strokeRoundedUser),
    ),
  ],
)
```

#### • `ExpressiveListTile`
Modern list item with tonal background, spring tap feedback, and flexible leading/trailing widgets:

```dart
ExpressiveListTile(
  title: 'Security & Privacy',
  subtitle: 'Two-factor authentication enabled',
  leading: const HugeIcon(icon: HugeIcons.strokeRoundedShieldSecurity),
  trailing: const HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01),
  onTap: () {},
)
```

#### • `ExpressiveCardGroup`
Curved card container with outer boundary isolation and divided inner rows:

```dart
ExpressiveCardGroup(
  children: [
    ExpressiveListTile(
      title: 'Notifications',
      trailing: ExpressiveSwitch(value: true, onChanged: (_) {}),
    ),
    ExpressiveListTile(
      title: 'Dark Mode',
      trailing: ExpressiveSwitch(value: false, onChanged: (_) {}),
    ),
  ],
)
```

#### • `ExpressiveCarousel`
Multi-browse horizontal carousel with auto-peeking items and spring drag snapping:

```dart
ExpressiveCarousel(
  height: 220,
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(child: Text('Item #$index')),
    );
  },
)
```

#### • `ExpressiveFab` & `ExpressiveFabMenu`
Floating action buttons and expandable action speed dials:

```dart
// Standard FAB
ExpressiveFab(
  icon: const HugeIcon(icon: HugeIcons.strokeRoundedPlusSign),
  label: 'New Task',
  isExtended: true,
  onPressed: () {},
)

// Expandable Speed Dial Menu
ExpressiveFabMenu(
  icon: const HugeIcon(icon: HugeIcons.strokeRoundedPlusSign),
  activeIcon: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01),
  items: [
    ExpressiveFabMenuItem(
      label: 'Document',
      icon: const HugeIcon(icon: HugeIcons.strokeRoundedFile01),
      onTap: () {},
    ),
    ExpressiveFabMenuItem(
      label: 'Camera',
      icon: const HugeIcon(icon: HugeIcons.strokeRoundedCamera01),
      onTap: () {},
    ),
  ],
)
```

---

## 5. Migration & Replacement Guide

When auditing or refactoring an existing Flutter project, use the following mapping table to replace legacy widgets:

| Legacy Widget | `expressive_kit` Equivalent | Key Upgrades |
| :--- | :--- | :--- |
| `ElevatedButton` / `FilledButton` | `ExpressiveButton(variant: ExpressiveButtonVariant.filled)` | 24dp pill shape, spring feedback, `isLoading` support |
| `OutlinedButton` | `ExpressiveButton(variant: ExpressiveButtonVariant.outlined)` | Expressive border stroke & press animation |
| `TextButton` | `ExpressiveButton(variant: ExpressiveButtonVariant.tonal)` | Subtle tonal container background |
| `IconButton` | `ExpressiveIconButton.circle(...)` or `.squircle(...)` | Pill/squircle geometry, built-in badge counter/dot |
| `SegmentedButton` | `ExpressiveButtonGroup<T>(...)` | Spring-physics sliding background pill |
| `CircularProgressIndicator` | `ExpressiveLoadingIndicator.circular(isWavy: true)` | Sinusoidal wavy animation |
| `LinearProgressIndicator` | `ExpressiveLoadingIndicator.linear(isWavy: true)` | Wavy path with track gap spacing |
| `Switch` / `CupertinoSwitch` | `ExpressiveSwitch(...)` | Tactile spring drag, inner icon badges |
| `Slider` | `ExpressiveSlider(...)` | Floating callout, custom step intervals, spring snap |
| `AppBar` | `ExpressiveTopAppBar(...)` | 28dp bottom curves, integrated subtitle, badge icons |
| `NavigationBar` / `BottomNavigationBar` | `ExpressiveNavigationBar(...)` | Dynamic pill indicator, badge counters |
| `ListTile` | `ExpressiveListTile(...)` | Tonal container, rounded edges, haptic feedback |
| `Card` / Multiple `Card`s | `ExpressiveCardGroup(children: [...])` | Unified rounded container with internal dividers |
| `PageView.builder` (Carousels) | `ExpressiveCarousel(...)` | Automatic neighbor peeking and M3 carousel physics |
| `FloatingActionButton` | `ExpressiveFab(...)` or `ExpressiveFabMenu(...)` | Organic shape, spring expand menu |
| `TextField` (search bar) | `ExpressiveSearchBar(...)` | Built-in clear button, custom icons, pill shape |
| `ThemeData(...)` | `ExpressiveTheme.light(...)` / `.dark(...)` | Automatic M3 expressive color schemes & elevation |
| `GoogleFonts.xxx()` | `ExpressiveFonts.xxx` | Zero-network bundled variable font assets |
| `Icon(Icons.xxx)` | `HugeIcon(icon: HugeIcons.xxx)` | Clean, cohesive iconography across all devices |

### Migration Checklist for Existing Projects:

1. **Update `pubspec.yaml`**:
   Add `expressive_kit` and `hugeicons`. Remove redundant icon sets if applicable.
2. **Global Theme Replacement**:
   Open `main.dart` or your theme definition file and replace `ThemeData` with `ExpressiveTheme.light` and `ExpressiveTheme.dark`. Select an appropriate font from `ExpressiveFonts` (such as `ExpressiveFonts.googleSansFlex`).
3. **Migrate Icons**:
   Locate all instances of `Icons.<name>` and replace with `HugeIcon(icon: HugeIcons.<name>)`.
4. **Transform Containers & Cards**:
   Replace loose `Card(child: ListTile(...))` lists with `ExpressiveCardGroup` to provide cohesive rounded grouped surfaces.
5. **Elevate Feedback & Loading States**:
   Replace plain spinners with `ExpressiveLoadingIndicator.circular(isWavy: true)` or buttons with `ExpressiveButton(isLoading: isSubmitting)`.

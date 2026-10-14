## 0.0.3

* **Widgets & Enhancements**:
  * Fixed destination transition flicker in `ExpressiveNavigationBar` by transitioning color alpha directly (`activeIndicator.withValues(alpha: ...)`) rather than lerping to `Colors.transparent`.
  * Prevented color overshoots and white flashes in `ExpressiveNavigationBar` pill indicators by adopting `Curves.easeOutCubic`.
  * Added synchronized icon color tweening (`TweenAnimationBuilder<Color?>`) and smooth cross-fading for `selectedIcon` (`AnimatedSwitcher`).
  * Updated `ExpressiveNavigationBar` widget tests to maintain **100.0% line coverage** across all library source files.
* **AI Agent Skill**:
  * Added [`SKILL.md`](SKILL.md) (in repository root and `.agents/skills/expressive-kit/`) as an actionable guide for AI coding assistants (Antigravity, Cursor, Windsurf, Claude Code, GitHub Copilot).
  * Included complete component usage patterns, theme and variable font configurations, and a comprehensive widget-by-widget migration guide from standard Material/Cupertino to `expressive_kit`.
* **Documentation & Examples**:
  * Added dedicated interactive Typography tab in `example/lib/main.dart` showcasing all 9 bundled variable font specimens (`ExpressiveFonts`), live custom text preview, optical weight variations, and live global theme font switching.
  * Refined input field prefix icon sizing in `example/lib/main.dart` for visual precision.
  * Added `screenshots/fonts_components.png` and updated `README.md` with Section 5 "Typography & Variable Fonts".
  * Updated `README.md` with instructions on utilizing the AI agent skill and bumped installation version to `^0.0.3`.

## 0.0.2

* **Typography & Fonts**:
  * Added `ExpressiveFonts` utility with package-prefixed family constants and `getAvailableFonts()` lookup.
  * Bundled 9 curated variable fonts: Google Sans Flex, Merriweather, Montserrat, Nunito, Open Sans, Orbitron, Playfair Display, Roboto, and Source Code Pro.
  * Set `ExpressiveFonts.googleSansFlex` as default typography in `ExpressiveTheme.light()` and `ExpressiveTheme.dark()`.
  * Added comprehensive unit test coverage for typography utilities.
* **Icons Ecosystem**:
  * Fully unified icon ecosystem using `hugeicons: ^1.2.0` across all components and gallery example.
* **Documentation & Examples**:
  * Overhauled `README.md` with comprehensive English documentation, component showcases, and UI screenshots.
* **CI/CD & Automation**:
  * Configured automated pub.dev publishing via GitHub Actions with OpenID Connect (OIDC) token authentication on semantic release tags (`v*`).

## 0.0.1

* **Initial release of `expressive_kit`** — A cohesive Flutter design system implementing Material 3 Expressive guidelines.
* **Buttons & Actions**:
  * Added `ExpressiveButton` with filled, tonal, outlined variants, loading indicator, and full-width mode.
  * Added `ExpressiveSplitButton` with primary action and contextual trailing dropdown.
  * Added `ExpressiveButtonGroup` segmented picker with continuous sliding pill indicator.
  * Added `ExpressiveIconButton` supporting circle, squircle, and rounded rectangle shapes with badge/dot options.
* **Navigation**:
  * Added `ExpressiveNavigationBar` with animated pill selector, icon morphing, and badge dots.
  * Added `ExpressiveTopAppBar` with standard and large heading variants (`ExpressiveTopAppBar.large`).
  * Added `ExpressiveFabMenu` expandable floating speed dial menu.
  * Added `ExpressiveFab` in small (44dp), regular (56dp), large (80dp) sizes and `ExpressiveExtendedFab`.
* **Controls & Inputs**:
  * Added `ExpressiveSwitch` with capsule track and animated thumb check/cross icons.
  * Added `ExpressiveSlider` with thick capsule tracks and active progress feedback.
  * Added `ExpressiveSearchBar` 28dp pill container with trailing action slots and read-only mode.
* **Layout & Content**:
  * Added `ExpressiveCardGroup`, `ExpressiveListTile`, and `ExpressiveBadge` for Pixel Settings-style lists.
  * Added `ExpressiveCard` with 24dp adaptive corners and tactile touch reaction.
  * Added `ExpressiveCarousel` multi-browse horizontal scrolling with spring physics.
* **Progress & Motion**:
  * Added `ExpressiveLinearProgressIndicator` and `ExpressiveCircularProgressIndicator` with sinusoidal wavy paths (determinate and indeterminate).
  * Added `ExpressiveMotion` tokens (`springBouncy`, `springGentle`, `emphasized`).
  * Added `ExpressivePressable` for physical tactile compression on tap.
* **Theme & Typography**:
  * Added `ExpressiveTheme.light()` and `ExpressiveTheme.dark()` generators.
  * Added `ExpressiveFonts` with 9 bundled variable font families (Google Sans Flex, Merriweather, Montserrat, Nunito, Open Sans, Orbitron, Playfair Display, Roboto, Source Code Pro).

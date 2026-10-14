import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Destino de navegación para [ExpressiveNavigationBar].
class ExpressiveNavigationDestination {
  const ExpressiveNavigationDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badgeText,
    this.showBadgeDot = false,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
  final String? badgeText;
  final bool showBadgeDot;
}

/// Barra de navegación inferior de Material 3 Expressive con indicador activo
/// en píldora, transiciones con física de resorte y elevación tonal.
class ExpressiveNavigationBar extends StatelessWidget {
  const ExpressiveNavigationBar({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.backgroundColor,
    this.indicatorColor,
    this.height = 80,
    super.key,
  }) : assert(
         selectedIndex >= 0 && selectedIndex < destinations.length,
         'selectedIndex must be between 0 and destinations.length - 1',
       );

  final List<ExpressiveNavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bg = backgroundColor ?? colorScheme.surfaceContainer;
    final activeIndicator = indicatorColor ?? colorScheme.secondaryContainer;

    return Container(
      height: height,
      color: bg,
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(destinations.length, (index) {
            final destination = destinations[index];
            final isSelected = index == selectedIndex;

            final targetIconColor = isSelected
                ? colorScheme.onSecondaryContainer
                : colorScheme.onSurfaceVariant;

            final baseIcon = destination.selectedIcon != null
                ? AnimatedSwitcher(
                    duration: ExpressiveMotion.durationShort,
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: KeyedSubtree(
                      key: ValueKey(isSelected),
                      child: isSelected
                          ? destination.selectedIcon!
                          : destination.icon,
                    ),
                  )
                : destination.icon;

            Widget iconWidget = TweenAnimationBuilder<Color?>(
              duration: ExpressiveMotion.durationShort,
              curve: Curves.easeOutCubic,
              tween: ColorTween(end: targetIconColor),
              builder: (context, animatedColor, child) {
                return IconTheme(
                  data: IconThemeData(color: animatedColor, size: 24),
                  child: child!,
                );
              },
              child: baseIcon,
            );

            if (destination.showBadgeDot || destination.badgeText != null) {
              iconWidget = Stack(
                clipBehavior: Clip.none,
                children: [
                  iconWidget,
                  Positioned(
                    top: -2,
                    right: -4,
                    child: destination.showBadgeDot
                        ? Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              destination.badgeText!,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onError,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ],
              );
            }

            return Expanded(
              child: ExpressivePressable(
                onTap: () => onDestinationSelected(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 64,
                      height: 32,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedContainer(
                            duration: ExpressiveMotion.durationShort,
                            curve: Curves.easeOutCubic,
                            width: isSelected ? 64 : 0,
                            height: 32,
                            decoration: BoxDecoration(
                              color: activeIndicator.withValues(
                                alpha: isSelected ? 1.0 : 0.0,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          Center(child: iconWidget),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: ExpressiveMotion.durationShort,
                      curve: Curves.easeOutCubic,
                      style:
                          theme.textTheme.labelMedium?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? colorScheme.onSurface
                                : colorScheme.onSurfaceVariant,
                          ) ??
                          const TextStyle(),
                      child: Text(
                        destination.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

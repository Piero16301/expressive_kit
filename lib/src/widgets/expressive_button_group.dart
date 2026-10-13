import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Elemento para un grupo de botones [ExpressiveButtonGroup].
class ExpressiveButtonGroupItem<T> {
  const ExpressiveButtonGroupItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final Widget? icon;
}

/// Grupo de botones conectados de Material 3 Expressive con animación elástica
/// e indicador de selección continuo en píldora.
class ExpressiveButtonGroup<T> extends StatelessWidget {
  const ExpressiveButtonGroup({
    required this.items,
    required this.selectedValue,
    required this.onSelected,
    this.height = 48,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.isExpanded = true,
    super.key,
  });

  final List<ExpressiveButtonGroupItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onSelected;
  final double height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final radius = borderRadius ?? BorderRadius.circular(height / 2);
    final bg = backgroundColor ?? colorScheme.surfaceContainer;
    final activeBg = selectedColor ?? colorScheme.secondaryContainer;
    final pillRadius = BorderRadius.circular((height - 8) / 2);
    final count = items.length;
    final selectedIndex = items.indexWhere(
      (item) => item.value == selectedValue,
    );

    if (isExpanded) {
      final effectiveIndex = selectedIndex >= 0 ? selectedIndex : 0;

      return Container(
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: bg, borderRadius: radius),
        child: Stack(
          children: [
            if (count > 0 && selectedIndex >= 0)
              AnimatedAlign(
                duration: ExpressiveMotion.durationMedium,
                curve: ExpressiveMotion.springBouncy,
                alignment: Alignment(
                  count > 1 ? -1.0 + (2.0 * effectiveIndex / (count - 1)) : 0.0,
                  0.0,
                ),
                child: FractionallySizedBox(
                  widthFactor: 1.0 / count,
                  heightFactor: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: activeBg,
                      borderRadius: pillRadius,
                    ),
                  ),
                ),
              ),
            Row(
              children: List.generate(count, (index) {
                final item = items[index];
                final isSelected = index == selectedIndex;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onSelected(item.value),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.icon != null) ...[
                            IconTheme(
                              data: IconThemeData(
                                color: isSelected
                                    ? colorScheme.onSecondaryContainer
                                    : colorScheme.onSurfaceVariant,
                                size: 18,
                              ),
                              child: item.icon!,
                            ),
                            const SizedBox(width: 8),
                          ],
                          AnimatedDefaultTextStyle(
                            duration: ExpressiveMotion.durationShort,
                            curve: Curves.easeInOut,
                            style:
                                (theme.textTheme.labelMedium ??
                                        const TextStyle())
                                    .copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? colorScheme.onSecondaryContainer
                                          : colorScheme.onSurfaceVariant,
                                    ),
                            child: Text(item.label),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    }

    final transparentActive = activeBg.withValues(alpha: 0);

    return Container(
      height: height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: bg, borderRadius: radius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final isSelected = item.value == selectedValue;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelected(item.value),
            child: AnimatedContainer(
              duration: ExpressiveMotion.durationShort,
              curve: Curves.easeInOut,
              height: height - 8,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? activeBg : transparentActive,
                borderRadius: pillRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: isSelected
                            ? colorScheme.onSecondaryContainer
                            : colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                      child: item.icon!,
                    ),
                    const SizedBox(width: 8),
                  ],
                  AnimatedDefaultTextStyle(
                    duration: ExpressiveMotion.durationShort,
                    curve: Curves.easeInOut,
                    style: (theme.textTheme.labelMedium ?? const TextStyle())
                        .copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? colorScheme.onSecondaryContainer
                              : colorScheme.onSurfaceVariant,
                        ),
                    child: Text(item.label),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

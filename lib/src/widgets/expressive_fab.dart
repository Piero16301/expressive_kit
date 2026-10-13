import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Tamaño para [ExpressiveFab].
enum ExpressiveFabSize {
  small(size: 44, iconSize: 20, borderRadius: 14),
  regular(size: 56, iconSize: 24, borderRadius: 18),
  large(size: 96, iconSize: 36, borderRadius: 28);

  const ExpressiveFabSize({
    required this.size,
    required this.iconSize,
    required this.borderRadius,
  });

  final double size;
  final double iconSize;
  final double borderRadius;
}

/// Floating Action Button de Material 3 Expressive con formas squircle
/// adaptativas, variantes de color tonal y física de rebote.
class ExpressiveFab extends StatelessWidget {
  const ExpressiveFab({
    required this.icon,
    this.onPressed,
    this.size = ExpressiveFabSize.regular,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 3,
    this.tooltip,
    super.key,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final ExpressiveFabSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = onPressed != null;

    final bg =
        backgroundColor ??
        (isEnabled
            ? colorScheme.primaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.12));
    final fg =
        foregroundColor ??
        (isEnabled
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.38));

    final button = Material(
      color: Colors.transparent,
      child: Container(
        width: size.size,
        height: size.size,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(size.borderRadius),
          boxShadow: elevation > 0 && isEnabled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: elevation * 2,
                    offset: Offset(0, elevation),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(color: fg, size: size.iconSize),
            child: icon,
          ),
        ),
      ),
    );

    final interactive = ExpressivePressable(
      enabled: isEnabled,
      onTap: onPressed,
      child: button,
    );

    return tooltip != null
        ? Tooltip(message: tooltip, child: interactive)
        : interactive;
  }
}

/// Extended Floating Action Button de Material 3 Expressive con etiqueta e
/// icono.
class ExpressiveExtendedFab extends StatelessWidget {
  const ExpressiveExtendedFab({
    required this.label,
    required this.icon,
    this.onPressed,
    this.height = 56,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 3,
    this.tooltip,
    super.key,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = onPressed != null;

    final bg =
        backgroundColor ??
        (isEnabled
            ? colorScheme.primaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.12));
    final fg =
        foregroundColor ??
        (isEnabled
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.38));

    final button = Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: elevation > 0 && isEnabled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(color: fg, size: 24),
            child: icon,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );

    final interactive = ExpressivePressable(
      enabled: isEnabled,
      onTap: onPressed,
      child: button,
    );

    return tooltip != null
        ? Tooltip(message: tooltip, child: interactive)
        : interactive;
  }
}

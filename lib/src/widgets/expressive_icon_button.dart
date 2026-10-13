import 'package:material_ui/material_ui.dart';

/// Formas para [ExpressiveIconButton].
enum ExpressiveIconButtonShape { circle, squircle, roundedRectangle }

/// Variantes visuales para [ExpressiveIconButton].
enum ExpressiveIconButtonVariant { standard, tonal, filled, outlined }

/// Tamaño para [ExpressiveIconButton].
enum ExpressiveIconButtonSize {
  small(diameter: 36, iconSize: 18),
  medium(diameter: 44, iconSize: 22),
  large(diameter: 52, iconSize: 26);

  const ExpressiveIconButtonSize({
    required this.diameter,
    required this.iconSize,
  });

  final double diameter;
  final double iconSize;
}

/// Botón de icono de Material 3 Expressive que utiliza el motor nativo de
/// [IconButton] de Flutter, garantizando el comportamiento exacto de pulsación,
/// ripple, capa de estado y accesibilidad de Material Design.
class ExpressiveIconButton extends StatelessWidget {
  const ExpressiveIconButton({
    required this.icon,
    this.onPressed,
    this.shape = ExpressiveIconButtonShape.circle,
    this.variant = ExpressiveIconButtonVariant.standard,
    this.size = ExpressiveIconButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.badgeText,
    this.showBadgeDot = false,
    super.key,
  });

  const ExpressiveIconButton.circle({
    required this.icon,
    this.onPressed,
    this.variant = ExpressiveIconButtonVariant.standard,
    this.size = ExpressiveIconButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.badgeText,
    this.showBadgeDot = false,
    super.key,
  }) : shape = ExpressiveIconButtonShape.circle;

  const ExpressiveIconButton.squircle({
    required this.icon,
    this.onPressed,
    this.variant = ExpressiveIconButtonVariant.standard,
    this.size = ExpressiveIconButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.badgeText,
    this.showBadgeDot = false,
    super.key,
  }) : shape = ExpressiveIconButtonShape.squircle;

  final Widget icon;
  final VoidCallback? onPressed;
  final ExpressiveIconButtonShape shape;
  final ExpressiveIconButtonVariant variant;
  final ExpressiveIconButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;
  final String? badgeText;
  final bool showBadgeDot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = onPressed != null;

    Color defaultBg;
    Color defaultFg;
    var border = BorderSide.none;

    switch (variant) {
      case ExpressiveIconButtonVariant.standard:
        defaultBg = Colors.transparent;
        defaultFg = isEnabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurface.withValues(alpha: 0.38);
      case ExpressiveIconButtonVariant.tonal:
        defaultBg = isEnabled
            ? colorScheme.surfaceContainerHigh
            : colorScheme.onSurface.withValues(alpha: 0.12);
        defaultFg = isEnabled
            ? colorScheme.onSurface
            : colorScheme.onSurface.withValues(alpha: 0.38);
      case ExpressiveIconButtonVariant.filled:
        defaultBg = isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.12);
        defaultFg = isEnabled
            ? colorScheme.onPrimary
            : colorScheme.onSurface.withValues(alpha: 0.38);
      case ExpressiveIconButtonVariant.outlined:
        defaultBg = Colors.transparent;
        defaultFg = isEnabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurface.withValues(alpha: 0.38);
        border = BorderSide(
          color: isEnabled
              ? colorScheme.outline
              : colorScheme.onSurface.withValues(alpha: 0.12),
        );
    }

    final bg = backgroundColor ?? defaultBg;
    final fg = foregroundColor ?? defaultFg;

    OutlinedBorder outlinedShape;
    switch (shape) {
      case ExpressiveIconButtonShape.circle:
        outlinedShape = const CircleBorder();
      case ExpressiveIconButtonShape.squircle:
        outlinedShape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.diameter * 0.32),
        );
      case ExpressiveIconButtonShape.roundedRectangle:
        outlinedShape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        );
    }

    Widget button = IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: size.iconSize,
      style: IconButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        disabledBackgroundColor:
            variant == ExpressiveIconButtonVariant.filled ||
                variant == ExpressiveIconButtonVariant.tonal
            ? colorScheme.onSurface.withValues(alpha: 0.12)
            : Colors.transparent,
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
        shape: outlinedShape,
        side: border != BorderSide.none ? border : null,
        minimumSize: Size.square(size.diameter),
        fixedSize: Size.square(size.diameter),
        maximumSize: Size.square(size.diameter),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: icon,
    );

    if (showBadgeDot || badgeText != null) {
      button = Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            top: 2,
            right: 2,
            child: showBadgeDot
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badgeText!,
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

    return button;
  }
}

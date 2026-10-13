import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Componente Split Button de Material 3 Expressive que combina una acción
/// primaria y una acción secundaria / menú desplegable dentro de una silueta
/// continua.
class ExpressiveSplitButton extends StatelessWidget {
  const ExpressiveSplitButton({
    required this.label,
    required this.onPressed,
    required this.onTrailingPressed,
    this.variant = ExpressiveButtonVariant.filled,
    this.size = ExpressiveButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon = const HugeIcon(
      icon: HugeIcons.strokeRoundedArrowDown01,
    ),
    this.borderRadius,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onTrailingPressed;
  final ExpressiveButtonVariant variant;
  final ExpressiveButtonSize size;
  final Widget? leadingIcon;
  final Widget trailingIcon;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = onPressed != null || onTrailingPressed != null;

    Color bg;
    Color fg;
    Color dividerColor;
    var border = BorderSide.none;

    switch (variant) {
      case ExpressiveButtonVariant.filled:
        bg = isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.12);
        fg = isEnabled
            ? colorScheme.onPrimary
            : colorScheme.onSurface.withValues(alpha: 0.38);
        dividerColor = fg.withValues(alpha: 0.25);
      case ExpressiveButtonVariant.tonal:
        bg = isEnabled
            ? colorScheme.secondaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.12);
        fg = isEnabled
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.38);
        dividerColor = fg.withValues(alpha: 0.25);
      case ExpressiveButtonVariant.elevated:
        bg = isEnabled
            ? colorScheme.surfaceContainerLow
            : colorScheme.onSurface.withValues(alpha: 0.12);
        fg = isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38);
        dividerColor = fg.withValues(alpha: 0.25);
      case ExpressiveButtonVariant.outlined:
        bg = Colors.transparent;
        fg = isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38);
        border = BorderSide(
          color: isEnabled
              ? colorScheme.outline
              : colorScheme.onSurface.withValues(alpha: 0.12),
        );
        dividerColor = isEnabled
            ? colorScheme.outline
            : colorScheme.onSurface.withValues(alpha: 0.12);
      case ExpressiveButtonVariant.text:
        bg = Colors.transparent;
        fg = isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38);
        dividerColor = fg.withValues(alpha: 0.25);
    }

    final radius = borderRadius ?? BorderRadius.circular(size.height / 2);

    return Material(
      color: Colors.transparent,
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: border != BorderSide.none
              ? Border.fromBorderSide(border)
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ExpressivePressable(
                enabled: onPressed != null,
                onTap: onPressed,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.horizontalPadding,
                    right: size.horizontalPadding * 0.75,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (leadingIcon != null) ...[
                        IconTheme(
                          data: IconThemeData(color: fg, size: size.iconSize),
                          child: leadingIcon!,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        label,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: size.fontSize,
                          fontWeight: FontWeight.w600,
                          color: fg,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: dividerColor,
                indent: 8,
                endIndent: 8,
              ),
              ExpressivePressable(
                enabled: onTrailingPressed != null,
                onTap: onTrailingPressed,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.horizontalPadding * 0.6,
                  ),
                  child: IconTheme(
                    data: IconThemeData(color: fg, size: size.iconSize),
                    child: trailingIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Variantes de estilo para [ExpressiveButton].
enum ExpressiveButtonVariant { filled, tonal, elevated, outlined, text }

/// Tamaños oficiales definidos en Material 3 Expressive.
enum ExpressiveButtonSize {
  extraSmall(height: 32, iconSize: 16, horizontalPadding: 12, fontSize: 12),
  small(height: 40, iconSize: 18, horizontalPadding: 16, fontSize: 13),
  medium(height: 48, iconSize: 20, horizontalPadding: 20, fontSize: 14),
  large(height: 56, iconSize: 24, horizontalPadding: 24, fontSize: 16),
  extraLarge(height: 64, iconSize: 28, horizontalPadding: 28, fontSize: 18);

  const ExpressiveButtonSize({
    required this.height,
    required this.iconSize,
    required this.horizontalPadding,
    required this.fontSize,
  });

  final double height;
  final double iconSize;
  final double horizontalPadding;
  final double fontSize;
}

/// Botón Material 3 Expressive con soporte para 5 tamaños, esquinas redondeadas
/// en píldora continua y retroalimentación táctil de física elástica.
class ExpressiveButton extends StatelessWidget {
  const ExpressiveButton({
    required this.label,
    this.onPressed,
    this.variant = ExpressiveButtonVariant.filled,
    this.size = ExpressiveButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  const ExpressiveButton.filled({
    required this.label,
    this.onPressed,
    this.size = ExpressiveButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  }) : variant = ExpressiveButtonVariant.filled;

  const ExpressiveButton.tonal({
    required this.label,
    this.onPressed,
    this.size = ExpressiveButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  }) : variant = ExpressiveButtonVariant.tonal;

  const ExpressiveButton.outlined({
    required this.label,
    this.onPressed,
    this.size = ExpressiveButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  }) : variant = ExpressiveButtonVariant.outlined;

  const ExpressiveButton.elevated({
    required this.label,
    this.onPressed,
    this.size = ExpressiveButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  }) : variant = ExpressiveButtonVariant.elevated;

  const ExpressiveButton.text({
    required this.label,
    this.onPressed,
    this.size = ExpressiveButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isExpanded = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  }) : variant = ExpressiveButtonVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final ExpressiveButtonVariant variant;
  final ExpressiveButtonSize size;
  final Widget? icon;
  final Widget? trailingIcon;
  final bool isLoading;
  final bool isExpanded;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color defaultBg;
    Color defaultFg;
    var border = BorderSide.none;
    double elevation = 0;

    switch (variant) {
      case ExpressiveButtonVariant.filled:
        defaultBg = _isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.12);
        defaultFg = _isEnabled
            ? colorScheme.onPrimary
            : colorScheme.onSurface.withValues(alpha: 0.38);
      case ExpressiveButtonVariant.tonal:
        defaultBg = _isEnabled
            ? colorScheme.secondaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.12);
        defaultFg = _isEnabled
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurface.withValues(alpha: 0.38);
      case ExpressiveButtonVariant.elevated:
        defaultBg = _isEnabled
            ? colorScheme.surfaceContainerLow
            : colorScheme.onSurface.withValues(alpha: 0.12);
        defaultFg = _isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38);
        elevation = _isEnabled ? 1 : 0;
      case ExpressiveButtonVariant.outlined:
        defaultBg = Colors.transparent;
        defaultFg = _isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38);
        border = BorderSide(
          color: _isEnabled
              ? colorScheme.outline
              : colorScheme.onSurface.withValues(alpha: 0.12),
        );
      case ExpressiveButtonVariant.text:
        defaultBg = Colors.transparent;
        defaultFg = _isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38);
    }

    final effectiveBg = backgroundColor ?? defaultBg;
    final effectiveFg = foregroundColor ?? defaultFg;
    final effectiveRadius =
        borderRadius ?? BorderRadius.circular(size.height / 2);

    final content = AnimatedContainer(
      duration: ExpressiveMotion.durationShort,
      curve: ExpressiveMotion.springGentle,
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: size.horizontalPadding),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: border != BorderSide.none
            ? Border.fromBorderSide(border)
            : null,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            SizedBox(
              width: size.iconSize,
              height: size.iconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: effectiveFg,
              ),
            ),
            const SizedBox(width: 8),
          ] else if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: effectiveFg, size: size.iconSize),
              child: icon!,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: size.fontSize,
                fontWeight: FontWeight.w600,
                color: effectiveFg,
              ),
            ),
          ),
          if (trailingIcon != null && !isLoading) ...[
            const SizedBox(width: 8),
            IconTheme(
              data: IconThemeData(color: effectiveFg, size: size.iconSize),
              child: trailingIcon!,
            ),
          ],
        ],
      ),
    );

    return ExpressivePressable(
      enabled: _isEnabled,
      onTap: onPressed,
      borderRadius: effectiveRadius,
      child: isExpanded
          ? SizedBox(width: double.infinity, child: content)
          : content,
    );
  }
}

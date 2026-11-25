import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Badge circular icónico de Material 3 Expressive con fondo de color vibrante,
/// como se observa en la lista principal de Ajustes de Pixel.
class ExpressiveBadge extends StatelessWidget {
  const ExpressiveBadge({
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 40,
    this.iconSize = 20,
    super.key,
  });

  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? colorScheme.primaryContainer;
    final fg = foregroundColor ?? colorScheme.onPrimaryContainer;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Center(
        child: IconTheme(
          data: IconThemeData(color: fg, size: iconSize),
          child: icon,
        ),
      ),
    );
  }
}

/// Elemento de lista (ListTile) de Material 3 Expressive que soporta:
/// - Leading badge icónico con color dinámico
/// - Título y subtítulo con tipografía adaptativa
/// - Trailing estándar (chevron, texto de estado, etc.)
/// - Acción dividida (Split action con chevron + divisor + switch) como en
/// "Tema oscuro".
/// - Hoja modal inferior integrada mediante [ExpressiveListTile.modal].
class ExpressiveListTile extends StatelessWidget {
  const ExpressiveListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.secondaryTrailing,
    this.showSplitDivider = false,
    this.onTap,
    this.onSecondaryTap,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.enabled = true,
    super.key,
  }) : _modalTitle = null,
       _modalItemsBuilder = null,
       _modalBuilder = null,
       _modalMaxHeightFraction = 0.65,
       _modalBackgroundColor = null,
       _showModalDragHandle = true,
       _showChevron = false;

  /// Constructor que abre automáticamente un [showExpressiveModalBottomSheet]
  /// al tocar el elemento. Ideal para filas de configuración agrupadas dentro
  /// de un [ExpressiveCardGroup].
  const ExpressiveListTile.modal({
    required this.title,
    this._modalTitle,
    List<Widget> Function(BuildContext modalContext)? modalItemsBuilder,
    WidgetBuilder? modalBuilder,
    this.subtitle,
    this.leading,
    this.trailing,
    this._showChevron = true,
    double maxHeightFraction = 0.65,
    this._modalBackgroundColor,
    bool showDragHandle = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.enabled = true,
    super.key,
  }) : assert(
         modalItemsBuilder != null || modalBuilder != null,
         'Must provide either modalItemsBuilder or modalBuilder.',
       ),
       assert(
         maxHeightFraction > 0 && maxHeightFraction <= 1,
         'maxHeightFraction must be between 0 (exclusive) and 1 (inclusive).',
       ),
       secondaryTrailing = null,
       showSplitDivider = false,
       onTap = null,
       onSecondaryTap = null,
       _modalItemsBuilder = modalItemsBuilder,
       _modalBuilder = modalBuilder,
       _modalMaxHeightFraction = maxHeightFraction,
       _showModalDragHandle = showDragHandle;

  /// Constructor con switch integrado en la posición trailing.
  factory ExpressiveListTile.switchTile({
    required Widget title,
    required bool value,
    required ValueChanged<bool>? onChanged,
    Widget? subtitle,
    Widget? leading,
    VoidCallback? onTap,
    bool showChevronWithSwitch = false,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    Key? key,
  }) {
    if (showChevronWithSwitch) {
      return ExpressiveListTile(
        key: key,
        title: title,
        subtitle: subtitle,
        leading: leading,
        contentPadding: contentPadding,
        onTap: onTap,
        showSplitDivider: true,
        trailing: const HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          size: 20,
        ),
        secondaryTrailing: ExpressiveSwitch(value: value, onChanged: onChanged),
      );
    }

    return ExpressiveListTile(
      key: key,
      title: title,
      subtitle: subtitle,
      leading: leading,
      contentPadding: contentPadding,
      onTap: onChanged != null ? () => onChanged(!value) : null,
      trailing: ExpressiveSwitch(value: value, onChanged: onChanged),
    );
  }

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? secondaryTrailing;
  final bool showSplitDivider;
  final VoidCallback? onTap;
  final VoidCallback? onSecondaryTap;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;
  final String? _modalTitle;
  final List<Widget> Function(BuildContext modalContext)? _modalItemsBuilder;
  final WidgetBuilder? _modalBuilder;
  final double _modalMaxHeightFraction;
  final Color? _modalBackgroundColor;
  final bool _showModalDragHandle;
  final bool _showChevron;

  bool get _hasModal => _modalItemsBuilder != null || _modalBuilder != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveOnTap = _hasModal
        ? () => showExpressiveModalBottomSheet<void>(
            context: context,
            title: _modalTitle,
            itemsBuilder: _modalItemsBuilder,
            builder: _modalBuilder,
            maxHeightFraction: _modalMaxHeightFraction,
            backgroundColor: _modalBackgroundColor,
            showDragHandle: _showModalDragHandle,
          )
        : onTap;

    final Widget? effectiveTrailing;
    if (_showChevron) {
      final chevron = HugeIcon(
        icon: HugeIcons.strokeRoundedArrowRight01,
        size: 20,
        color: enabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurface.withValues(alpha: 0.38),
      );
      effectiveTrailing = trailing != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [trailing!, const SizedBox(width: 8), chevron],
            )
          : chevron;
    } else {
      effectiveTrailing = trailing;
    }

    Widget mainTile = Padding(
      padding: contentPadding,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 16)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                  style:
                      theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: enabled
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withValues(alpha: 0.38),
                      ) ??
                      const TextStyle(),
                  child: title,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  DefaultTextStyle(
                    style:
                        theme.textTheme.bodyMedium?.copyWith(
                          color: enabled
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface.withValues(alpha: 0.38),
                        ) ??
                        const TextStyle(),
                    child: subtitle!,
                  ),
                ],
              ],
            ),
          ),
          if (effectiveTrailing != null && !showSplitDivider) ...[
            const SizedBox(width: 12),
            effectiveTrailing,
          ],
        ],
      ),
    );

    if (effectiveOnTap != null && enabled) {
      mainTile = ExpressivePressable(onTap: effectiveOnTap, child: mainTile);
    }

    if (showSplitDivider && trailing != null && secondaryTrailing != null) {
      return IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: mainTile),
            if (trailing != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: trailing,
              ),
            ],
            VerticalDivider(
              width: 16,
              thickness: 1,
              indent: 12,
              endIndent: 12,
              color: colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 4),
              child: Center(child: secondaryTrailing),
            ),
          ],
        ),
      );
    }

    return mainTile;
  }
}

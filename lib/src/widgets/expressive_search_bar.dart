import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Barra de búsqueda de Material 3 Expressive como se muestra en la captura de
/// Pixel ("Buscar ajustes"): forma continua en píldora de 28dp, superficie
/// tonal elevada e integración con iconos de búsqueda y micrófono/avatar.
class ExpressiveSearchBar extends StatelessWidget {
  const ExpressiveSearchBar({
    this.hintText = 'Buscar ajustes',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.leading = const HugeIcon(icon: HugeIcons.strokeRoundedSearch01),
    this.trailing,
    this.height = 56,
    this.backgroundColor,
    this.foregroundColor,
    this.readOnly = false,
    this.autoFocus = false,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    super.key,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool readOnly;
  final bool autoFocus;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bg = backgroundColor ?? colorScheme.surfaceContainerHigh;
    final fg = foregroundColor ?? colorScheme.onSurfaceVariant;

    final container = Container(
      height: height,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: 24),
              child: leading!,
            ),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: readOnly
                ? Text(
                    hintText,
                    style: theme.textTheme.bodyLarge?.copyWith(color: fg),
                  )
                : TextField(
                    controller: controller,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    onTap: onTap,
                    autofocus: autoFocus,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(color: fg),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 10),
            IconTheme(
              data: IconThemeData(color: fg, size: 24),
              child: trailing!,
            ),
          ],
        ],
      ),
    );

    if (readOnly && onTap != null) {
      return ExpressivePressable(onTap: onTap, child: container);
    }

    return container;
  }
}

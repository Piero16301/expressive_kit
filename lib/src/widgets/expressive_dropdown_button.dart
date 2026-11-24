import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Elemento seleccionable para [ExpressiveDropdownButton].
class ExpressiveDropdownItem<T> {
  const ExpressiveDropdownItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.enabled = true,
  });

  /// Valor asociado a esta opción.
  final T value;

  /// Etiqueta principal mostrada en la hoja modal y como subtítulo del selector
  /// cuando está seleccionada.
  final String label;

  /// Subtítulo opcional mostrado debajo de [label] dentro de la hoja modal.
  final String? subtitle;

  /// Icono opcional (se recomienda `HugeIcon`) mostrado en el badge del selector
  /// y en el elemento dentro de la hoja modal.
  final Widget? icon;

  /// Si esta opción individual puede ser seleccionada.
  final bool enabled;
}

/// Selector desplegable de Material 3 Expressive basado en [ExpressiveCardGroup]
/// y [ExpressiveListTile] que abre un `showModalBottomSheet` redondeado de 28dp
/// para elegir entre [items].
class ExpressiveDropdownButton<T> extends StatelessWidget {
  const ExpressiveDropdownButton({
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.modalTitle,
    this.emptyText,
    this.errorText,
    this.placeholderIcon,
    this.trailingIcon,
    this.selectedIcon,
    this.showBadge = true,
    this.showDragHandle = true,
    this.enabled = true,
    this.maxHeightFraction = 0.65,
    this.margin = EdgeInsets.zero,
    this.borderRadius,
    this.backgroundColor,
    this.modalBackgroundColor,
    this.badgeBackgroundColor,
    this.badgeForegroundColor,
    super.key,
  }) : assert(
         maxHeightFraction > 0 && maxHeightFraction <= 1,
         'maxHeightFraction must be between 0 (exclusive) and 1 (inclusive).',
       );

  /// Título principal del campo selector (ej. "Grupo", "Categoría").
  final String label;

  /// Lista de opciones disponibles en la hoja modal.
  final List<ExpressiveDropdownItem<T>> items;

  /// Callback invocado cuando el usuario selecciona una opción.
  /// Si es nulo, el selector se muestra deshabilitado.
  final ValueChanged<T>? onChanged;

  /// Valor actualmente seleccionado. Debe coincidir con el `value` de alguno de
  /// los [items] o ser `null` si no hay selección.
  final T? value;

  /// Texto de marcador de posición mostrado cuando [value] no coincide con
  /// ningún elemento (ej. "Sin grupo", "Seleccionar opción").
  final String? hintText;

  /// Título mostrado en la parte superior del `showModalBottomSheet`.
  /// Si es nulo, se utiliza [label].
  final String? modalTitle;

  /// Texto opcional mostrado dentro de la hoja modal cuando [items] está vacío.
  final String? emptyText;

  /// Mensaje de error opcional mostrado debajo del contenedor.
  final String? errorText;

  /// Icono mostrado cuando no hay ningún elemento seleccionado o el elemento
  /// seleccionado no tiene icono.
  final Widget? placeholderIcon;

  /// Icono final en el selector. Por defecto usa una flecha derecha de
  /// HugeIcons (`HugeIcons.strokeRoundedArrowRight01`).
  final Widget? trailingIcon;

  /// Icono indicador del elemento seleccionado en la hoja modal. Por defecto
  /// usa `HugeIcons.strokeRoundedCheckmarkCircle02`.
  final Widget? selectedIcon;

  /// Si envuelve el icono principal del selector en un [ExpressiveBadge].
  final bool showBadge;

  /// Si muestra la barra superior de arrastre en la hoja modal.
  final bool showDragHandle;

  /// Si el selector está habilitado.
  final bool enabled;

  /// Fracción máxima de la altura de la pantalla que puede ocupar la hoja
  /// modal (entre 0 y 1). Por defecto `0.65`.
  final double maxHeightFraction;

  /// Margen externo aplicado al [ExpressiveCardGroup].
  final EdgeInsetsGeometry margin;

  /// Radio de esquinas personalizado para el contenedor del selector.
  final BorderRadius? borderRadius;

  /// Color de fondo del contenedor del selector.
  final Color? backgroundColor;

  /// Color de fondo de la hoja modal.
  final Color? modalBackgroundColor;

  /// Color de fondo del [ExpressiveBadge] cuando [showBadge] es `true`.
  final Color? badgeBackgroundColor;

  /// Color de primer plano del [ExpressiveBadge] cuando [showBadge] es `true`.
  final Color? badgeForegroundColor;

  bool get _isInteractive => enabled && onChanged != null;

  ExpressiveDropdownItem<T>? _findSelectedItem() {
    if (value == null) return null;
    for (final item in items) {
      if (item.value == value) return item;
    }
    return null;
  }

  Future<void> _showPickerModal(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final maxHeight = MediaQuery.sizeOf(context).height * maxHeightFraction;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: modalBackgroundColor ?? colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (modalContext) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showDragHandle) ...[
                    Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      modalTitle ?? label,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Text(
                        emptyText ?? hintText ?? '',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: items.map((item) {
                            final isSelected = value == item.value;
                            final itemIconColor = !item.enabled
                                ? colorScheme.onSurface.withValues(alpha: 0.38)
                                : isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant;

                            return ListTile(
                              enabled: item.enabled,
                              leading: item.icon != null
                                  ? IconTheme(
                                      data: IconThemeData(
                                        color: itemIconColor,
                                        size: 24,
                                      ),
                                      child: item.icon!,
                                    )
                                  : null,
                              title: Text(
                                item.label,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: !item.enabled
                                      ? colorScheme.onSurface.withValues(
                                          alpha: 0.38,
                                        )
                                      : isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
                                ),
                              ),
                              subtitle: item.subtitle != null
                                  ? Text(
                                      item.subtitle!,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                    )
                                  : null,
                              trailing: isSelected
                                  ? (selectedIcon ??
                                        HugeIcon(
                                          icon: HugeIcons
                                              .strokeRoundedCheckmarkCircle02,
                                          color: colorScheme.primary,
                                          strokeWidth: 2,
                                        ))
                                  : null,
                              onTap: item.enabled
                                  ? () {
                                      onChanged?.call(item.value);
                                      Navigator.pop(modalContext);
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedItem = _findSelectedItem();
    final effectiveIcon = selectedItem?.icon ?? placeholderIcon;
    final subtitleText = selectedItem?.label ?? hintText;
    final hasError = errorText != null && errorText!.isNotEmpty;

    Widget? leadingWidget;
    if (effectiveIcon != null) {
      leadingWidget = showBadge
          ? ExpressiveBadge(
              icon: effectiveIcon,
              backgroundColor: _isInteractive
                  ? badgeBackgroundColor
                  : colorScheme.onSurface.withValues(alpha: 0.08),
              foregroundColor: _isInteractive
                  ? badgeForegroundColor
                  : colorScheme.onSurface.withValues(alpha: 0.38),
            )
          : IconTheme(
              data: IconThemeData(
                color: _isInteractive
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface.withValues(alpha: 0.38),
                size: 24,
              ),
              child: effectiveIcon,
            );
    }

    final effectiveTrailing =
        trailingIcon ??
        HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          size: 20,
          color: _isInteractive
              ? colorScheme.onSurfaceVariant
              : colorScheme.onSurface.withValues(alpha: 0.38),
        );

    final cardGroup = ExpressiveCardGroup(
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      children: [
        ExpressiveListTile(
          enabled: _isInteractive,
          leading: leadingWidget,
          title: Text(label),
          subtitle: subtitleText != null && subtitleText.isNotEmpty
              ? Text(subtitleText)
              : null,
          trailing: effectiveTrailing,
          onTap: _isInteractive ? () => _showPickerModal(context) : null,
        ),
      ],
    );

    if (!hasError) {
      return cardGroup;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        cardGroup,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
          child: Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

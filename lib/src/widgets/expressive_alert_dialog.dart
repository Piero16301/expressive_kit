import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Muestra un [ExpressiveAlertDialog] con estilos Material 3 Expressive
/// (esquinas de 28dp, ancho adaptable para móvil/web/escritorio y botones
/// [ExpressiveButton]).
Future<T?> showExpressiveAlertDialog<T>({
  required BuildContext context,
  required String title,
  String? content,
  Widget? child,
  Widget? icon,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  String? confirmLabel,
  String? cancelLabel,
  bool showCancelButton = true,
  bool isForm = false,
  bool isDestructive = false,
  bool isConfirmLoading = false,
  ExpressiveButtonVariant confirmVariant = ExpressiveButtonVariant.filled,
  ExpressiveButtonVariant cancelVariant = ExpressiveButtonVariant.outlined,
  double? maxWidth,
  Color? backgroundColor,
  BorderRadius? borderRadius,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (dialogContext) => ExpressiveAlertDialog(
      title: title,
      content: content,
      icon: icon,
      onConfirm: onConfirm ?? () => Navigator.of(dialogContext).pop(true),
      onCancel: onCancel ?? () => Navigator.of(dialogContext).pop(false),
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      showCancelButton: showCancelButton,
      isForm: isForm,
      isDestructive: isDestructive,
      isConfirmLoading: isConfirmLoading,
      confirmVariant: confirmVariant,
      cancelVariant: cancelVariant,
      maxWidth: maxWidth,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
    ),
  );
}

/// Diálogo de alerta Material 3 Expressive adaptable a móvil, web y escritorio.
///
/// Soporta contenido de texto simple ([content]) o un widget personalizado
/// ([child], útil para formularios con [isForm]: `true`), icono superior dentro
/// de un [ExpressiveBadge], estado destructivo ([isDestructive]) y acciones
/// con física elástica mediante [ExpressiveButton].
class ExpressiveAlertDialog extends StatelessWidget {
  const ExpressiveAlertDialog({
    required this.title,
    this.content,
    this.child,
    this.icon,
    this.onConfirm,
    this.onCancel,
    this.confirmLabel,
    this.cancelLabel,
    this.showCancelButton = true,
    this.isForm = false,
    this.isDestructive = false,
    this.isConfirmLoading = false,
    this.confirmVariant = ExpressiveButtonVariant.filled,
    this.cancelVariant = ExpressiveButtonVariant.outlined,
    this.maxWidth,
    this.backgroundColor,
    this.borderRadius,
    super.key,
  });

  /// Título principal del diálogo.
  final String title;

  /// Texto descriptivo opcional cuando no se provee [child].
  final String? content;

  /// Contenido personalizado (por ejemplo un `Form` con
  /// [ExpressiveTextFormField]). Tiene prioridad sobre [content].
  final Widget? child;

  /// Icono opcional (se recomienda `HugeIcon`) mostrado arriba del título
  /// dentro de un [ExpressiveBadge].
  final Widget? icon;

  /// Callback de confirmación. Si es nulo, el botón de confirmación se muestra
  /// deshabilitado.
  final VoidCallback? onConfirm;

  /// Callback de cancelación. Si [onCancel] es nulo y [showCancelButton] es
  /// `true`, cierra el diálogo actual con `Navigator.maybePop`.
  final VoidCallback? onCancel;

  /// Etiqueta del botón de confirmación. Por defecto usa
  /// `MaterialLocalizations.of(context).okButtonLabel`.
  final String? confirmLabel;

  /// Etiqueta del botón de cancelación. Por defecto usa
  /// `MaterialLocalizations.of(context).cancelButtonLabel`.
  final String? cancelLabel;

  /// Si muestra el botón secundario de cancelación.
  final bool showCancelButton;

  /// Amplía el ancho máximo del contenido a `480dp` para acomodar formularios.
  final bool isForm;

  /// Aplica la paleta de error (`colorScheme.error`) a la acción principal y
  /// al badge del icono.
  final bool isDestructive;

  /// Muestra un indicador de carga dentro del botón de confirmación.
  final bool isConfirmLoading;

  /// Variante visual del botón de confirmación.
  final ExpressiveButtonVariant confirmVariant;

  /// Variante visual del botón de cancelación.
  final ExpressiveButtonVariant cancelVariant;

  /// Ancho máximo personalizado para pantallas grandes (web/escritorio).
  final double? maxWidth;

  /// Color de fondo personalizado del diálogo.
  final Color? backgroundColor;

  /// Radio de esquinas personalizado. Por defecto `28dp`.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = MaterialLocalizations.of(context);

    final effectiveConfirmLabel = confirmLabel ?? l10n.okButtonLabel;
    final effectiveCancelLabel = cancelLabel ?? l10n.cancelButtonLabel;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(28);
    final effectiveMaxWidth = maxWidth ?? (isForm ? 480.0 : 400.0);

    final Widget? bodyContent =
        child ??
        (content != null
            ? Text(
                content!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            : null);

    return AlertDialog(
      backgroundColor: backgroundColor ?? colorScheme.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: effectiveRadius),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      icon: icon != null
          ? Center(
              child: ExpressiveBadge(
                icon: icon!,
                size: 48,
                iconSize: 24,
                backgroundColor: isDestructive
                    ? colorScheme.errorContainer
                    : colorScheme.primaryContainer,
                foregroundColor: isDestructive
                    ? colorScheme.onErrorContainer
                    : colorScheme.onPrimaryContainer,
              ),
            )
          : null,
      title: Text(
        title,
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      ),
      content: bodyContent != null
          ? ConstrainedBox(
              constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
              child: SizedBox(
                width: isForm ? double.maxFinite : null,
                child: SingleChildScrollView(child: bodyContent),
              ),
            )
          : null,
      actions: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
          child: Row(
            spacing: 10,
            children: [
              if (showCancelButton)
                Expanded(
                  child: ExpressiveButton(
                    variant: cancelVariant,
                    onPressed:
                        onCancel ?? () => Navigator.of(context).maybePop(),
                    label: effectiveCancelLabel,
                  ),
                ),
              Expanded(
                child: ExpressiveButton(
                  variant: confirmVariant,
                  isLoading: isConfirmLoading,
                  backgroundColor: isDestructive ? colorScheme.error : null,
                  foregroundColor: isDestructive ? colorScheme.onError : null,
                  onPressed: onConfirm,
                  label: effectiveConfirmLabel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Variantes semánticas de color e icono para [ExpressiveSnackBar].
enum ExpressiveSnackBarType { neutral, info, success, warning, error }

/// Muestra un [SnackBar] estilizado con Material 3 Expressive adaptable a
/// móvil (ancho completo con márgenes) y web/escritorio (ancho máximo acotado).
ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
showExpressiveSnackBar({
  required BuildContext context,
  required String message,
  String? title,
  ExpressiveSnackBarType type = ExpressiveSnackBarType.neutral,
  Widget? icon,
  bool showIcon = true,
  String? actionLabel,
  VoidCallback? onAction,
  bool showCloseIcon = false,
  Duration duration = const Duration(seconds: 4),
  double maxWidth = 420,
  Color? backgroundColor,
  Color? foregroundColor,
  BorderRadius? borderRadius,
  bool replaceCurrent = true,
}) {
  final messenger = ScaffoldMessenger.of(context);
  if (replaceCurrent) {
    messenger.hideCurrentSnackBar();
  }

  return messenger.showSnackBar(
    ExpressiveSnackBar.build(
      context: context,
      message: message,
      title: title,
      type: type,
      icon: icon,
      showIcon: showIcon,
      actionLabel: actionLabel,
      onAction: onAction,
      showCloseIcon: showCloseIcon,
      duration: duration,
      maxWidth: maxWidth,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
    ),
  );
}

/// Constructor de [SnackBar] con diseño Material 3 Expressive.
///
/// Usa esquinas redondeadas de `20dp`, comportamiento flotante responsivo
/// (márgenes en pantallas móviles y ancho acotado [maxWidth] en web/escritorio),
/// paletas tonales por [ExpressiveSnackBarType] e iconos `HugeIcons`.
abstract final class ExpressiveSnackBar {
  /// Construye un [SnackBar] listo para pasarse a `ScaffoldMessenger`.
  static SnackBar build({
    required BuildContext context,
    required String message,
    String? title,
    ExpressiveSnackBarType type = ExpressiveSnackBarType.neutral,
    Widget? icon,
    bool showIcon = true,
    String? actionLabel,
    VoidCallback? onAction,
    bool showCloseIcon = false,
    Duration duration = const Duration(seconds: 4),
    double maxWidth = 420,
    Color? backgroundColor,
    Color? foregroundColor,
    BorderRadius? borderRadius,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;

    final (defaultBg, defaultFg, defaultIconData) = switch (type) {
      ExpressiveSnackBarType.neutral => (
        colorScheme.inverseSurface,
        colorScheme.onInverseSurface,
        null,
      ),
      ExpressiveSnackBarType.info => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        HugeIcons.strokeRoundedInformationCircle,
      ),
      ExpressiveSnackBarType.success => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
        HugeIcons.strokeRoundedCheckmarkCircle02,
      ),
      ExpressiveSnackBarType.warning => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
        HugeIcons.strokeRoundedNotification01,
      ),
      ExpressiveSnackBarType.error => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
        HugeIcons.strokeRoundedAlertCircle,
      ),
    };

    final effectiveBg = backgroundColor ?? defaultBg;
    final effectiveFg = foregroundColor ?? defaultFg;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(20);

    final Widget? leadingIcon = !showIcon
        ? null
        : icon ??
              (defaultIconData != null
                  ? HugeIcon(
                      icon: defaultIconData,
                      color: effectiveFg,
                      size: 22,
                    )
                  : null);

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: false,
      duration: duration,
      elevation: 2,
      backgroundColor: effectiveBg,
      width: isWideScreen ? maxWidth : null,
      margin: isWideScreen ? null : const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: effectiveRadius),
      content: Row(
        children: [
          if (leadingIcon != null) ...[
            IconTheme(
              data: IconThemeData(color: effectiveFg, size: 22),
              child: leadingIcon,
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null && title.isNotEmpty) ...[
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: effectiveFg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: effectiveFg,
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(width: 8),
            ExpressivePressable(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                onAction();
              },
              borderRadius: BorderRadius.circular(999),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  actionLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: effectiveFg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
          if (showCloseIcon) ...[
            const SizedBox(width: 4),
            Semantics(
              button: true,
              label: MaterialLocalizations.of(context).closeButtonTooltip,
              child: ExpressivePressable(
                onTap: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    color: effectiveFg,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

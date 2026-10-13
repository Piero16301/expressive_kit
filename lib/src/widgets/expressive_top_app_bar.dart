import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Barra superior (App Bar / Toolbar) de Material 3 Expressive que soporta
/// tanto el formato centrado estándar como el formato con gran encabezado
/// tipográfico ("Pantalla y ajustes táctiles") y botón de retroceso circular.
class ExpressiveTopAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ExpressiveTopAppBar({
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0,
    this.showBackButton = true,
    this.onBack,
    this.toolbarHeight,
    this.titleSpacing,
    super.key,
  }) : isLarge = false,
       largeTitleText = null;

  const ExpressiveTopAppBar.large({
    required String titleText,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 0,
    this.showBackButton = true,
    this.onBack,
    this.toolbarHeight,
    this.titleSpacing,
    super.key,
  }) : isLarge = true,
       largeTitleText = titleText,
       title = null,
       centerTitle = false;

  final Widget? title;
  final String? largeTitleText;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final bool showBackButton;
  final VoidCallback? onBack;
  final bool isLarge;
  final double? toolbarHeight;
  final double? titleSpacing;

  @override
  Size get preferredSize =>
      Size.fromHeight(isLarge ? 136 : (toolbarHeight ?? kToolbarHeight));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bg = backgroundColor ?? Colors.transparent;

    var effectiveLeading = leading;
    if (effectiveLeading == null &&
        showBackButton &&
        Navigator.of(context).canPop()) {
      effectiveLeading = Padding(
        padding: const EdgeInsets.all(8),
        child: ExpressiveIconButton.circle(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
        ),
      );
    }

    if (isLarge) {
      return ColoredBox(
        color: bg,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [?effectiveLeading, const Spacer(), ...?actions]),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    largeTitleText ?? '',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      height: 1.15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AppBar(
      title: title,
      leading: effectiveLeading,
      automaticallyImplyLeading: showBackButton && effectiveLeading == null,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: bg,
      elevation: elevation,
      scrolledUnderElevation: 0,
      toolbarHeight: toolbarHeight,
      titleSpacing: titleSpacing,
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }
}

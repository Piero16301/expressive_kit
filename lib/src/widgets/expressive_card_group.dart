import 'package:material_ui/material_ui.dart';

/// Contenedor individual redondeado de Material 3 Expressive.
class ExpressiveCard extends StatelessWidget {
  const ExpressiveCard({
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.onTap,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = borderRadius ?? BorderRadius.circular(24);
    final bg = backgroundColor ?? colorScheme.surfaceContainer;

    final card = Container(
      margin: margin,
      decoration: BoxDecoration(color: bg, borderRadius: radius),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: padding, child: child),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}

/// Grupo de tarjetas o lista segmentada de Material 3 Expressive:
/// agrupa múltiples elementos dentro de un único contenedor con esquinas
/// redondeadas de 24dp/28dp, divisores delgados automáticos y encabezado de
/// sección opcional.
class ExpressiveCardGroup extends StatelessWidget {
  const ExpressiveCardGroup({
    required this.children,
    this.title,
    this.backgroundColor,
    this.borderRadius,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.titlePadding,
    this.showDividers = true,
    this.dividerIndent = 16,
    this.dividerEndIndent = 16,
    super.key,
  });

  final List<Widget> children;
  final String? title;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? titlePadding;
  final bool showDividers;
  final double dividerIndent;
  final double dividerEndIndent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final radius = borderRadius ?? BorderRadius.circular(24);
    final bg = backgroundColor ?? colorScheme.surfaceContainer;

    final dividedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      dividedChildren.add(children[i]);
      if (showDividers && i < children.length - 1) {
        dividedChildren.add(
          Divider(
            height: 1,
            thickness: 1,
            indent: dividerIndent,
            endIndent: dividerEndIndent,
            color: colorScheme.outlineVariant.withValues(alpha: 0.25),
          ),
        );
      }
    }

    final card = Container(
      margin: margin,
      decoration: BoxDecoration(color: bg, borderRadius: radius),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: dividedChildren,
      ),
    );

    if (title == null) {
      return card;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              titlePadding ??
              const EdgeInsets.only(left: 24, top: 14, bottom: 8, right: 16),
          child: Text(
            title!,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
        ),
        card,
      ],
    );
  }
}

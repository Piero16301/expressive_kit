import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';

/// Elemento para [ExpressiveCarousel].
class ExpressiveCarouselItem {
  const ExpressiveCarouselItem({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;
}

/// Carrusel de Material 3 Expressive con soporte para visualización múltiple
/// (multi-browse), bordes redondeados adaptativos de 24dp y física de
/// desplazamiento elástica.
class ExpressiveCarousel extends StatelessWidget {
  const ExpressiveCarousel({
    required this.items,
    this.itemExtent = 220,
    this.height = 180,
    this.spacing = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.borderRadius,
    super.key,
  });

  final List<ExpressiveCarouselItem> items;
  final double itemExtent;
  final double height;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(24);

    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: padding,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, _) => SizedBox(width: spacing),
        itemBuilder: (context, index) {
          final item = items[index];

          final card = Container(
            width: itemExtent,
            decoration: BoxDecoration(borderRadius: effectiveRadius),
            clipBehavior: Clip.antiAlias,
            child: item.child,
          );

          if (item.onTap != null) {
            return ExpressivePressable(
              onTap: item.onTap,
              borderRadius: effectiveRadius,
              child: card,
            );
          }

          return card;
        },
      ),
    );
  }
}

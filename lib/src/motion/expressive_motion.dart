import 'package:material_ui/material_ui.dart';

/// Tokens de animación y curvas físicas para Material 3 Expressive.
abstract final class ExpressiveMotion {
  /// Curva estándar con overshoot suave para elementos interactivos en M3
  /// Expressive.
  static const Curve springBouncy = Cubic(0.34, 1.35, 0.64, 1);

  /// Curva suave y responsiva para transformaciones espaciales.
  static const Curve springGentle = Cubic(0.2, 0, 0, 1);

  /// Curva enfática para transiciones de estado y morphing.
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;

  /// Duraciones estándar de Material 3 Expressive.
  static const Duration durationShort = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 350);
  static const Duration durationLong = Duration(milliseconds: 500);
}

/// Widget envoltorio que provee retroalimentación táctil de escala (spring
/// press) característica de Material 3 Expressive.
class ExpressivePressable extends StatefulWidget {
  const ExpressivePressable({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressScale = 0.96,
    this.enabled = true,
    this.borderRadius,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressScale;
  final bool enabled;
  final BorderRadius? borderRadius;

  @override
  State<ExpressivePressable> createState() => _ExpressivePressableState();
}

class _ExpressivePressableState extends State<ExpressivePressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: ExpressiveMotion.durationShort,
      reverseDuration: ExpressiveMotion.durationMedium,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: widget.pressScale).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: ExpressiveMotion.springBouncy,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.enabled || widget.onTap == null) return;
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.enabled || widget.onTap == null) return;
    _controller.reverse();
  }

  void _onTapCancel() {
    if (!widget.enabled || widget.onTap == null) return;
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.enabled ? widget.onTap : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) =>
            Transform.scale(scale: _scaleAnimation.value, child: child),
        child: widget.child,
      ),
    );
  }
}

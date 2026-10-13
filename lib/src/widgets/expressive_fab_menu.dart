import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Elemento de menú para [ExpressiveFabMenu].
class ExpressiveFabMenuItem {
  const ExpressiveFabMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
}

/// Menú flotante (FAB Menu / Speed Dial) de Material 3 Expressive con animación
/// escalonada de física de rebote y etiquetas contextuales.
class ExpressiveFabMenu extends StatefulWidget {
  const ExpressiveFabMenu({
    required this.items,
    this.mainIcon = const HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
    this.closeIcon = const HugeIcon(icon: HugeIcons.strokeRoundedCancel01),
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    super.key,
  });

  final List<ExpressiveFabMenuItem> items;
  final Widget mainIcon;
  final Widget closeIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? overlayColor;

  @override
  State<ExpressiveFabMenu> createState() => _ExpressiveFabMenuState();
}

class _ExpressiveFabMenuState extends State<ExpressiveFabMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: ExpressiveMotion.durationMedium,
      reverseDuration: ExpressiveMotion.durationShort,
    );

    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: ExpressiveMotion.springBouncy,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              behavior: HitTestBehavior.translucent,
              child: Container(
                color: widget.overlayColor ?? Colors.transparent,
              ),
            ),
          ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_isOpen) ...[
              for (var i = 0; i < widget.items.length; i++) ...[
                _buildMenuItem(widget.items[i], i, colorScheme, theme),
                const SizedBox(height: 12),
              ],
            ],
            ExpressivePressable(
              onTap: _toggle,
              child: AnimatedContainer(
                duration: ExpressiveMotion.durationShort,
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: RotationTransition(
                    turns: Tween<double>(
                      begin: 0,
                      end: 0.25,
                    ).animate(_expandAnimation),
                    child: IconTheme(
                      data: IconThemeData(
                        color:
                            widget.foregroundColor ??
                            colorScheme.onPrimaryContainer,
                        size: 26,
                      ),
                      child: _isOpen ? widget.closeIcon : widget.mainIcon,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    ExpressiveFabMenuItem item,
    int index,
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    return ScaleTransition(
      scale: _expandAnimation,
      child: FadeTransition(
        opacity: _expandAnimation,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                item.label,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ExpressivePressable(
              onTap: () {
                _toggle();
                item.onTap();
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.backgroundColor ?? colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(
                      color:
                          item.foregroundColor ??
                          colorScheme.onSecondaryContainer,
                      size: 20,
                    ),
                    child: item.icon,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Interruptor de Material 3 Expressive que incluye iconos de validación dentro
/// del pulgar (cruz 'x' al estar desactivado y 'check' al estar activo), pista
/// en cápsula ancha y animación con física de rebote elástico.
class ExpressiveSwitch extends StatefulWidget {
  const ExpressiveSwitch({
    required this.value,
    required this.onChanged,
    this.activeThumbIcon,
    this.inactiveThumbIcon,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.showIcons = true,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? activeThumbIcon;
  final Widget? inactiveThumbIcon;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final bool showIcons;

  @override
  State<ExpressiveSwitch> createState() => _ExpressiveSwitchState();
}

class _ExpressiveSwitchState extends State<ExpressiveSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _thumbPosition;

  static const double _trackWidth = 52;
  static const double _trackHeight = 32;
  static const double _thumbDiameter = 24;
  static const double _padding = 4;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: ExpressiveMotion.durationMedium,
      value: widget.value ? 1.0 : 0.0,
    );

    _thumbPosition = CurvedAnimation(
      parent: _controller,
      curve: ExpressiveMotion.springBouncy,
      reverseCurve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(ExpressiveSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onChanged == null) return;
    widget.onChanged!(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = widget.onChanged != null;

    final activeTrack = widget.activeTrackColor ?? colorScheme.primary;
    final inactiveTrack =
        widget.inactiveTrackColor ?? colorScheme.surfaceContainerHighest;

    final activeThumb = widget.activeThumbColor ?? colorScheme.onPrimary;
    final inactiveThumb = widget.inactiveThumbColor ?? colorScheme.outline;

    const maxOffset = _trackWidth - _thumbDiameter - (_padding * 2);

    return ExpressivePressable(
      enabled: isEnabled,
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _thumbPosition,
        builder: (context, child) {
          final progress = _thumbPosition.value.clamp(0.0, 1.0);
          final currentTrackColor = Color.lerp(
            inactiveTrack,
            activeTrack,
            progress,
          )!;
          final currentThumbColor = Color.lerp(
            inactiveThumb,
            activeThumb,
            progress,
          )!;

          final hasOutline = progress < 0.2;

          return Container(
            width: _trackWidth,
            height: _trackHeight,
            padding: const EdgeInsets.all(_padding),
            decoration: BoxDecoration(
              color: isEnabled
                  ? currentTrackColor
                  : colorScheme.onSurface.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(_trackHeight / 2),
              border: hasOutline
                  ? Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.4),
                      width: 1.5,
                    )
                  : null,
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Transform.translate(
                  offset: Offset(progress * maxOffset, 0),
                  child: Container(
                    width: _thumbDiameter,
                    height: _thumbDiameter,
                    decoration: BoxDecoration(
                      color: isEnabled
                          ? currentThumbColor
                          : colorScheme.onSurface.withValues(alpha: 0.38),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: widget.showIcons
                          ? (progress > 0.5
                                ? (widget.activeThumbIcon ??
                                      HugeIcon(
                                        icon: HugeIcons.strokeRoundedTick01,
                                        size: 14,
                                        color: activeTrack,
                                      ))
                                : (widget.inactiveThumbIcon ??
                                      HugeIcon(
                                        icon: HugeIcons.strokeRoundedCancel01,
                                        size: 12,
                                        color: inactiveTrack,
                                      )))
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

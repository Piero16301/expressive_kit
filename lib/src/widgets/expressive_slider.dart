import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Slider de Material 3 Expressive como se muestra en las capturas de pantalla
/// de Pixel: pista gruesa en cápsula con puntos de división discretos,
/// indicador vertical en píldora con hendidura central, y botones de paso
/// negativo (-) y positivo (+) a los extremos.
class ExpressiveSlider extends StatefulWidget {
  const ExpressiveSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.title,
    this.subtitle,
    this.showSteppers = true,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.trackHeight = 18.0,
    this.thumbWidth = 16.0,
    this.thumbHeight = 36.0,
    super.key,
  }) : assert(min <= max, 'min must be less than or equal to max'),
       assert(
         value >= min && value <= max,
         'value must be between min and max',
       );

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? title;
  final String? subtitle;
  final bool showSteppers;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double trackHeight;
  final double thumbWidth;
  final double thumbHeight;

  @override
  State<ExpressiveSlider> createState() => _ExpressiveSliderState();
}

class _ExpressiveSliderState extends State<ExpressiveSlider> {
  bool _isDragging = false;

  double get _range => widget.max - widget.min;

  double get _normalizedValue {
    if (_range == 0) return 0;
    return ((widget.value - widget.min) / _range).clamp(0.0, 1.0);
  }

  void _updateValueFromPosition(double localDx, double trackWidth) {
    if (widget.onChanged == null || trackWidth <= 0) return;

    final effectiveTrackWidth = trackWidth - widget.thumbWidth;
    final ratio = effectiveTrackWidth > 0
        ? ((localDx - (widget.thumbWidth / 2)) / effectiveTrackWidth).clamp(
            0.0,
            1.0,
          )
        : 0.0;
    var newValue = widget.min + (ratio * _range);

    if (widget.divisions != null && widget.divisions! > 0) {
      final step = _range / widget.divisions!;
      final stepsFromMin = ((newValue - widget.min) / step).round();
      newValue = (widget.min + (stepsFromMin * step)).clamp(
        widget.min,
        widget.max,
      );
    }

    widget.onChanged!(newValue);
  }

  void _stepDown() {
    if (widget.onChanged == null) return;
    final step = widget.divisions != null && widget.divisions! > 0
        ? _range / widget.divisions!
        : _range * 0.1;
    final newValue = (widget.value - step).clamp(widget.min, widget.max);
    widget.onChanged!(newValue);
  }

  void _stepUp() {
    if (widget.onChanged == null) return;
    final step = widget.divisions != null && widget.divisions! > 0
        ? _range / widget.divisions!
        : _range * 0.1;
    final newValue = (widget.value + step).clamp(widget.min, widget.max);
    widget.onChanged!(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = widget.onChanged != null;

    final activeTrackColor =
        widget.activeColor ??
        (isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.12));
    final inactiveTrackColor =
        widget.inactiveColor ??
        (isEnabled
            ? colorScheme.surfaceContainerHighest
            : colorScheme.onSurface.withValues(alpha: 0.08));
    final handleColor =
        widget.thumbColor ??
        (isEnabled
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.38));

    final sliderWidget = Row(
      children: [
        if (widget.showSteppers) ...[
          ExpressiveIconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedRemove01),
            size: ExpressiveIconButtonSize.small,
            onPressed: isEnabled && widget.value > widget.min
                ? _stepDown
                : null,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              final effectiveTrackWidth = trackWidth - widget.thumbWidth;
              final thumbPosition =
                  widget.thumbWidth / 2 +
                  (_normalizedValue *
                      effectiveTrackWidth.clamp(0.0, double.infinity));
              final activeTrackWidth =
                  (thumbPosition -
                          (widget.thumbWidth / 2) +
                          (widget.thumbWidth * _normalizedValue))
                      .clamp(0.0, trackWidth);

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragStart: isEnabled
                    ? (details) {
                        setState(() => _isDragging = true);
                        _updateValueFromPosition(
                          details.localPosition.dx,
                          trackWidth,
                        );
                      }
                    : null,
                onHorizontalDragUpdate: isEnabled
                    ? (details) {
                        _updateValueFromPosition(
                          details.localPosition.dx,
                          trackWidth,
                        );
                      }
                    : null,
                onHorizontalDragEnd: isEnabled
                    ? (_) => setState(() => _isDragging = false)
                    : null,
                onHorizontalDragCancel: isEnabled
                    ? () => setState(() => _isDragging = false)
                    : null,
                onTapDown: isEnabled
                    ? (details) {
                        _updateValueFromPosition(
                          details.localPosition.dx,
                          trackWidth,
                        );
                      }
                    : null,
                child: SizedBox(
                  width: trackWidth,
                  height: widget.thumbHeight,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Pista continua redondeada
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: widget.trackHeight,
                          decoration: BoxDecoration(
                            color: inactiveTrackColor,
                            borderRadius: BorderRadius.circular(
                              widget.trackHeight / 2,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              // Parte activa
                              Container(
                                width: activeTrackWidth,
                                decoration: BoxDecoration(
                                  color: activeTrackColor,
                                  borderRadius: BorderRadius.circular(
                                    widget.trackHeight / 2,
                                  ),
                                ),
                              ),
                              // Puntos de paso / división (dots)
                              if (widget.divisions != null &&
                                  widget.divisions! > 1)
                                Positioned.fill(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: widget.thumbWidth / 2,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        widget.divisions! + 1,
                                        (index) {
                                          final dotRatio =
                                              index / widget.divisions!;
                                          final isPassed =
                                              dotRatio <=
                                              _normalizedValue + 0.001;
                                          return Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: isPassed
                                                  ? colorScheme.onPrimary
                                                        .withValues(alpha: 0.7)
                                                  : colorScheme.onSurfaceVariant
                                                        .withValues(alpha: 0.5),
                                              shape: BoxShape.circle,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // Indicador flotante / Thumb en píldora con ranura vertical
                      Positioned(
                        left: (thumbPosition - (widget.thumbWidth / 2)).clamp(
                          0.0,
                          (trackWidth - widget.thumbWidth).clamp(
                            0.0,
                            double.infinity,
                          ),
                        ),
                        child: AnimatedScale(
                          duration: ExpressiveMotion.durationShort,
                          curve: ExpressiveMotion.springBouncy,
                          scale: _isDragging ? 1.08 : 1.0,
                          child: Container(
                            width: widget.thumbWidth,
                            height: widget.thumbHeight,
                            decoration: BoxDecoration(
                              color: handleColor,
                              borderRadius: BorderRadius.circular(
                                widget.thumbWidth / 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 2,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: colorScheme.onPrimary.withValues(
                                    alpha: 0.8,
                                  ),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.showSteppers) ...[
          const SizedBox(width: 8),
          ExpressiveIconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
            size: ExpressiveIconButtonSize.small,
            onPressed: isEnabled && widget.value < widget.max ? _stepUp : null,
          ),
        ],
      ],
    );

    if (widget.title == null && widget.subtitle == null) {
      return sliderWidget;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            widget.subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        const SizedBox(height: 12),
        sliderWidget,
      ],
    );
  }
}

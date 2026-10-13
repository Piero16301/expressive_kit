import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';

/// Material 3 Expressive linear progress indicator with a wavy active line
/// in both determinate and indeterminate modes.
///
/// Follows Material 3 Expressive guidelines:
/// - Determinate: fills from 0% to 100%. Starts with a stop dot at 0%,
///   transitions to a dynamic sinusoidal wavy path with uniform wave height
///   across its entire length, and flattens out smoothly to a solid straight
///   line at 100%. Features a track and an end stop indicator dot separated
///   by visible gaps.
/// - Indeterminate: an active wavy segment moves along a fixed trajectory,
///   growing and shrinking in length while rippling continuously.
class ExpressiveLinearProgressIndicator extends StatefulWidget {
  const ExpressiveLinearProgressIndicator({
    this.value,
    this.width,
    this.height = 20,
    this.strokeWidth = 8,
    this.color,
    this.backgroundColor,
    this.stopDotColor,
    this.wavelength = 22,
    this.amplitude = 2.0,
    this.borderRadius,
    super.key,
  });

  /// The progress value between 0.0 and 1.0. If null, the indicator is indeterminate.
  final double? value;

  /// Optional width of the indicator. Defaults to `double.infinity`.
  final double? width;

  /// The total height of the indicator widget. Defaults to 20.0.
  final double height;

  /// The stroke width of the indicator and track. Defaults to 8.0.
  final double strokeWidth;

  /// The color of the active progress indicator. Defaults to `colorScheme.primary`.
  final Color? color;

  /// The color of the background track. Defaults to `colorScheme.secondaryContainer`.
  final Color? backgroundColor;

  /// The color of the end stop indicator dot. Defaults to [color] or `colorScheme.primary`.
  final Color? stopDotColor;

  /// The wavelength (peak-to-peak distance) of the sinusoidal wave. Defaults to 22.0.
  final double wavelength;

  /// The amplitude (peak height from baseline) of the wave. Defaults to 2.0.
  final double amplitude;

  /// Optional border radius to clip the container.
  final BorderRadius? borderRadius;

  @override
  State<ExpressiveLinearProgressIndicator> createState() =>
      _ExpressiveLinearProgressIndicatorState();
}

class _ExpressiveLinearProgressIndicatorState
    extends State<ExpressiveLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ExpressiveLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor = widget.color ?? colorScheme.primary;
    final trackColor = widget.backgroundColor ?? colorScheme.secondaryContainer;
    final stopColor = widget.stopDotColor ?? activeColor;

    Widget indicator = SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LinearWavyPainter(
              value: widget.value,
              animationValue: _controller.value,
              activeColor: activeColor,
              trackColor: trackColor,
              stopDotColor: stopColor,
              strokeWidth: widget.strokeWidth,
              wavelength: widget.wavelength,
              amplitude: widget.amplitude,
            ),
          );
        },
      ),
    );

    if (widget.borderRadius != null) {
      indicator = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: indicator,
      );
    }

    return Semantics(
      value: widget.value != null
          ? '${(widget.value!.clamp(0.0, 1.0) * 100).round()}%'
          : null,
      child: indicator,
    );
  }
}

class _LinearWavyPainter extends CustomPainter {
  _LinearWavyPainter({
    required this.value,
    required this.animationValue,
    required this.activeColor,
    required this.trackColor,
    required this.stopDotColor,
    required this.strokeWidth,
    required this.wavelength,
    required this.amplitude,
  });

  final double? value;
  final double animationValue;
  final Color activeColor;
  final Color trackColor;
  final Color stopDotColor;
  final double strokeWidth;
  final double wavelength;
  final double amplitude;

  /// Visible spacing between the rounded ends of the active segment and the track.
  static const double visibleGap = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= strokeWidth * 2) return;

    final y0 = size.height / 2;
    final rStop = strokeWidth / 2;
    final xMin = rStop;
    final xMax = size.width - rStop;
    final centerOffset = strokeWidth + visibleGap;

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final stopDotPaint = Paint()
      ..color = stopDotColor
      ..style = PaintingStyle.fill;

    if (value == null) {
      // -----------------------------------------------------------------------
      // INDETERMINATE MODE
      // -----------------------------------------------------------------------
      final t = animationValue;
      final center = size.width * (-0.15 + 1.3 * t);
      final segLen = size.width * (0.24 + 0.20 * math.sin(math.pi * t));
      final x1 = center - segLen / 2;
      final x2 = center + segLen / 2;

      // Draw background track with visible gaps on either side
      if (x1 - centerOffset > xMin) {
        canvas.drawLine(
          Offset(xMin, y0),
          Offset(math.max(xMin, x1 - centerOffset), y0),
          trackPaint,
        );
      }
      if (x2 + centerOffset < xMax) {
        canvas.drawLine(
          Offset(math.min(xMax, x2 + centerOffset), y0),
          Offset(xMax, y0),
          trackPaint,
        );
      }
      if (x2 <= xMin || x1 >= xMax) {
        canvas.drawLine(Offset(xMin, y0), Offset(xMax, y0), trackPaint);
      }

      // Draw active wavy segment with uniform amplitude across its length
      final activeStart = x1.clamp(xMin, xMax);
      final activeEnd = x2.clamp(xMin, xMax);

      if (activeEnd - activeStart > 1.0) {
        final path = Path();
        final phase = t * 4 * math.pi;
        const dx = 1.0;
        bool isFirst = true;

        for (double x = activeStart; x <= activeEnd; x += dx) {
          final y =
              y0 + amplitude * math.sin((2 * math.pi * x / wavelength) - phase);
          if (isFirst) {
            path.moveTo(x, y);
            isFirst = false;
          } else {
            path.lineTo(x, y);
          }
        }
        canvas.drawPath(path, activePaint);
      }
    } else {
      // -----------------------------------------------------------------------
      // DETERMINATE MODE (0.0 to 1.0)
      // -----------------------------------------------------------------------
      final v = value!.clamp(0.0, 1.0);

      if (v <= 0.0) {
        // Start dot
        canvas.drawCircle(Offset(xMin, y0), rStop, stopDotPaint);

        // Track with clear gap after start dot and before stop dot
        final trackStart = xMin + centerOffset;
        final trackEnd = xMax - centerOffset;
        if (trackStart < trackEnd) {
          canvas.drawLine(
            Offset(trackStart, y0),
            Offset(trackEnd, y0),
            trackPaint,
          );
        }

        // Stop dot
        canvas.drawCircle(Offset(xMax, y0), rStop, stopDotPaint);
      } else if (v >= 1.0) {
        // Fully complete: flat straight line covering full width
        canvas.drawLine(Offset(xMin, y0), Offset(xMax, y0), activePaint);
      } else {
        // Active segment from xMin to xActive
        final xActive = xMin + (xMax - xMin) * v;

        // Stop dot at xMax
        canvas.drawCircle(Offset(xMax, y0), rStop, stopDotPaint);

        // Track with visible gap between active progress and stop dot
        final trackStart = xActive + centerOffset;
        final trackEnd = xMax - centerOffset;
        if (trackStart < trackEnd) {
          canvas.drawLine(
            Offset(trackStart, y0),
            Offset(trackEnd, y0),
            trackPaint,
          );
        }

        // Amplitude flattening near 1.0 and smooth ramp in near 0.0
        final flattening = v >= 0.85 ? ((1.0 - v) / 0.15).clamp(0.0, 1.0) : 1.0;
        final ramp = (v / 0.04).clamp(0.0, 1.0);
        final effAmp = amplitude * flattening * ramp;

        if (xActive - xMin < 2.0) {
          canvas.drawCircle(Offset(xMin, y0), rStop, stopDotPaint);
        } else {
          final path = Path();
          const dx = 1.0;
          bool isFirst = true;

          // Uniform wave height across the active portion
          for (double x = xMin; x <= xActive; x += dx) {
            final y =
                y0 + effAmp * math.sin(2 * math.pi * (x - xMin) / wavelength);
            if (isFirst) {
              path.moveTo(x, y);
              isFirst = false;
            } else {
              path.lineTo(x, y);
            }
          }
          canvas.drawPath(path, activePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LinearWavyPainter oldDelegate) => true;
}

/// Material 3 Expressive circular progress indicator with a wavy active line
/// in both determinate and indeterminate modes.
///
/// Follows Material 3 Expressive guidelines:
/// - Determinate: fills from 0% to 100%. Starts with a stop dot at 0%,
///   transitions to a scalloped sinusoidal wavy circular arc with uniform
///   lobe heights, and flattens out smoothly to a solid circular ring at 100%.
///   Features a track separated by visible gaps.
/// - Indeterminate: an active wavy arc moves around the circle, growing and
///   shrinking in sweep length while rippling continuously.
class ExpressiveCircularProgressIndicator extends StatefulWidget {
  const ExpressiveCircularProgressIndicator({
    this.value,
    this.size = 64,
    this.strokeWidth = 8,
    this.color,
    this.backgroundColor,
    this.stopDotColor,
    this.waveCount = 8,
    this.amplitude = 1.8,
    super.key,
  });

  /// The progress value between 0.0 and 1.0. If null, the indicator is indeterminate.
  final double? value;

  /// The diameter of the indicator widget. Defaults to 64.0.
  final double size;

  /// The stroke width of the indicator and track. Defaults to 8.0.
  final double strokeWidth;

  /// The color of the active progress indicator. Defaults to `colorScheme.primary`.
  final Color? color;

  /// The color of the background track. Defaults to `colorScheme.secondaryContainer`.
  final Color? backgroundColor;

  /// The color of the stop indicator dot at 0%. Defaults to [color] or `colorScheme.primary`.
  final Color? stopDotColor;

  /// The number of wave lobes around the circumference. Defaults to 8.
  final int waveCount;

  /// The amplitude (peak height from circular radius) of the wave. Defaults to 1.8.
  final double amplitude;

  @override
  State<ExpressiveCircularProgressIndicator> createState() =>
      _ExpressiveCircularProgressIndicatorState();
}

class _ExpressiveCircularProgressIndicatorState
    extends State<ExpressiveCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(
    covariant ExpressiveCircularProgressIndicator oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activeColor = widget.color ?? colorScheme.primary;
    final trackColor = widget.backgroundColor ?? colorScheme.secondaryContainer;
    final stopColor = widget.stopDotColor ?? activeColor;

    return Semantics(
      value: widget.value != null
          ? '${(widget.value!.clamp(0.0, 1.0) * 100).round()}%'
          : null,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _CircularWavyPainter(
                value: widget.value,
                animationValue: _controller.value,
                activeColor: activeColor,
                trackColor: trackColor,
                stopDotColor: stopColor,
                strokeWidth: widget.strokeWidth,
                waveCount: widget.waveCount,
                amplitude: widget.amplitude,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CircularWavyPainter extends CustomPainter {
  _CircularWavyPainter({
    required this.value,
    required this.animationValue,
    required this.activeColor,
    required this.trackColor,
    required this.stopDotColor,
    required this.strokeWidth,
    required this.waveCount,
    required this.amplitude,
  });

  final double? value;
  final double animationValue;
  final Color activeColor;
  final Color trackColor;
  final Color stopDotColor;
  final double strokeWidth;
  final int waveCount;
  final double amplitude;

  /// Visible spacing between the rounded ends of the active arc and the track.
  static const double visibleGap = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 2 * amplitude - strokeWidth) / 2;
    if (radius <= 0) return;

    final gapAngle = (strokeWidth + visibleGap) / radius;
    final rStop = strokeWidth / 2;
    final trackRect = Rect.fromCircle(center: center, radius: radius);

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final stopDotPaint = Paint()
      ..color = stopDotColor
      ..style = PaintingStyle.fill;

    if (value == null) {
      // -----------------------------------------------------------------------
      // INDETERMINATE MODE
      // -----------------------------------------------------------------------
      final t = animationValue;
      final sweep =
          math.pi * (0.35 + 0.45 * (0.5 + 0.5 * math.sin(2 * math.pi * t * 2)));
      final centerAngle = -math.pi / 2 + 2 * math.pi * t * 1.5;
      final theta1 = centerAngle - sweep / 2;
      final theta2 = centerAngle + sweep / 2;

      // Inactive track: complementary arc with visible gapAngle at both ends
      final trackSweep = 2 * math.pi - sweep - 2 * gapAngle;
      if (trackSweep > 0.05) {
        canvas.drawArc(
          trackRect,
          theta2 + gapAngle,
          trackSweep,
          false,
          trackPaint,
        );
      }

      // Active wavy arc from theta1 to theta2 with uniform amplitude
      final path = Path();
      final phase = t * 4 * math.pi;
      const dTheta = 0.03;
      bool isFirst = true;

      for (double th = theta1; th <= theta2; th += dTheta) {
        final r = radius + amplitude * math.sin(waveCount * th - phase);
        final x = center.dx + r * math.cos(th);
        final y = center.dy + r * math.sin(th);
        if (isFirst) {
          path.moveTo(x, y);
          isFirst = false;
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, activePaint);
    } else {
      // -----------------------------------------------------------------------
      // DETERMINATE MODE (0.0 to 1.0)
      // -----------------------------------------------------------------------
      final v = value!.clamp(0.0, 1.0);
      const thetaStart = -math.pi / 2;

      if (v <= 0.0) {
        // Stop dot at top
        final dotCenter = Offset(center.dx, center.dy - radius);
        canvas.drawCircle(dotCenter, rStop, stopDotPaint);

        // Inactive track with visible gaps before and after top dot
        final trackSweep = 2 * math.pi - 2 * gapAngle;
        if (trackSweep > 0.05) {
          canvas.drawArc(
            trackRect,
            thetaStart + gapAngle,
            trackSweep,
            false,
            trackPaint,
          );
        }
      } else if (v >= 1.0) {
        // Fully complete: flat continuous smooth circle
        canvas.drawCircle(center, radius, activePaint);
      } else {
        final sweep = 2 * math.pi * v;
        final thetaEnd = thetaStart + sweep;

        // Inactive track between (thetaEnd + gapAngle) and (thetaStart - gapAngle)
        final trackSweep = 2 * math.pi - sweep - 2 * gapAngle;
        if (trackSweep > 0.05) {
          canvas.drawArc(
            trackRect,
            thetaEnd + gapAngle,
            trackSweep,
            false,
            trackPaint,
          );
        }

        // Amplitude flattening near 1.0 (smooth ring) and ramp near 0.0
        final flattening = v >= 0.88 ? ((1.0 - v) / 0.12).clamp(0.0, 1.0) : 1.0;
        final ramp = (v / 0.04).clamp(0.0, 1.0);
        final effAmp = amplitude * flattening * ramp;

        if (sweep < 0.08) {
          final dotCenter = Offset(center.dx, center.dy - radius);
          canvas.drawCircle(dotCenter, rStop, stopDotPaint);
        } else {
          final path = Path();
          const dTheta = 0.03;
          bool isFirst = true;

          // Uniform lobe amplitude along the active arc
          for (double th = thetaStart; th <= thetaEnd; th += dTheta) {
            final r = radius + effAmp * math.sin(waveCount * (th - thetaStart));
            final x = center.dx + r * math.cos(th);
            final y = center.dy + r * math.sin(th);
            if (isFirst) {
              path.moveTo(x, y);
              isFirst = false;
            } else {
              path.lineTo(x, y);
            }
          }
          canvas.drawPath(path, activePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CircularWavyPainter oldDelegate) => true;
}

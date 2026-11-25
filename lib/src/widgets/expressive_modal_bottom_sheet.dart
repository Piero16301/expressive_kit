import 'package:material_ui/material_ui.dart';

/// Muestra una hoja modal inferior de Material 3 Expressive (28dp) con barra
/// de arrastre, título opcional, altura máxima controlada y scroll automático.
Future<T?> showExpressiveModalBottomSheet<T>({
  required BuildContext context,
  String? title,
  List<Widget> Function(BuildContext modalContext)? itemsBuilder,
  WidgetBuilder? builder,
  bool showDragHandle = true,
  double maxHeightFraction = 0.65,
  Color? backgroundColor,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 20),
}) {
  assert(
    itemsBuilder != null || builder != null,
    'Must provide either itemsBuilder or builder.',
  );
  assert(
    maxHeightFraction > 0 && maxHeightFraction <= 1,
    'maxHeightFraction must be between 0 (exclusive) and 1 (inclusive).',
  );

  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final maxHeight = MediaQuery.sizeOf(context).height * maxHeightFraction;

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? colorScheme.surfaceContainer,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (modalContext) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDragHandle) ...[
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (title != null && title.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: builder != null
                        ? builder(modalContext)
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: itemsBuilder!(modalContext),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

import 'package:expressive_kit/src/l10n/generated/expressive_localizations.dart';
import 'package:expressive_kit/src/l10n/generated/expressive_localizations_en.dart';
import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

/// Modos de selección disponibles para [ExpressiveDatePickerDialog].
enum ExpressiveDatePickerMode {
  /// Selección de un día específico en un calendario mensual.
  day,

  /// Selección de un único mes dentro de un año.
  month,

  /// Selección de un rango de meses (inicio y fin).
  monthRange,

  /// Selección de un rango de años (inicio y fin).
  yearRange,
}

/// Selectores de fecha, mes y rango Material 3 Expressive adaptables a móvil,
/// web y escritorio.
abstract final class ExpressiveDatePicker {
  /// Abre un diálogo para seleccionar un día específico.
  static Future<DateTime?> showDayPicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
    String? helpText,
    String? cancelLabel,
    String? confirmLabel,
  }) {
    return showDialog<DateTime>(
      context: context,
      builder: (_) => ExpressiveDatePickerDialog(
        mode: ExpressiveDatePickerMode.day,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: locale,
        helpText: helpText,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
      ),
    );
  }

  /// Abre un diálogo para seleccionar un mes en particular.
  static Future<DateTime?> showMonthPicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
    String? helpText,
    String? cancelLabel,
    String? confirmLabel,
  }) {
    return showDialog<DateTime>(
      context: context,
      builder: (_) => ExpressiveDatePickerDialog(
        mode: ExpressiveDatePickerMode.month,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: locale,
        helpText: helpText,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
      ),
    );
  }

  /// Abre un diálogo para seleccionar un rango de meses.
  static Future<DateTimeRange?> showMonthRangePicker({
    required BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
    String? helpText,
    String? cancelLabel,
    String? confirmLabel,
  }) {
    return showDialog<DateTimeRange>(
      context: context,
      builder: (_) => ExpressiveDatePickerDialog(
        mode: ExpressiveDatePickerMode.monthRange,
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: locale,
        helpText: helpText,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
      ),
    );
  }

  /// Abre un diálogo para seleccionar un rango de años.
  static Future<DateTimeRange?> showYearRangePicker({
    required BuildContext context,
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
    String? helpText,
    String? cancelLabel,
    String? confirmLabel,
  }) {
    return showDialog<DateTimeRange>(
      context: context,
      builder: (_) => ExpressiveDatePickerDialog(
        mode: ExpressiveDatePickerMode.yearRange,
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: locale,
        helpText: helpText,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
      ),
    );
  }
}

/// Diálogo de selección de día, mes, rango de meses o rango de años con
/// diseño Material 3 Expressive (esquinas de 28dp, conectores de rango y
/// botones [ExpressiveButton]).
class ExpressiveDatePickerDialog extends StatefulWidget {
  const ExpressiveDatePickerDialog({
    this.mode = ExpressiveDatePickerMode.day,
    this.initialDate,
    this.initialStartDate,
    this.initialEndDate,
    this.firstDate,
    this.lastDate,
    this.locale,
    this.helpText,
    this.cancelLabel,
    this.confirmLabel,
    super.key,
  });

  /// Modo de selección del calendario.
  final ExpressiveDatePickerMode mode;

  /// Fecha inicial seleccionada para los modos [ExpressiveDatePickerMode.day]
  /// y [ExpressiveDatePickerMode.month].
  final DateTime? initialDate;

  /// Fecha de inicio inicial para los modos de rango.
  final DateTime? initialStartDate;

  /// Fecha de fin inicial para los modos de rango.
  final DateTime? initialEndDate;

  /// Fecha mínima permitida.
  final DateTime? firstDate;

  /// Fecha máxima permitida.
  final DateTime? lastDate;

  /// Locale opcional para el formato de meses y días. Si es nulo, usa
  /// `Localizations.maybeLocaleOf(context)`.
  final Locale? locale;

  /// Texto de ayuda superior del encabezado.
  final String? helpText;

  /// Etiqueta del botón de cancelar.
  final String? cancelLabel;

  /// Etiqueta del botón de confirmar.
  final String? confirmLabel;

  @override
  State<ExpressiveDatePickerDialog> createState() =>
      _ExpressiveDatePickerDialogState();
}

class _ExpressiveDatePickerDialogState
    extends State<ExpressiveDatePickerDialog> {
  late DateTime _displayedDate;
  DateTime? _selectedDate;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    if (widget.mode == ExpressiveDatePickerMode.monthRange ||
        widget.mode == ExpressiveDatePickerMode.yearRange) {
      _startDate = widget.initialStartDate;
      _endDate = widget.initialEndDate;
      final anchor = _startDate ?? now;
      _displayedDate = DateTime(anchor.year, anchor.month);
    } else {
      _selectedDate = widget.initialDate;
      final anchor = _selectedDate ?? now;
      _displayedDate = DateTime(anchor.year, anchor.month);
    }
  }

  int get _yearPageStart => (_displayedDate.year ~/ 12) * 12;

  void _navigatePrevious() {
    setState(() {
      switch (widget.mode) {
        case ExpressiveDatePickerMode.day:
          _displayedDate = DateTime(
            _displayedDate.year,
            _displayedDate.month - 1,
          );
        case ExpressiveDatePickerMode.month:
        case ExpressiveDatePickerMode.monthRange:
          _displayedDate = DateTime(_displayedDate.year - 1);
        case ExpressiveDatePickerMode.yearRange:
          _displayedDate = DateTime(_displayedDate.year - 12);
      }
    });
  }

  void _navigateNext() {
    setState(() {
      switch (widget.mode) {
        case ExpressiveDatePickerMode.day:
          _displayedDate = DateTime(
            _displayedDate.year,
            _displayedDate.month + 1,
          );
        case ExpressiveDatePickerMode.month:
        case ExpressiveDatePickerMode.monthRange:
          _displayedDate = DateTime(_displayedDate.year + 1);
        case ExpressiveDatePickerMode.yearRange:
          _displayedDate = DateTime(_displayedDate.year + 12);
      }
    });
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;

  bool _isDayDisabled(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    if (widget.firstDate != null) {
      final first = DateTime(
        widget.firstDate!.year,
        widget.firstDate!.month,
        widget.firstDate!.day,
      );
      if (day.isBefore(first)) return true;
    }
    if (widget.lastDate != null) {
      final last = DateTime(
        widget.lastDate!.year,
        widget.lastDate!.month,
        widget.lastDate!.day,
      );
      if (day.isAfter(last)) return true;
    }
    return false;
  }

  bool _isMonthDisabled(DateTime date) {
    final month = DateTime(date.year, date.month);
    if (widget.firstDate != null &&
        month.isBefore(
          DateTime(widget.firstDate!.year, widget.firstDate!.month),
        )) {
      return true;
    }
    if (widget.lastDate != null &&
        month.isAfter(
          DateTime(widget.lastDate!.year, widget.lastDate!.month),
        )) {
      return true;
    }
    return false;
  }

  bool _isYearDisabled(int year) {
    if (widget.firstDate != null && year < widget.firstDate!.year) return true;
    if (widget.lastDate != null && year > widget.lastDate!.year) return true;
    return false;
  }

  void _onDayTapped(DateTime date) {
    if (_isDayDisabled(date)) return;
    setState(() => _selectedDate = date);
  }

  void _onMonthTapped(DateTime date) {
    if (_isMonthDisabled(date)) return;
    setState(() {
      if (widget.mode == ExpressiveDatePickerMode.month) {
        _selectedDate = date;
      } else {
        if (_startDate == null || _endDate != null) {
          _startDate = date;
          _endDate = null;
        } else if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else {
          _endDate = date;
        }
      }
    });
  }

  void _onYearTapped(int year) {
    if (_isYearDisabled(year)) return;
    final date = DateTime(year);
    setState(() {
      if (_startDate == null || _endDate != null) {
        _startDate = date;
        _endDate = null;
      } else if (year < _startDate!.year) {
        _endDate = _startDate;
        _startDate = date;
      } else {
        _endDate = date;
      }
    });
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }

  String _formatDate(DateTime date, String pattern, String localeTag) {
    try {
      return DateFormat(pattern, localeTag).format(date);
    } catch (_) {
      return DateFormat(pattern).format(date);
    }
  }

  String _defaultHelpText(ExpressiveLocalizations l10n) {
    switch (widget.mode) {
      case ExpressiveDatePickerMode.day:
        return l10n.datePickerSelectDate;
      case ExpressiveDatePickerMode.month:
        return l10n.datePickerSelectMonth;
      case ExpressiveDatePickerMode.monthRange:
        return l10n.datePickerSelectMonthRange;
      case ExpressiveDatePickerMode.yearRange:
        return l10n.datePickerSelectYearRange;
    }
  }

  String _headlineString(String localeTag, ExpressiveLocalizations l10n) {
    switch (widget.mode) {
      case ExpressiveDatePickerMode.day:
        if (_selectedDate == null) return l10n.datePickerChooseDay;
        return _capitalize(
          _formatDate(_selectedDate!, 'EEE, MMM d, yyyy', localeTag),
        );
      case ExpressiveDatePickerMode.month:
        if (_selectedDate == null) return l10n.datePickerChooseMonth;
        return _capitalize(_formatDate(_selectedDate!, 'MMMM yyyy', localeTag));
      case ExpressiveDatePickerMode.monthRange:
        if (_startDate == null) return l10n.datePickerChooseMonths;
        final startStr = _capitalize(
          _formatDate(_startDate!, 'MMM', localeTag),
        );
        if (_endDate == null) return '$startStr - ';
        final endStr = _capitalize(
          _formatDate(_endDate!, 'MMM yyyy', localeTag),
        );
        if (_startDate!.year == _endDate!.year) {
          return '$startStr - $endStr';
        }
        final startYrStr = _capitalize(
          _formatDate(_startDate!, 'MMM yyyy', localeTag),
        );
        return '$startYrStr - $endStr';
      case ExpressiveDatePickerMode.yearRange:
        if (_startDate == null) return l10n.datePickerChooseYears;
        final startStr = '${_startDate!.year}';
        if (_endDate == null) return '$startStr - ';
        return '$startStr - ${_endDate!.year}';
    }
  }

  bool get _canConfirm {
    switch (widget.mode) {
      case ExpressiveDatePickerMode.day:
      case ExpressiveDatePickerMode.month:
        return _selectedDate != null;
      case ExpressiveDatePickerMode.monthRange:
      case ExpressiveDatePickerMode.yearRange:
        return _startDate != null;
    }
  }

  void _onConfirm() {
    switch (widget.mode) {
      case ExpressiveDatePickerMode.day:
      case ExpressiveDatePickerMode.month:
        if (_selectedDate != null) {
          Navigator.of(context).pop(_selectedDate);
        }
      case ExpressiveDatePickerMode.monthRange:
        if (_startDate != null) {
          final endMonthDate = _endDate ?? _startDate!;
          Navigator.of(context).pop(
            DateTimeRange(
              start: DateTime(_startDate!.year, _startDate!.month),
              end: DateTime(
                endMonthDate.year,
                endMonthDate.month + 1,
                0,
                23,
                59,
                59,
              ),
            ),
          );
        }
      case ExpressiveDatePickerMode.yearRange:
        if (_startDate != null) {
          final endYearDate = _endDate ?? _startDate!;
          Navigator.of(context).pop(
            DateTimeRange(
              start: DateTime(_startDate!.year),
              end: DateTime(endYearDate.year, 12, 31, 23, 59, 59),
            ),
          );
        }
    }
  }

  Widget _buildDayGrid(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = MaterialLocalizations.of(context);
    final weekdays = l10n.narrowWeekdays;
    final firstDayOffset = l10n.firstDayOfWeekIndex;

    final year = _displayedDate.year;
    final month = _displayedDate.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstWeekday = DateTime(year, month).weekday % 7;
    final leadingEmpty = (firstWeekday - firstDayOffset + 7) % 7;
    final totalCells = leadingEmpty + daysInMonth;
    final rowCount = (totalCells / 7).ceil();
    final today = DateTime.now();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(7, (index) {
            final label = weekdays[(firstDayOffset + index) % 7];
            return Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: rowCount * 42.0,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 42,
            ),
            itemCount: rowCount * 7,
            itemBuilder: (context, index) {
              final dayNumber = index - leadingEmpty + 1;
              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return const SizedBox.shrink();
              }

              final date = DateTime(year, month, dayNumber);
              final isDisabled = _isDayDisabled(date);
              final isSelected =
                  _selectedDate != null && _isSameDay(date, _selectedDate!);
              final isToday = _isSameDay(date, today);

              return InkResponse(
                onTap: isDisabled ? null : () => _onDayTapped(date),
                radius: 20,
                child: Center(
                  child: AnimatedContainer(
                    duration: ExpressiveMotion.durationShort,
                    curve: ExpressiveMotion.springGentle,
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? colorScheme.primary
                          : Colors.transparent,
                      border: isToday && !isSelected
                          ? Border.all(color: colorScheme.primary, width: 1.5)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$dayNumber',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDisabled
                              ? colorScheme.onSurface.withValues(alpha: 0.38)
                              : isSelected
                              ? colorScheme.onPrimary
                              : isToday
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                          fontWeight: isSelected || isToday
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthCell(BuildContext context, int month, String localeTag) {
    final date = DateTime(_displayedDate.year, month);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDisabled = _isMonthDisabled(date);

    final isStart =
        widget.mode == ExpressiveDatePickerMode.monthRange &&
        _startDate != null &&
        _isSameMonth(date, _startDate!);
    final isEnd =
        widget.mode == ExpressiveDatePickerMode.monthRange &&
        _endDate != null &&
        _isSameMonth(date, _endDate!);
    final isInRange =
        widget.mode == ExpressiveDatePickerMode.monthRange &&
        _startDate != null &&
        _endDate != null &&
        date.isAfter(DateTime(_startDate!.year, _startDate!.month)) &&
        date.isBefore(DateTime(_endDate!.year, _endDate!.month)) &&
        !isStart &&
        !isEnd;
    final isSingleSelected =
        widget.mode == ExpressiveDatePickerMode.month &&
        _selectedDate != null &&
        _isSameMonth(date, _selectedDate!);
    final isToday = _isSameMonth(date, DateTime.now());
    final isSelectedCircle = isStart || isEnd || isSingleSelected;

    final pillContent = AnimatedContainer(
      duration: ExpressiveMotion.durationShort,
      curve: ExpressiveMotion.springGentle,
      width: 52,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelectedCircle ? colorScheme.primary : Colors.transparent,
        border: isToday && !isSelectedCircle
            ? Border.all(color: colorScheme.primary, width: 1.5)
            : null,
      ),
      child: Center(
        child: Text(
          _capitalize(_formatDate(date, 'MMM', localeTag)),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDisabled
                ? colorScheme.onSurface.withValues(alpha: 0.38)
                : isSelectedCircle
                ? colorScheme.onPrimary
                : isToday
                ? colorScheme.primary
                : colorScheme.onSurface,
            fontWeight: isToday || isSelectedCircle
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );

    if (widget.mode == ExpressiveDatePickerMode.monthRange) {
      final hasRightConnection =
          isStart &&
          _endDate != null &&
          DateTime(
            _startDate!.year,
            _startDate!.month,
          ).isBefore(DateTime(_endDate!.year, _endDate!.month));
      final hasLeftConnection =
          isEnd &&
          _startDate != null &&
          DateTime(
            _startDate!.year,
            _startDate!.month,
          ).isBefore(DateTime(_endDate!.year, _endDate!.month));

      return _RangeGridCell(
        onTap: isDisabled ? null : () => _onMonthTapped(date),
        hasRightConnection: hasRightConnection,
        hasLeftConnection: hasLeftConnection,
        isInRange: isInRange,
        rangeColor: colorScheme.primaryContainer,
        child: pillContent,
      );
    }

    return InkResponse(
      onTap: isDisabled ? null : () => _onMonthTapped(date),
      radius: 24,
      child: Center(child: pillContent),
    );
  }

  Widget _buildYearCell(BuildContext context, int year) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDisabled = _isYearDisabled(year);

    final isStart = _startDate != null && _startDate!.year == year;
    final isEnd = _endDate != null && _endDate!.year == year;
    final isInRange =
        _startDate != null &&
        _endDate != null &&
        year > _startDate!.year &&
        year < _endDate!.year &&
        !isStart &&
        !isEnd;
    final isToday = year == DateTime.now().year;
    final isSelectedCircle = isStart || isEnd;

    final pillContent = AnimatedContainer(
      duration: ExpressiveMotion.durationShort,
      curve: ExpressiveMotion.springGentle,
      width: 56,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelectedCircle ? colorScheme.primary : Colors.transparent,
        border: isToday && !isSelectedCircle
            ? Border.all(color: colorScheme.primary, width: 1.5)
            : null,
      ),
      child: Center(
        child: Text(
          '$year',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDisabled
                ? colorScheme.onSurface.withValues(alpha: 0.38)
                : isSelectedCircle
                ? colorScheme.onPrimary
                : isToday
                ? colorScheme.primary
                : colorScheme.onSurface,
            fontWeight: isToday || isSelectedCircle
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );

    final hasRightConnection =
        isStart && _endDate != null && _startDate!.year < _endDate!.year;
    final hasLeftConnection =
        isEnd && _startDate != null && _startDate!.year < _endDate!.year;

    return _RangeGridCell(
      onTap: isDisabled ? null : () => _onYearTapped(year),
      hasRightConnection: hasRightConnection,
      hasLeftConnection: hasLeftConnection,
      isInRange: isInRange,
      rangeColor: colorScheme.primaryContainer,
      child: pillContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = MaterialLocalizations.of(context);
    final expressiveL10n =
        ExpressiveLocalizations.of(context) ?? ExpressiveLocalizationsEn();
    final localeTag =
        (widget.locale ?? Localizations.maybeLocaleOf(context))
            ?.toLanguageTag() ??
        'en';

    final navTitle = switch (widget.mode) {
      ExpressiveDatePickerMode.day => _capitalize(
        _formatDate(_displayedDate, 'MMMM yyyy', localeTag),
      ),
      ExpressiveDatePickerMode.month ||
      ExpressiveDatePickerMode.monthRange => '${_displayedDate.year}',
      ExpressiveDatePickerMode.yearRange =>
        '$_yearPageStart - ${_yearPageStart + 11}',
    };

    return Dialog(
      backgroundColor: colorScheme.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 24,
                  right: 24,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.helpText ?? _defaultHelpText(expressiveL10n),
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _headlineString(localeTag, expressiveL10n),
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: colorScheme.outlineVariant.withValues(alpha: 0.4),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 12,
                  top: 10,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          navTitle,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    ExpressiveIconButton.circle(
                      size: ExpressiveIconButtonSize.small,
                      variant: ExpressiveIconButtonVariant.standard,
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowLeft01,
                      ),
                      onPressed: _navigatePrevious,
                    ),
                    const SizedBox(width: 4),
                    ExpressiveIconButton.circle(
                      size: ExpressiveIconButtonSize.small,
                      variant: ExpressiveIconButtonVariant.standard,
                      icon: const HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowRight01,
                      ),
                      onPressed: _navigateNext,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: widget.mode == ExpressiveDatePickerMode.day
                    ? _buildDayGrid(context)
                    : SizedBox(
                        height: 210,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            if (widget.mode ==
                                ExpressiveDatePickerMode.yearRange) {
                              return _buildYearCell(
                                context,
                                _yearPageStart + index,
                              );
                            }
                            return _buildMonthCell(
                              context,
                              index + 1,
                              localeTag,
                            );
                          },
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ExpressiveButton.text(
                      size: ExpressiveButtonSize.small,
                      label: widget.cancelLabel ?? l10n.cancelButtonLabel,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    ExpressiveButton.filled(
                      size: ExpressiveButtonSize.small,
                      label: widget.confirmLabel ?? l10n.okButtonLabel,
                      onPressed: _canConfirm ? _onConfirm : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RangeGridCell extends StatelessWidget {
  const _RangeGridCell({
    required this.onTap,
    required this.hasRightConnection,
    required this.hasLeftConnection,
    required this.isInRange,
    required this.rangeColor,
    required this.child,
  });

  final VoidCallback? onTap;
  final bool hasRightConnection;
  final bool hasLeftConnection;
  final bool isInRange;
  final Color rangeColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: Stack(
        children: [
          if (hasRightConnection)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: rangeColor,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (hasLeftConnection)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: rangeColor,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (isInRange)
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: rangeColor,
              ),
            ),
          Center(child: child),
        ],
      ),
    );
  }
}

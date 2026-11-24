import 'package:expressive_kit/src/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

/// Variantes de estilo para [ExpressiveTextFormField].
enum ExpressiveTextFormFieldVariant {
  /// Superficie tonal elevada sin borde visible en reposo y borde enfático al
  /// enfocar.
  filled,

  /// Fondo transparente con trazo perimetral redondeado y transición elástica.
  outlined,

  /// Superficie suavemente teñida con el contenedor secundario del tema.
  tonal,
}

/// Campo de texto de formulario Material 3 Expressive altamente configurable.
///
/// Integra validación nativa con [Form], esquinas redondeadas con morphing
/// suave al enfocar, física [ExpressiveMotion], variantes visuales
/// ([ExpressiveTextFormFieldVariant]) y acciones integradas opcionales como
/// botón de limpieza ([showClearButton]) y alternador de contraseña
/// ([showPasswordToggle]) utilizando HugeIcons.
class ExpressiveTextFormField extends FormField<String> {
  ExpressiveTextFormField({
    this.controller,
    this.focusNode,
    String? initialValue,
    this.variant = ExpressiveTextFormFieldVariant.filled,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixText,
    this.suffixText,
    this.counterText,
    this.prefixIcon,
    this.suffixIcon,
    this.floatingLabelBehavior,
    this.borderRadius,
    this.focusedBorderRadius,
    this.backgroundColor,
    this.focusedBackgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorColor,
    this.contentPadding,
    this.margin = EdgeInsets.zero,
    this.isDense = false,
    this.showClearButton = false,
    this.showPasswordToggle = false,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.inputFormatters,
    this.autofillHints,
    this.enableInteractiveSelection,
    this.scrollPadding = const EdgeInsets.all(20),
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    super.onSaved,
    super.validator,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.forceErrorText,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'Cannot provide both an initialValue and a controller.',
       ),
       assert(
         !obscureText || maxLines == 1,
         'Obscured fields cannot be multiline.',
       ),
       super(
         initialValue: controller != null
             ? controller.text
             : (initialValue ?? ''),
         builder: (FormFieldState<String> field) {
           final state = field as _ExpressiveTextFormFieldState;
           return state._buildField(field.context);
         },
       );

  /// Constructor con variante [ExpressiveTextFormFieldVariant.filled].
  ExpressiveTextFormField.filled({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? initialValue,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    String? prefixText,
    String? suffixText,
    String? counterText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FloatingLabelBehavior? floatingLabelBehavior,
    BorderRadius? borderRadius,
    BorderRadius? focusedBorderRadius,
    Color? backgroundColor,
    Color? focusedBackgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorColor,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isDense = false,
    bool showClearButton = false,
    bool showPasswordToggle = false,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool autofocus = false,
    bool readOnly = false,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    List<TextInputFormatter>? inputFormatters,
    Iterable<String>? autofillHints,
    bool? enableInteractiveSelection,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    String? forceErrorText,
    Key? key,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         initialValue: initialValue,
         variant: ExpressiveTextFormFieldVariant.filled,
         labelText: labelText,
         hintText: hintText,
         helperText: helperText,
         errorText: errorText,
         prefixText: prefixText,
         suffixText: suffixText,
         counterText: counterText,
         prefixIcon: prefixIcon,
         suffixIcon: suffixIcon,
         floatingLabelBehavior: floatingLabelBehavior,
         borderRadius: borderRadius,
         focusedBorderRadius: focusedBorderRadius,
         backgroundColor: backgroundColor,
         focusedBackgroundColor: focusedBackgroundColor,
         borderColor: borderColor,
         focusedBorderColor: focusedBorderColor,
         errorColor: errorColor,
         contentPadding: contentPadding,
         margin: margin,
         isDense: isDense,
         showClearButton: showClearButton,
         showPasswordToggle: showPasswordToggle,
         style: style,
         labelStyle: labelStyle,
         hintStyle: hintStyle,
         helperStyle: helperStyle,
         errorStyle: errorStyle,
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         textCapitalization: textCapitalization,
         textAlign: textAlign,
         textDirection: textDirection,
         autofocus: autofocus,
         readOnly: readOnly,
         obscureText: obscureText,
         obscuringCharacter: obscuringCharacter,
         autocorrect: autocorrect,
         enableSuggestions: enableSuggestions,
         maxLines: maxLines,
         minLines: minLines,
         expands: expands,
         maxLength: maxLength,
         maxLengthEnforcement: maxLengthEnforcement,
         inputFormatters: inputFormatters,
         autofillHints: autofillHints,
         enableInteractiveSelection: enableInteractiveSelection,
         scrollPadding: scrollPadding,
         onChanged: onChanged,
         onFieldSubmitted: onFieldSubmitted,
         onEditingComplete: onEditingComplete,
         onTap: onTap,
         onTapOutside: onTapOutside,
         onSaved: onSaved,
         validator: validator,
         enabled: enabled,
         autovalidateMode: autovalidateMode,
         restorationId: restorationId,
         forceErrorText: forceErrorText,
         key: key,
       );

  /// Constructor con variante [ExpressiveTextFormFieldVariant.outlined].
  ExpressiveTextFormField.outlined({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? initialValue,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    String? prefixText,
    String? suffixText,
    String? counterText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FloatingLabelBehavior? floatingLabelBehavior,
    BorderRadius? borderRadius,
    BorderRadius? focusedBorderRadius,
    Color? backgroundColor,
    Color? focusedBackgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorColor,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isDense = false,
    bool showClearButton = false,
    bool showPasswordToggle = false,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool autofocus = false,
    bool readOnly = false,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    List<TextInputFormatter>? inputFormatters,
    Iterable<String>? autofillHints,
    bool? enableInteractiveSelection,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    String? forceErrorText,
    Key? key,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         initialValue: initialValue,
         variant: ExpressiveTextFormFieldVariant.outlined,
         labelText: labelText,
         hintText: hintText,
         helperText: helperText,
         errorText: errorText,
         prefixText: prefixText,
         suffixText: suffixText,
         counterText: counterText,
         prefixIcon: prefixIcon,
         suffixIcon: suffixIcon,
         floatingLabelBehavior: floatingLabelBehavior,
         borderRadius: borderRadius,
         focusedBorderRadius: focusedBorderRadius,
         backgroundColor: backgroundColor,
         focusedBackgroundColor: focusedBackgroundColor,
         borderColor: borderColor,
         focusedBorderColor: focusedBorderColor,
         errorColor: errorColor,
         contentPadding: contentPadding,
         margin: margin,
         isDense: isDense,
         showClearButton: showClearButton,
         showPasswordToggle: showPasswordToggle,
         style: style,
         labelStyle: labelStyle,
         hintStyle: hintStyle,
         helperStyle: helperStyle,
         errorStyle: errorStyle,
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         textCapitalization: textCapitalization,
         textAlign: textAlign,
         textDirection: textDirection,
         autofocus: autofocus,
         readOnly: readOnly,
         obscureText: obscureText,
         obscuringCharacter: obscuringCharacter,
         autocorrect: autocorrect,
         enableSuggestions: enableSuggestions,
         maxLines: maxLines,
         minLines: minLines,
         expands: expands,
         maxLength: maxLength,
         maxLengthEnforcement: maxLengthEnforcement,
         inputFormatters: inputFormatters,
         autofillHints: autofillHints,
         enableInteractiveSelection: enableInteractiveSelection,
         scrollPadding: scrollPadding,
         onChanged: onChanged,
         onFieldSubmitted: onFieldSubmitted,
         onEditingComplete: onEditingComplete,
         onTap: onTap,
         onTapOutside: onTapOutside,
         onSaved: onSaved,
         validator: validator,
         enabled: enabled,
         autovalidateMode: autovalidateMode,
         restorationId: restorationId,
         forceErrorText: forceErrorText,
         key: key,
       );

  /// Constructor con variante [ExpressiveTextFormFieldVariant.tonal].
  ExpressiveTextFormField.tonal({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? initialValue,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    String? prefixText,
    String? suffixText,
    String? counterText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FloatingLabelBehavior? floatingLabelBehavior,
    BorderRadius? borderRadius,
    BorderRadius? focusedBorderRadius,
    Color? backgroundColor,
    Color? focusedBackgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorColor,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    bool isDense = false,
    bool showClearButton = false,
    bool showPasswordToggle = false,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool autofocus = false,
    bool readOnly = false,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    List<TextInputFormatter>? inputFormatters,
    Iterable<String>? autofillHints,
    bool? enableInteractiveSelection,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    String? forceErrorText,
    Key? key,
  }) : this(
         controller: controller,
         focusNode: focusNode,
         initialValue: initialValue,
         variant: ExpressiveTextFormFieldVariant.tonal,
         labelText: labelText,
         hintText: hintText,
         helperText: helperText,
         errorText: errorText,
         prefixText: prefixText,
         suffixText: suffixText,
         counterText: counterText,
         prefixIcon: prefixIcon,
         suffixIcon: suffixIcon,
         floatingLabelBehavior: floatingLabelBehavior,
         borderRadius: borderRadius,
         focusedBorderRadius: focusedBorderRadius,
         backgroundColor: backgroundColor,
         focusedBackgroundColor: focusedBackgroundColor,
         borderColor: borderColor,
         focusedBorderColor: focusedBorderColor,
         errorColor: errorColor,
         contentPadding: contentPadding,
         margin: margin,
         isDense: isDense,
         showClearButton: showClearButton,
         showPasswordToggle: showPasswordToggle,
         style: style,
         labelStyle: labelStyle,
         hintStyle: hintStyle,
         helperStyle: helperStyle,
         errorStyle: errorStyle,
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         textCapitalization: textCapitalization,
         textAlign: textAlign,
         textDirection: textDirection,
         autofocus: autofocus,
         readOnly: readOnly,
         obscureText: obscureText,
         obscuringCharacter: obscuringCharacter,
         autocorrect: autocorrect,
         enableSuggestions: enableSuggestions,
         maxLines: maxLines,
         minLines: minLines,
         expands: expands,
         maxLength: maxLength,
         maxLengthEnforcement: maxLengthEnforcement,
         inputFormatters: inputFormatters,
         autofillHints: autofillHints,
         enableInteractiveSelection: enableInteractiveSelection,
         scrollPadding: scrollPadding,
         onChanged: onChanged,
         onFieldSubmitted: onFieldSubmitted,
         onEditingComplete: onEditingComplete,
         onTap: onTap,
         onTapOutside: onTapOutside,
         onSaved: onSaved,
         validator: validator,
         enabled: enabled,
         autovalidateMode: autovalidateMode,
         restorationId: restorationId,
         forceErrorText: forceErrorText,
         key: key,
       );

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ExpressiveTextFormFieldVariant variant;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final String? prefixText;
  final String? suffixText;
  final String? counterText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final BorderRadius? borderRadius;
  final BorderRadius? focusedBorderRadius;
  final Color? backgroundColor;
  final Color? focusedBackgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorColor;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry margin;
  final bool isDense;
  final bool showClearButton;
  final bool showPasswordToggle;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final String obscuringCharacter;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool? enableInteractiveSelection;
  final EdgeInsets scrollPadding;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;

  @override
  FormFieldState<String> createState() => _ExpressiveTextFormFieldState();
}

class _ExpressiveTextFormFieldState extends FormFieldState<String> {
  TextEditingController? _internalController;
  FocusNode? _internalFocusNode;
  bool _isFocused = false;
  late bool _obscureText;

  ExpressiveTextFormField get _widget => widget as ExpressiveTextFormField;

  TextEditingController get _effectiveController =>
      _widget.controller ?? _internalController!;

  FocusNode get _effectiveFocusNode => _widget.focusNode ?? _internalFocusNode!;

  @override
  void initState() {
    super.initState();
    _obscureText = _widget.obscureText;

    if (_widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    }
    _effectiveController.addListener(_handleControllerChanged);

    if (_widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    _isFocused = _effectiveFocusNode.hasFocus;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(ExpressiveTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _internalController?.removeListener(_handleControllerChanged);

      if (oldWidget.controller != null && _widget.controller == null) {
        _internalController = TextEditingController.fromValue(
          oldWidget.controller!.value,
        );
      } else if (oldWidget.controller == null && _widget.controller != null) {
        _internalController?.dispose();
        _internalController = null;
      }

      _effectiveController.addListener(_handleControllerChanged);
      if (_effectiveController.text != value) {
        setValue(_effectiveController.text);
      }
    }

    if (_widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      _internalFocusNode?.removeListener(_handleFocusChanged);

      if (oldWidget.focusNode != null && _widget.focusNode == null) {
        _internalFocusNode = FocusNode();
      } else if (oldWidget.focusNode == null && _widget.focusNode != null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      }

      _isFocused = _effectiveFocusNode.hasFocus;
      _effectiveFocusNode.addListener(_handleFocusChanged);
    }

    if (_widget.obscureText != oldWidget.obscureText) {
      _obscureText = _widget.obscureText;
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _internalController?.dispose();
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _effectiveController.text = widget.initialValue ?? '';
    _widget.onChanged?.call(_effectiveController.text);
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    } else if (_widget.showClearButton || _widget.maxLength != null) {
      setState(() {});
    }
  }

  void _handleFocusChanged() {
    final hasFocus = _effectiveFocusNode.hasFocus;
    if (hasFocus != _isFocused) {
      setState(() => _isFocused = hasFocus);
    }
  }

  void _handleClear() {
    _effectiveController.clear();
    didChange('');
    _widget.onChanged?.call('');
  }

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  Widget _buildField(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final enabled = _widget.enabled;
    final effectiveErrorText = _widget.errorText ?? errorText;
    final hasError =
        effectiveErrorText != null && effectiveErrorText.isNotEmpty;
    final resolvedErrorColor = _widget.errorColor ?? colorScheme.error;

    // Resolve surface & border colors per Material 3 Expressive variant.
    Color defaultBg;
    Color defaultFocusedBg;
    Color defaultBorder;
    Color defaultFocusedBorder = colorScheme.primary;

    switch (_widget.variant) {
      case ExpressiveTextFormFieldVariant.filled:
        defaultBg = enabled
            ? (hasError
                  ? colorScheme.errorContainer.withValues(alpha: 0.25)
                  : colorScheme.surfaceContainerHigh)
            : colorScheme.onSurface.withValues(alpha: 0.04);
        defaultFocusedBg = hasError
            ? colorScheme.errorContainer.withValues(alpha: 0.32)
            : colorScheme.surfaceContainerHighest;
        defaultBorder = Colors.transparent;
      case ExpressiveTextFormFieldVariant.outlined:
        defaultBg = enabled
            ? Colors.transparent
            : colorScheme.onSurface.withValues(alpha: 0.04);
        defaultFocusedBg = Colors.transparent;
        defaultBorder = enabled
            ? colorScheme.outline
            : colorScheme.onSurface.withValues(alpha: 0.12);
      case ExpressiveTextFormFieldVariant.tonal:
        defaultBg = enabled
            ? (hasError
                  ? colorScheme.errorContainer.withValues(alpha: 0.32)
                  : colorScheme.secondaryContainer.withValues(alpha: 0.45))
            : colorScheme.onSurface.withValues(alpha: 0.06);
        defaultFocusedBg = hasError
            ? colorScheme.errorContainer.withValues(alpha: 0.4)
            : colorScheme.secondaryContainer.withValues(alpha: 0.72);
        defaultBorder = Colors.transparent;
    }

    final effectiveBg = _isFocused
        ? (_widget.focusedBackgroundColor ?? defaultFocusedBg)
        : (_widget.backgroundColor ?? defaultBg);

    final effectiveBorderColor = hasError
        ? resolvedErrorColor
        : _isFocused
        ? (_widget.focusedBorderColor ?? defaultFocusedBorder)
        : (_widget.borderColor ?? defaultBorder);

    final borderWidth = _isFocused ? 2.0 : 1.5;

    final baseRadius = _widget.borderRadius ?? BorderRadius.circular(20);
    final activeRadius =
        _widget.focusedBorderRadius ??
        (_widget.borderRadius ?? BorderRadius.circular(24));
    final effectiveRadius = _isFocused ? activeRadius : baseRadius;

    final iconColor = !enabled
        ? colorScheme.onSurface.withValues(alpha: 0.38)
        : hasError
        ? resolvedErrorColor
        : _isFocused
        ? (_widget.focusedBorderColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;

    final isMultiline =
        _widget.expands ||
        _widget.maxLines == null ||
        (_widget.maxLines != null && _widget.maxLines! > 1);

    final showClear =
        _widget.showClearButton &&
        enabled &&
        !_widget.readOnly &&
        _effectiveController.text.isNotEmpty;

    final showPassword = _widget.obscureText && _widget.showPasswordToggle;

    final effectiveContentPadding =
        _widget.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: 16,
          vertical: _widget.isDense ? 10 : 14,
        );

    final defaultTextStyle = theme.textTheme.bodyLarge?.copyWith(
      color: enabled
          ? colorScheme.onSurface
          : colorScheme.onSurface.withValues(alpha: 0.38),
    );

    final defaultLabelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: !enabled
          ? colorScheme.onSurface.withValues(alpha: 0.38)
          : hasError
          ? resolvedErrorColor
          : _isFocused
          ? (_widget.focusedBorderColor ?? colorScheme.primary)
          : colorScheme.onSurfaceVariant,
      fontWeight: _isFocused ? FontWeight.w600 : FontWeight.w500,
    );

    final defaultHintStyle = theme.textTheme.bodyLarge?.copyWith(
      color: colorScheme.onSurfaceVariant.withValues(
        alpha: enabled ? 0.72 : 0.38,
      ),
    );

    final effectiveCounterText =
        _widget.counterText ??
        (_widget.maxLength != null
            ? '${_effectiveController.text.length}/${_widget.maxLength}'
            : null);

    final hasFooter =
        hasError ||
        (_widget.helperText != null && _widget.helperText!.isNotEmpty) ||
        (effectiveCounterText != null && effectiveCounterText.isNotEmpty);

    return Padding(
      padding: _widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: enabled
                ? () {
                    if (!_effectiveFocusNode.hasFocus) {
                      _effectiveFocusNode.requestFocus();
                    }
                    _widget.onTap?.call();
                  }
                : null,
            behavior: HitTestBehavior.translucent,
            child: AnimatedContainer(
              duration: ExpressiveMotion.durationShort,
              curve: ExpressiveMotion.springGentle,
              decoration: BoxDecoration(
                color: effectiveBg,
                borderRadius: effectiveRadius,
                border: Border.all(
                  color: effectiveBorderColor,
                  width: borderWidth,
                ),
              ),
              padding: EdgeInsets.only(
                left: _widget.prefixIcon != null ? 14 : 0,
                right: (_widget.suffixIcon != null || showClear || showPassword)
                    ? 10
                    : 0,
              ),
              child: Row(
                crossAxisAlignment: isMultiline
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (_widget.prefixIcon != null) ...[
                    Padding(
                      padding: EdgeInsets.only(top: isMultiline ? 14 : 0),
                      child: IconTheme(
                        data: IconThemeData(color: iconColor, size: 22),
                        child: _widget.prefixIcon!,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Expanded(
                    child: TextField(
                      controller: _effectiveController,
                      focusNode: _effectiveFocusNode,
                      enabled: enabled,
                      readOnly: _widget.readOnly,
                      autofocus: _widget.autofocus,
                      obscureText: _obscureText,
                      obscuringCharacter: _widget.obscuringCharacter,
                      autocorrect: _widget.autocorrect,
                      enableSuggestions: _widget.enableSuggestions,
                      keyboardType: _widget.keyboardType,
                      textInputAction: _widget.textInputAction,
                      textCapitalization: _widget.textCapitalization,
                      textAlign: _widget.textAlign,
                      textDirection: _widget.textDirection,
                      maxLines: _widget.maxLines,
                      minLines: _widget.minLines,
                      expands: _widget.expands,
                      maxLength: _widget.maxLength,
                      maxLengthEnforcement: _widget.maxLengthEnforcement,
                      inputFormatters: _widget.inputFormatters,
                      autofillHints: _widget.autofillHints,
                      enableInteractiveSelection:
                          _widget.enableInteractiveSelection,
                      scrollPadding: _widget.scrollPadding,
                      style: _widget.style ?? defaultTextStyle,
                      cursorColor: hasError
                          ? resolvedErrorColor
                          : (_widget.focusedBorderColor ?? colorScheme.primary),
                      onChanged: (val) {
                        didChange(val);
                        _widget.onChanged?.call(val);
                      },
                      onSubmitted: _widget.onFieldSubmitted,
                      onEditingComplete: _widget.onEditingComplete,
                      onTap: _widget.onTap,
                      onTapOutside: _widget.onTapOutside,
                      decoration: InputDecoration(
                        labelText: _widget.labelText,
                        hintText: _widget.hintText,
                        prefixText: _widget.prefixText,
                        suffixText: _widget.suffixText,
                        labelStyle: _widget.labelStyle ?? defaultLabelStyle,
                        floatingLabelStyle:
                            _widget.labelStyle ?? defaultLabelStyle,
                        hintStyle: _widget.hintStyle ?? defaultHintStyle,
                        floatingLabelBehavior: _widget.floatingLabelBehavior,
                        isDense: _widget.isDense,
                        contentPadding: effectiveContentPadding,
                        counterText: '',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  if (showClear)
                    Padding(
                      padding: EdgeInsets.only(top: isMultiline ? 10 : 0),
                      child: Semantics(
                        button: true,
                        label: 'Clear text',
                        child: ExpressivePressable(
                          onTap: _handleClear,
                          borderRadius: BorderRadius.circular(999),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedCancel01,
                              color: colorScheme.onSurfaceVariant,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (showPassword)
                    Padding(
                      padding: EdgeInsets.only(top: isMultiline ? 10 : 0),
                      child: Semantics(
                        button: true,
                        label: _obscureText ? 'Show password' : 'Hide password',
                        child: ExpressivePressable(
                          onTap: _togglePasswordVisibility,
                          borderRadius: BorderRadius.circular(999),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: HugeIcon(
                              icon: _obscureText
                                  ? HugeIcons.strokeRoundedView
                                  : HugeIcons.strokeRoundedViewOffSlash,
                              color: iconColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_widget.suffixIcon != null)
                    Padding(
                      padding: EdgeInsets.only(
                        left: (showClear || showPassword) ? 2 : 4,
                        top: isMultiline ? 14 : 0,
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: iconColor, size: 22),
                        child: _widget.suffixIcon!,
                      ),
                    ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: ExpressiveMotion.durationShort,
            curve: ExpressiveMotion.springGentle,
            alignment: Alignment.topLeft,
            child: hasFooter
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: hasError
                              ? Text(
                                  effectiveErrorText,
                                  style:
                                      _widget.errorStyle ??
                                      theme.textTheme.bodySmall?.copyWith(
                                        color: resolvedErrorColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                )
                              : (_widget.helperText != null &&
                                    _widget.helperText!.isNotEmpty)
                              ? Text(
                                  _widget.helperText!,
                                  style:
                                      _widget.helperStyle ??
                                      theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        if (effectiveCounterText != null &&
                            effectiveCounterText.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            effectiveCounterText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: hasError
                                  ? resolvedErrorColor
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

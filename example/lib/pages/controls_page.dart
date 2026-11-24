import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/section_header.dart';

class ControlsPage extends StatefulWidget {
  const ControlsPage({required this.onShowFeedback, super.key});

  final ValueChanged<String> onShowFeedback;

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedGroup = 'living_room';
  bool _btnLoading = false;
  String _selectedFrequency = 'Weekly';
  bool _switchVal1 = true;
  bool _switchVal2 = false;
  double _sliderVal = 65.0;
  double _sliderStepVal = 3.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SectionHeader(
          title: 'Buttons (ExpressiveButton)',
          subtitle: 'Material 3 variants with spring curves and responsive interactive states.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton(
              label: 'Filled',
              variant: ExpressiveButtonVariant.filled,
              onPressed: () => widget.onShowFeedback('Filled button pressed'),
            ),
            ExpressiveButton(
              label: 'Tonal',
              variant: ExpressiveButtonVariant.tonal,
              onPressed: () => widget.onShowFeedback('Tonal button pressed'),
            ),
            ExpressiveButton(
              label: 'Outlined',
              variant: ExpressiveButtonVariant.outlined,
              onPressed: () => widget.onShowFeedback('Outlined button pressed'),
            ),
            ExpressiveButton(
              label: 'Elevated',
              variant: ExpressiveButtonVariant.elevated,
              onPressed: () => widget.onShowFeedback('Elevated button pressed'),
            ),
            ExpressiveButton(
              label: 'Text',
              variant: ExpressiveButtonVariant.text,
              onPressed: () => widget.onShowFeedback('Text button pressed'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton(
              label: 'With Icon',
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedStar, size: 20),
              variant: ExpressiveButtonVariant.filled,
              onPressed: () =>
                  widget.onShowFeedback('Button with icon pressed'),
            ),
            ExpressiveButton(
              label: 'Next',
              trailingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              variant: ExpressiveButtonVariant.tonal,
              onPressed: () => widget.onShowFeedback('Next button pressed'),
            ),
            ExpressiveButton(
              label: _btnLoading ? 'Loading...' : 'Load Data',
              isLoading: _btnLoading,
              variant: ExpressiveButtonVariant.outlined,
              onPressed: () {
                setState(() => _btnLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) setState(() => _btnLoading = false);
                });
              },
            ),
            const ExpressiveButton(label: 'Disabled', onPressed: null),
          ],
        ),
        const SizedBox(height: 12),
        ExpressiveButton(
          label: 'Expanded Button (Full Width)',
          isExpanded: true,
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedCheckmarkCircle01,
            size: 20,
          ),
          variant: ExpressiveButtonVariant.filled,
          onPressed: () => widget.onShowFeedback('Expanded button pressed'),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Split Button (ExpressiveSplitButton)',
          subtitle: 'Continuous primary action with an expandable secondary dropdown.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ExpressiveSplitButton(
              label: 'Save File',
              leadingIcon: const HugeIcon(
                icon: HugeIcons.strokeRoundedFloppyDisk,
                size: 20,
              ),
              variant: ExpressiveButtonVariant.filled,
              onPressed: () => widget.onShowFeedback('Save file'),
              onTrailingPressed: () =>
                  widget.onShowFeedback('More save options'),
            ),
            ExpressiveSplitButton(
              label: 'Export Data',
              variant: ExpressiveButtonVariant.tonal,
              onPressed: () => widget.onShowFeedback('Export data'),
              onTrailingPressed: () => widget.onShowFeedback('Export format'),
            ),
            ExpressiveSplitButton(
              label: 'Send',
              variant: ExpressiveButtonVariant.outlined,
              onPressed: () => widget.onShowFeedback('Send'),
              onTrailingPressed: () => widget.onShowFeedback('Schedule send'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Segmented Picker (ExpressiveButtonGroup)',
          subtitle: 'Button group with single selection and continuous sliding pill indicator.',
        ),
        const SizedBox(height: 12),
        ExpressiveButtonGroup<String>(
          selectedValue: _selectedFrequency,
          onSelected: (val) {
            setState(() => _selectedFrequency = val);
            widget.onShowFeedback('Selected frequency: $val');
          },
          items: const [
            ExpressiveButtonGroupItem(
              value: 'Daily',
              label: 'Daily',
              icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar01, size: 18),
            ),
            ExpressiveButtonGroupItem(
              value: 'Weekly',
              label: 'Weekly',
              icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar02, size: 18),
            ),
            ExpressiveButtonGroupItem(
              value: 'Monthly',
              label: 'Monthly',
              icon: HugeIcon(icon: HugeIcons.strokeRoundedCalendar03, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Icon Buttons (ExpressiveIconButton)',
          subtitle: 'Shapes: circular, squircle, and rounded rectangle, with badge options.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedFavourite),
              variant: ExpressiveIconButtonVariant.filled,
              tooltip: 'Favorite (Filled Circle)',
              onPressed: () => widget.onShowFeedback('Favorite pressed'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedShare01),
              variant: ExpressiveIconButtonVariant.tonal,
              tooltip: 'Share (Tonal Circle)',
              onPressed: () => widget.onShowFeedback('Share pressed'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedBookmark02),
              variant: ExpressiveIconButtonVariant.outlined,
              tooltip: 'Bookmark (Outlined Circle)',
              onPressed: () => widget.onShowFeedback('Bookmark pressed'),
            ),
            ExpressiveIconButton.squircle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedCamera01),
              variant: ExpressiveIconButtonVariant.filled,
              tooltip: 'Camera (Squircle Filled)',
              onPressed: () => widget.onShowFeedback('Camera pressed'),
            ),
            ExpressiveIconButton.squircle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedImage01),
              variant: ExpressiveIconButtonVariant.tonal,
              tooltip: 'Gallery (Squircle Tonal)',
              onPressed: () => widget.onShowFeedback('Gallery pressed'),
            ),
            ExpressiveIconButton(
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedSlidersHorizontal,
              ),
              shape: ExpressiveIconButtonShape.roundedRectangle,
              variant: ExpressiveIconButtonVariant.filled,
              tooltip: 'Settings (Rounded Rect)',
              onPressed: () => widget.onShowFeedback('Settings pressed'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedMail01),
              variant: ExpressiveIconButtonVariant.tonal,
              badgeText: '9+',
              tooltip: 'Messages with Badge',
              onPressed: () => widget.onShowFeedback('Messages: 9+ unread'),
            ),
            ExpressiveIconButton.circle(
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedNotification01),
              showBadgeDot: true,
              tooltip: 'Alert with Dot',
              onPressed: () => widget.onShowFeedback('Active alert'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Switches (ExpressiveSwitch)',
          subtitle: 'Capsule track with check/cross icons in the thumb and spring physics.',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ExpressiveSwitch(
              value: _switchVal1,
              onChanged: (val) => setState(() => _switchVal1 = val),
            ),
            const SizedBox(width: 12),
            Text(
              _switchVal1 ? 'Enabled (With icons)' : 'Disabled (With icons)',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ExpressiveSwitch(
              value: _switchVal2,
              showIcons: false,
              onChanged: (val) => setState(() => _switchVal2 = val),
            ),
            const SizedBox(width: 12),
            Text(
              _switchVal2 ? 'Enabled (No icons)' : 'Disabled (No icons)',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Sliders (ExpressiveSlider)',
          subtitle: 'Thick capsule track with pill thumb indicator and stepper buttons (+/-).',
        ),
        const SizedBox(height: 8),
        ExpressiveSlider(
          value: _sliderVal,
          min: 0,
          max: 100,
          title: 'Media volume',
          subtitle: 'Current level: ${_sliderVal.toInt()}%',
          onChanged: (val) => setState(() => _sliderVal = val),
        ),
        const SizedBox(height: 12),
        ExpressiveSlider(
          value: _sliderStepVal,
          min: 1,
          max: 5,
          divisions: 4,
          title: 'Graphics quality (Discrete)',
          subtitle: 'Level: ${_sliderStepVal.toInt()} of 5 stars',
          onChanged: (val) => setState(() => _sliderStepVal = val),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Text Form Fields (ExpressiveTextFormField)',
          subtitle: 'Configurable M3 Expressive form inputs with filled, outlined, and tonal variants, validation, and HugeIcons actions.',
        ),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: Column(
            children: [
              ExpressiveTextFormField.filled(
                labelText: 'Email address',
                hintText: 'alex@expressive.dev',
                helperText: 'Filled variant with clear button',
                keyboardType: TextInputType.emailAddress,
                showClearButton: true,
                prefixIcon: const HugeIcon(icon: HugeIcons.strokeRoundedMail01),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!val.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ExpressiveTextFormField.outlined(
                labelText: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                showPasswordToggle: true,
                validator: (val) {
                  if (val == null || val.length < 6) {
                    return 'Must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ExpressiveTextFormField.tonal(
                labelText: 'Notes',
                hintText: 'Write a short expressive bio...',
                maxLines: 3,
                maxLength: 120,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ExpressiveButton.filled(
                  label: 'Validate Form',
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                    size: 18,
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      widget.onShowFeedback('Form is valid!');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Dropdown Button (ExpressiveDropdownButton)',
          subtitle: 'Expressive card trigger that opens a 28dp rounded modal bottom sheet for item selection.',
        ),
        const SizedBox(height: 12),
        ExpressiveDropdownButton<String>(
          label: 'Device group',
          modalTitle: 'Select a group',
          hintText: 'No group assigned',
          value: _selectedGroup,
          items: const [
            ExpressiveDropdownItem<String>(
              value: 'living_room',
              label: 'Living Room',
              subtitle: 'Lights, TV & Speaker',
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome01,
                strokeWidth: 2,
              ),
            ),
            ExpressiveDropdownItem<String>(
              value: 'workspace',
              label: 'Workspace',
              subtitle: 'Desk lamp & Monitor',
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedDashboardSquare01,
                strokeWidth: 2,
              ),
            ),
            ExpressiveDropdownItem<String>(
              value: 'favorites',
              label: 'Favorites',
              subtitle: 'Quick access devices',
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedFavourite,
                strokeWidth: 2,
              ),
            ),
            ExpressiveDropdownItem<String>(
              value: 'notifications',
              label: 'Alerts & Sensors',
              subtitle: 'Motion & Door sensors',
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedNotification01,
                strokeWidth: 2,
              ),
            ),
          ],
          onChanged: (val) {
            setState(() => _selectedGroup = val);
            widget.onShowFeedback('Selected group: $val');
          },
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

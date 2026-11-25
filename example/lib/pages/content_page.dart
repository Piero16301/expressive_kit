import 'package:expressive_kit/expressive_kit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/section_header.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onShowFeedback,
    super.key,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final ValueChanged<String> onShowFeedback;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  String _syncFrequency = '15 min';
  String _pickedDateLabel = 'No date or month selected';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SectionHeader(
          title: 'Search Bar (ExpressiveSearchBar)',
          subtitle: '28dp pill container with search icon and embedded trailing actions.',
        ),
        const SizedBox(height: 12),
        ExpressiveSearchBar(
          hintText: 'Search components, colors, or settings...',
          margin: EdgeInsets.zero,
          trailing: ExpressiveIconButton.circle(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedMic01, size: 20),
            tooltip: 'Voice search',
            onPressed: () => widget.onShowFeedback('Voice search activated'),
          ),
          onSubmitted: (query) => widget.onShowFeedback('Searching: "$query"'),
        ),
        const SizedBox(height: 12),
        ExpressiveSearchBar(
          hintText: 'Read-only mode (Tap to explore)',
          readOnly: true,
          margin: EdgeInsets.zero,
          trailing: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowRight01,
            size: 16,
          ),
          onTap: () => widget.onShowFeedback('Search modal opened'),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Multi-Browse Carousel (ExpressiveCarousel)',
          subtitle: 'Smooth horizontal scrolling with 24dp adaptive corners and spring physics.',
        ),
        const SizedBox(height: 12),
        ExpressiveCarousel(
          height: 160,
          itemExtent: 220,
          items: [
            ExpressiveCarouselItem(
              onTap: () => widget.onShowFeedback('Card 1 selected'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedPaintBoard,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Material 3\nExpressive Theme',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpressiveCarouselItem(
              onTap: () => widget.onShowFeedback('Card 2 selected'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedMagicWand01,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Spring Bouncy\nPhysics Motion',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ExpressiveCarouselItem(
              onTap: () => widget.onShowFeedback('Card 3 selected'),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00897B), Color(0xFF4DB6AC)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedCube,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      '17 Native\nComponents & Tests',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Card Group & List Tiles (ExpressiveCardGroup & ExpressiveListTile)',
          subtitle: 'Pixel Settings list style with vibrant circular badges and automatic dividers.',
        ),
        const SizedBox(height: 12),
        ExpressiveCardGroup(
          title: 'Connectivity Preferences',
          margin: EdgeInsets.zero,
          children: [
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedWifi01,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF1E88E5),
                foregroundColor: Colors.white,
              ),
              title: const Text('Internet & network'),
              subtitle: const Text('Home Wi-Fi 5GHz connected'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              onTap: () => widget.onShowFeedback('Wi-Fi settings'),
            ),
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedBluetooth,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF5E35B1),
                foregroundColor: Colors.white,
              ),
              title: const Text('Connected devices'),
              subtitle: const Text('Pixel Buds Pro headphones'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              onTap: () => widget.onShowFeedback('Bluetooth settings'),
            ),
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedShield01,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF2E7D32),
                foregroundColor: Colors.white,
              ),
              title: const Text('Security & privacy'),
              subtitle: const Text('Device protected and up to date'),
              trailing: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                size: 20,
              ),
              onTap: () => widget.onShowFeedback('Security settings'),
            ),
            ExpressiveListTile(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedMoon02,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFFEF6C00),
                foregroundColor: Colors.white,
              ),
              title: const Text('Dark theme'),
              subtitle: const Text('Toggle visual appearance'),
              showSplitDivider: true,
              onTap: widget.onToggleTheme,
              secondaryTrailing: ExpressiveSwitch(
                value: widget.isDarkMode,
                onChanged: (_) => widget.onToggleTheme(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Standalone Card (ExpressiveCard)',
          subtitle: 'Elevated surface with smooth 24dp corners and responsive touch reaction.',
        ),
        const SizedBox(height: 12),
        ExpressiveCard(
          margin: EdgeInsets.zero,
          onTap: () => widget.onShowFeedback('Standalone card pressed'),
          child: const Row(
            children: [
              ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedStar,
                  color: Colors.black87,
                  size: 20,
                ),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black87,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expressive Experience',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Modern design language inspired by Material Design 3 Expressive guidelines.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Modal List Tiles (ExpressiveListTile.modal)',
          subtitle: 'Settings rows that automatically open a 28dp rounded Expressive modal bottom sheet.',
        ),
        const SizedBox(height: 12),
        ExpressiveCardGroup(
          margin: EdgeInsets.zero,
          children: [
            ExpressiveListTile.modal(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedCalendar01,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF00897B),
                foregroundColor: Colors.white,
              ),
              title: const Text('Sync frequency'),
              subtitle: const Text('Tap to choose interval'),
              trailing: Text(
                _syncFrequency,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              modalTitle: 'Sync frequency',
              modalItemsBuilder: (modalContext) {
                final colorScheme = Theme.of(modalContext).colorScheme;
                const options = [
                  ('15 min', 'Every 15 minutes'),
                  ('1 hr', 'Every hour'),
                  ('Manual', 'Manual only'),
                ];
                return options.map((option) {
                  final (shortLabel, fullLabel) = option;
                  final isSelected = _syncFrequency == shortLabel;
                  return ListTile(
                    leading: HugeIcon(
                      icon: HugeIcons.strokeRoundedCalendar01,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                    title: Text(
                      fullLabel,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                      ),
                    ),
                    trailing: isSelected
                        ? HugeIcon(
                            icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                            color: colorScheme.primary,
                          )
                        : null,
                    onTap: () {
                      setState(() => _syncFrequency = shortLabel);
                      Navigator.pop(modalContext);
                      widget.onShowFeedback('Sync set to $fullLabel');
                    },
                  );
                }).toList();
              },
            ),
            ExpressiveListTile.modal(
              leading: const ExpressiveBadge(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedLayers01,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Color(0xFF3949AB),
                foregroundColor: Colors.white,
              ),
              title: const Text('Storage overview'),
              subtitle: const Text('Custom modal content'),
              modalTitle: 'Storage overview',
              modalBuilder: (modalContext) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ExpressiveLinearProgressIndicator(value: 0.68),
                    const SizedBox(height: 12),
                    Text(
                      '68% used (6.8 GB of 10 GB)',
                      style: Theme.of(modalContext).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    ExpressiveButton.tonal(
                      label: 'Close',
                      onPressed: () => Navigator.pop(modalContext),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Modal Bottom Sheet (showExpressiveModalBottomSheet)',
          subtitle: 'Direct helper for 28dp rounded bottom sheets with itemsBuilder or custom builder.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton.filled(
              label: 'Action Sheet (itemsBuilder)',
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedShare01,
                size: 18,
              ),
              onPressed: () => showExpressiveModalBottomSheet<void>(
                context: context,
                title: 'Quick actions',
                itemsBuilder: (modalContext) => [
                  ListTile(
                    leading: const HugeIcon(
                      icon: HugeIcons.strokeRoundedShare01,
                    ),
                    title: const Text('Share'),
                    onTap: () {
                      Navigator.pop(modalContext);
                      widget.onShowFeedback('Action: Share');
                    },
                  ),
                  ListTile(
                    leading: const HugeIcon(
                      icon: HugeIcons.strokeRoundedBookmark02,
                    ),
                    title: const Text('Bookmark'),
                    onTap: () {
                      Navigator.pop(modalContext);
                      widget.onShowFeedback('Action: Bookmark');
                    },
                  ),
                  ListTile(
                    leading: const HugeIcon(
                      icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                    ),
                    title: const Text('Archive'),
                    onTap: () {
                      Navigator.pop(modalContext);
                      widget.onShowFeedback('Action: Archive');
                    },
                  ),
                ],
              ),
            ),
            ExpressiveButton.tonal(
              label: 'Custom Sheet (builder)',
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedPaintBoard,
                size: 18,
              ),
              onPressed: () => showExpressiveModalBottomSheet<void>(
                context: context,
                title: 'Expressive Bottom Sheet',
                builder: (modalContext) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'This sheet is rendered directly with showExpressiveModalBottomSheet using a custom builder.',
                        style: Theme.of(modalContext).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ExpressiveButton.filled(
                        label: 'Got it',
                        onPressed: () => Navigator.pop(modalContext),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Alert Dialog (ExpressiveAlertDialog)',
          subtitle: '28dp rounded dialogs with optional badge icon, destructive mode, and form layout.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton.filled(
              label: 'Standard Dialog',
              onPressed: () => showExpressiveAlertDialog<void>(
                context: context,
                title: 'Save changes?',
                content: 'Your workspace preferences will be synced across all connected devices.',
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                ),
                confirmLabel: 'Save',
                cancelLabel: 'Discard',
                onConfirm: () {
                  Navigator.of(context).pop();
                  widget.onShowFeedback('Changes saved');
                },
              ),
            ),
            ExpressiveButton.outlined(
              label: 'Destructive',
              onPressed: () => showExpressiveAlertDialog<void>(
                context: context,
                title: 'Delete device?',
                content: 'This action cannot be undone.',
                icon: const HugeIcon(icon: HugeIcons.strokeRoundedCancel01),
                isDestructive: true,
                confirmLabel: 'Delete',
                cancelLabel: 'Keep',
                onConfirm: () {
                  Navigator.of(context).pop();
                  widget.onShowFeedback('Device deleted');
                },
              ),
            ),
            ExpressiveButton.tonal(
              label: 'Form Dialog',
              onPressed: () => showExpressiveAlertDialog<void>(
                context: context,
                title: 'Rename workspace',
                isForm: true,
                confirmLabel: 'Rename',
                cancelLabel: 'Cancel',
                child: ExpressiveTextFormField.filled(
                  labelText: 'Workspace name',
                  hintText: 'Expressive Studio',
                  showClearButton: true,
                ),
                onConfirm: () {
                  Navigator.of(context).pop();
                  widget.onShowFeedback('Workspace renamed');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Date & Month Picker (ExpressiveDatePicker)',
          subtitle: 'Select a specific day, month, month range, or year range in M3 Expressive style.',
        ),
        const SizedBox(height: 8),
        Text(
          'Selected: $_pickedDateLabel',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton.filled(
              label: 'Pick Day',
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar01,
                size: 18,
              ),
              onPressed: () async {
                final picked = await ExpressiveDatePicker.showDayPicker(
                  context: context,
                  initialDate: DateTime.now(),
                );
                if (picked != null && mounted) {
                  setState(
                    () => _pickedDateLabel =
                        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}',
                  );
                }
              },
            ),
            ExpressiveButton.tonal(
              label: 'Pick Month',
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar02,
                size: 18,
              ),
              onPressed: () async {
                final picked = await ExpressiveDatePicker.showMonthPicker(
                  context: context,
                  initialDate: DateTime.now(),
                );
                if (picked != null && mounted) {
                  setState(
                    () => _pickedDateLabel =
                        '${picked.year}-${picked.month.toString().padLeft(2, '0')}',
                  );
                }
              },
            ),
            ExpressiveButton.outlined(
              label: 'Month Range',
              onPressed: () async {
                final range = await ExpressiveDatePicker.showMonthRangePicker(
                  context: context,
                );
                if (range != null && mounted) {
                  setState(
                    () => _pickedDateLabel =
                        '${range.start.year}-${range.start.month.toString().padLeft(2, '0')} → ${range.end.year}-${range.end.month.toString().padLeft(2, '0')}',
                  );
                }
              },
            ),
            ExpressiveButton.outlined(
              label: 'Year Range',
              onPressed: () async {
                final range = await ExpressiveDatePicker.showYearRangePicker(
                  context: context,
                );
                if (range != null && mounted) {
                  setState(
                    () => _pickedDateLabel =
                        '${range.start.year} → ${range.end.year}',
                  );
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'SnackBar (ExpressiveSnackBar)',
          subtitle: 'Floating 20dp rounded snackbars with semantic tonal palettes and responsive width.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ExpressiveButton.outlined(
              label: 'Neutral',
              onPressed: () => showExpressiveSnackBar(
                context: context,
                message: 'Settings updated locally.',
              ),
            ),
            ExpressiveButton.tonal(
              label: 'Info',
              onPressed: () => showExpressiveSnackBar(
                context: context,
                title: 'Syncing',
                message: 'Your preferences are being backed up.',
                type: ExpressiveSnackBarType.info,
              ),
            ),
            ExpressiveButton.filled(
              label: 'Success',
              onPressed: () => showExpressiveSnackBar(
                context: context,
                message: 'Export completed successfully!',
                type: ExpressiveSnackBarType.success,
                actionLabel: 'Undo',
                onAction: () => widget.onShowFeedback('Undo tapped'),
                showCloseIcon: true,
              ),
            ),
            ExpressiveButton.tonal(
              label: 'Warning',
              onPressed: () => showExpressiveSnackBar(
                context: context,
                message: 'Storage is almost full.',
                type: ExpressiveSnackBarType.warning,
              ),
            ),
            ExpressiveButton.outlined(
              label: 'Error',
              onPressed: () => showExpressiveSnackBar(
                context: context,
                title: 'Connection failed',
                message: 'Could not reach the server.',
                type: ExpressiveSnackBarType.error,
                showCloseIcon: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

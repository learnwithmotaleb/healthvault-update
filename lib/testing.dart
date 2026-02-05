import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthvault/presentation/widget/hv_button.dart';
import 'package:healthvault/presentation/widget/hv_card.dart';
import 'package:healthvault/presentation/widget/hv_chip.dart';
import 'package:healthvault/presentation/widget/hv_divider.dart';
import 'package:healthvault/presentation/widget/hv_empty_state.dart';
import 'package:healthvault/presentation/widget/hv_icon_badge.dart';
import 'package:healthvault/presentation/widget/hv_list_tile.dart';
import 'package:healthvault/presentation/widget/hv_loading.dart';
import 'package:healthvault/presentation/widget/hv_section_header.dart';
import 'package:healthvault/presentation/widget/hv_text_field.dart';
import 'core/responsive_layout/dimensions/dimensions.dart';

class HVComponentTestPage extends StatelessWidget {
  const HVComponentTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HV Components Test Page')),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          // Buttons
          const HVSectionHeader(title: 'Buttons'),
          Row(
            children: [
              Expanded(child: HVButton(label: 'Primary', onPressed: () {})),
              Dimensions.gapW(12),
              Expanded(child: HVButton(label: 'Outline', onPressed: () {})),
            ],
          ),
          Dimensions.gapH(20),

          // Chips
          const HVSectionHeader(title: 'Chips'),
          Wrap(
            spacing: 12,
            children: const [
              HVPillChip(label: "Sonia"),
              HVPillChip(label: "HealthVault"),
              HVPillChip(label: "Motaleb"),
            ],
          ),
          Dimensions.gapH(20),

          // ICON BADGE
          const HVSectionHeader(title: 'Icon Badges'),
          Row(
            children: const [
              HVIconBadge(icon: Icons.thumb_up, text: "Like"),
              SizedBox(width: 12),
              HVIconBadge(icon: Icons.alarm, text: "2 reminders"),
            ],
          ),
          Dimensions.gapH(20),

          // Cards
          const HVSectionHeader(title: 'Cards & Tiles'),
          HVCard(
            child: HVListTile(
              title: "Documents",
              subtitle: "You have 5 new files",
              leadingIcon: Icons.insert_drive_file,
              trailingIcon: Icons.chevron_right,
            ),
          ),
          Dimensions.gapH(8),
          HVCard(
            child: ListTile(
              title: Text("Hello Bangladesh"),
              subtitle: Text("This is a sample tile card."),
            ),
          ),
          Dimensions.gapH(20),

          // Loading
          const HVSectionHeader(title: 'Loading States'),
          const HVLoading(message: "Fetching data..."),
          Dimensions.gapH(20),

          // Empty State
          const HVSectionHeader(title: 'Empty States'),
          HVEmptyState(
            icon: Icons.event_busy,
            title: 'No Appointments',
            subtitle: 'Try adding a new appointment.',
            action: HVButton(label: 'Add New', onPressed: () {}),
          ),
          Dimensions.gapH(20),

          // Text Field
          const HVSectionHeader(title: 'Text Field'),
          // const HVTextField(
          //   hintText: "Enter your name",
          //   label: "Name",
          //   controller: TextEditingController,
          // ),
          Dimensions.gapH(20),

          // Responsive Tile
          const HVSectionHeader(title: 'Responsive Tile'),
          const ResponsiveTile(),
        ],
      ),
    );
  }
}

class ResponsiveTile extends StatelessWidget {
  const ResponsiveTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Dimensions.pMedium,
      child: Container(
        padding: Dimensions.pMedium,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.medication, size: 22.w, color: Theme.of(context).colorScheme.primary),
            Dimensions.gapW(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Paracetamol', style: TextStyle(fontSize: 16.r, fontWeight: FontWeight.w600)),
                  Dimensions.gapH(6),
                  Text('500mg • 08:00 / 20:00', style: TextStyle(fontSize: 14.r)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 20.w),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:healthvault/core/responsive_layout/dimensions/dimensions.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ReminderCard extends StatefulWidget {
  final String pillName;
  final String dosage;
  final int timesPerDay;
  final String schedule;
  final List<String> times;
  final String startDate;
  final String endDate;
  final String instructions;
  final String assignedTo;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ReminderCard({
    Key? key,
    required this.pillName,
    required this.dosage,
    required this.timesPerDay,
    required this.schedule,
    required this.times,
    required this.startDate,
    required this.endDate,
    required this.instructions,
    required this.assignedTo,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateAndAnimateProgress();
  }

  double _calculateProgress() {
    try {
      // Try parsing dates
      DateTime? start = DateTime.tryParse(widget.startDate);
      DateTime? end = DateTime.tryParse(widget.endDate);

      if (start == null || end == null) return 0.0;

      if (end.isBefore(start)) return 0.0;

      DateTime now = DateTime.now();

      Duration total = end.difference(start);
      if (total.inMilliseconds <= 0) return 0.0;

      Duration elapsed = now.difference(start);

      double value =
      (elapsed.inMilliseconds / total.inMilliseconds)
          .clamp(0.0, 1.0);

      return value;
    } catch (_) {
      return 0.0;
    }
  }

  void _calculateAndAnimateProgress() {
    double targetProgress = _calculateProgress();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    final animation =
    Tween<double>(begin: 0, end: targetProgress).animate(_controller);

    animation.addListener(() {
      setState(() {
        progress = animation.value;
      });
    });

    _controller.forward();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int percent = (progress * 100).round();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress + Labels + Icons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Dynamic labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('0%'),
                        Text('$percent%'),
                        const Text('100%'),
                      ],
                    ),
                    const SizedBox(height: 4),

                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor:
                      AppColors.hintColor.withOpacity(0.5),
                      color: AppColors.loginLogoRadiusColor,
                      minHeight: 12,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(30)),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.w(10)),
              Row(
                children: [
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.readColor,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: Dimensions.h(10)),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRichText("Pill Name", widget.pillName),
              _buildRichText("Dosage", widget.dosage),
              _buildRichText(
                  "Times per day", "${widget.timesPerDay} times"),
              _buildRichText("Schedule", widget.schedule),
              _buildRichText("Times", widget.times.join(" | ")),
              _buildRichText("Start Date", widget.startDate),
              _buildRichText("End Date", widget.endDate),
              _buildRichText("Instructions", widget.instructions),
              _buildRichText("Assigned to", widget.assignedTo),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../model/service_data_model.dart';

class DoctorServiceField extends StatelessWidget {
  final TextEditingController controller;
  final List<ServiceData> items;
  final Function(ServiceData)? onSelected;

  DoctorServiceField({
    required this.controller,
    required this.items,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _openBottomSheet(context),
      decoration: InputDecoration(
        hintText: "Select service",
      ),
    );
  }

  Future<void> _openBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<ServiceData>(
      context: context,
      builder: (_) {
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (_, index) {
            final s = items[index];
            return ListTile(
              title: Text("${s.title} - ৳${s.price}"),
              onTap: () => Navigator.pop(context, s),
            );
          },
        );
      },
    );

    if (result != null) {
      controller.text = "${result.title} - ৳${result.price}";
      onSelected?.call(result);
    }
  }
}

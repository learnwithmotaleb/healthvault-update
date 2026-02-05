import 'package:flutter/cupertino.dart';
import 'package:healthvault/utils/app_text_style/app_text_style.dart';

import '../../../../../core/responsive_layout/dimensions/dimensions.dart';

/// --------------------------------------------
/// Reusable Terms Item Widget
/// --------------------------------------------
class PrivacyItemWidget extends StatelessWidget {
  final String index;
  final String text;

  const PrivacyItemWidget({
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.w(24),
            child: Text(
              index,
              style: AppTextStyles.body,
            ),
          ),
          SizedBox(width: Dimensions.w(8)),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    );
  }
}

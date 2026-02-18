import 'package:flutter/cupertino.dart';

import '../../../../core/theming/styles.dart';

class PriceSection extends StatelessWidget {
  final String price;
  const PriceSection({super.key, required this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text("Price", style: TextStyles.black23w700),
          Text("\\hours", style: TextStyles.grey15w400),
          const Spacer(),
          Text(price, style: TextStyles.red15w400),
        ],
      ),
    );
  }
}

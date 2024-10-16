import 'package:flutter/material.dart';
import 'package:core_dashboard/responsive.dart';
import '../../shared/constants/gaps.dart';
import 'widgets/form.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            "New Product",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [CustomForm()],
            ),
          ),
        ),
      ],
    );
  }
}

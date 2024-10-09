import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../constants/defaults.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.drawerKey});

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding, vertical: AppDefaults.padding),
      color: AppColors.bgSecondayLight,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Badge(
                      isLabelVisible: true,
                      child: SvgPicture.asset("assets/icons/message_light.svg"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Badge(
                      isLabelVisible: true,
                      child: SvgPicture.asset(
                          "assets/icons/notification_light.svg"),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.create.vista.com/api/media/small/339818716/stock-photo-doubtful-hispanic-man-looking-with-disbelief-expression"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

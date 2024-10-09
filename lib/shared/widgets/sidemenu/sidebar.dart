import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:core_dashboard/services/menu_service.dart';

import '../../constants/config.dart';
import 'menu_tile.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuService menuService = MenuService();

    return Drawer(
      // width: Responsive.isMobile(context) ? double.infinity : null,
      // width: MediaQuery.of(context).size.width < 1300 ? 260 : null,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('assets/icons/close_filled.svg'),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                    vertical: AppDefaults.padding * 1.5,
                  ),
                  child: SvgPicture.asset(AppConfig.logo),
                ),
              ],
            ),
            const Divider(),
            gapH16,
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: menuService.fetchMenuItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading menu"));
                  }

                  final List<dynamic> menuItems = snapshot.data ?? [];
                  return ListView(
                    children: menuItems.map((item) {
                      if (item['children'] != null &&
                          item['children'].isNotEmpty) {
                        return ExpansionTile(
                          leading: item['icon'] != null
                              ? SvgPicture.asset(item['icon'])
                              : null,
                          title: Text(item['menu']),
                          children: List.generate(
                            item['children'].length,
                            (index) {
                              var child = item['children'][index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: MenuTile(
                                  iconSrc: "",
                                  title: child['name'],
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, child['route']);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return MenuTile(
                          title: item['menu'],
                          iconSrc: item['icon'],
                          onPressed: () {
                            Navigator.pushNamed(context, item['route']);
                          },
                        );
                      }
                    }).toList(),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(AppDefaults.padding),
            //   child: Column(
            //     children: [
            //       if (Responsive.isMobile(context))
            //         const CustomerInfo(
            //           name: 'Tran Mau Tri Tam',
            //           designation: 'Visual Designer',
            //           imageSrc:
            //               'https://cdn.create.vista.com/api/media/small/339818716/stock-photo-doubtful-hispanic-man-looking-with-disbelief-expression',
            //         ),
            //       gapH8,
            //       const Divider(),
            //       gapH8,
            //       // Row(
            //       //   children: [
            //       //     SvgPicture.asset(
            //       //       'assets/icons/help_light.svg',
            //       //       height: 24,
            //       //       width: 24,
            //       //       colorFilter: const ColorFilter.mode(
            //       //         AppColors.textLight,
            //       //         BlendMode.srcIn,
            //       //       ),
            //       //     ),
            //       //     gapW8,
            //       //     Text(
            //       //       'Help & getting started',
            //       //       style: Theme.of(context)
            //       //           .textTheme
            //       //           .labelMedium
            //       //           ?.copyWith(fontWeight: FontWeight.w600),
            //       //     ),
            //       //     const Spacer(),
            //       //     Chip(
            //       //       backgroundColor: AppColors.secondaryLavender,
            //       //       side: BorderSide.none,
            //       //       padding: const EdgeInsets.symmetric(horizontal: 0.5),
            //       //       label: Text(
            //       //         "8",
            //       //         style: Theme.of(context)
            //       //             .textTheme
            //       //             .labelMedium!
            //       //             .copyWith(fontWeight: FontWeight.w700),
            //       //       ),
            //       //     ),
            //       //   ],
            //       // ),
            //       gapH20,
            //       // const ThemeTabs(),
            //       gapH8,
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

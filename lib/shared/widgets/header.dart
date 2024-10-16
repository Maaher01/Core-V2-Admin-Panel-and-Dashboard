import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:core_dashboard/services/menu_service.dart';

import '../../theme/app_colors.dart';
import '../constants/defaults.dart';
import '../constants/gaps.dart';
import './tabs/icon_badge.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.drawerKey});

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  final MenuService menuService = MenuService();
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _menuItems = [];
  List<Map<String, dynamic>> _filteredChildren = [];

  @override
  void initState() {
    super.initState();
    _fetchMenuItems();
  }

  Future<void> _fetchMenuItems() async {
    final menuItems = await menuService.fetchMenuItems();
    setState(() {
      _menuItems = menuItems;
    });
  }

  void _filterChildren(String parentName) {
    setState(() {
      _filteredChildren = [];

      final parentMenu = _menuItems.firstWhere(
        (menu) => menu['menu'].toLowerCase() == parentName.toLowerCase(),
        orElse: () => null,
      );

      if (parentMenu != null && parentMenu['children'] != null) {
        _filteredChildren =
            List<Map<String, dynamic>>.from(parentMenu['children']);
      }
      if (parentMenu.isEmpty || parentMenu['children'] == null) {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          color: AppColors.bgSecondayLight,
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                if (Responsive.isMobile(context))
                  IconButton(
                    onPressed: () {
                      widget.drawerKey.currentState!.openDrawer();
                    },
                    icon: Badge(
                      isLabelVisible: false,
                      child: SvgPicture.asset(
                        "assets/icons/menu_light.svg",
                      ),
                    ),
                  ),
                // if (Responsive.isMobile(context))
                //   IconButton(
                //     onPressed: () {},
                //     icon: Badge(
                //       isLabelVisible: false,
                //       child: SvgPicture.asset("assets/icons/search_filled.svg"),
                //     ),
                //   ),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,
                          onChanged: (value) => _filterChildren(value),
                          decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: AppDefaults.padding,
                                right: AppDefaults.padding / 2,
                              ),
                              child: SvgPicture.asset(
                                  "assets/icons/search_light.svg"),
                            ),
                            filled: true,
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            border: AppDefaults.outlineInputBorder,
                            focusedBorder:
                                AppDefaults.focusedOutlineInputBorder,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        if (_filteredChildren.isNotEmpty)
                          Container(
                            constraints: const BoxConstraints(maxHeight: 200),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filteredChildren.length,
                              itemBuilder: (context, index) {
                                final child = _filteredChildren[index];
                                return ListTile(
                                  title: Text(child['name']),
                                  onTap: () {
                                    if (child['route'] != null &&
                                        child['route'].isNotEmpty) {
                                      context.go(child['route']);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!Responsive.isMobile(context))
                        IconBadge(
                          value: 3,
                          color: Colors.red,
                          textColor: Colors.white,
                          child: PopupMenuButton<int>(
                            icon: SvgPicture.asset(
                                "assets/icons/message_light.svg"),
                            offset: const Offset(-20, 35),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.asset(
                                              '../../../assets/images/profile-photo.jpeg',
                                              width: 45.0,
                                              height: 45.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Brad Diesel',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Text('Call me whenever you can',
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 18),
                                                  SizedBox(width: 6.0),
                                                  Text('4 Hours Ago',
                                                      style: TextStyle(
                                                          fontSize: 13.5)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Colors.red,
                                                  size: 23),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.asset(
                                              '../../../assets/images/profile-photo.jpeg',
                                              width: 45.0,
                                              height: 45.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Brad Diesel',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                              Text('Call me whenever you can',
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 18),
                                                  SizedBox(width: 6.0),
                                                  Text('4 Hours Ago',
                                                      style: TextStyle(
                                                          fontSize: 13.5)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Colors.red,
                                                  size: 23),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.asset(
                                              '../../../assets/images/profile-photo.jpeg',
                                              width: 45.0,
                                              height: 45.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Brad Diesel',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                'Call me whenever you can',
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      size: 18),
                                                  SizedBox(width: 6.0),
                                                  Text(
                                                    '4 Hours Ago',
                                                    style: TextStyle(
                                                        fontSize: 13.5),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                Icons.star_rate_rounded,
                                                color: Colors.red,
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text('See All Notifications',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13.5)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!Responsive.isMobile(context)) gapW16,
                      if (!Responsive.isMobile(context))
                        IconBadge(
                          value: 2,
                          color: Colors.red,
                          textColor: Colors.white,
                          child: PopupMenuButton<int>(
                            icon: SvgPicture.asset(
                                "assets/icons/notification_light.svg"),
                            offset: const Offset(-20, 35),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Notification 1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '3 mins',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Notification 2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('12 hours',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Notification 3',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('2 days',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text('See All Notifications',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.5)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!Responsive.isMobile(context)) gapW16,
                      if (!Responsive.isMobile(context))
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 24.0),
                          child: PopupMenuButton<int>(
                            offset: const Offset(-20, 35),
                            icon: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://cdn.create.vista.com/api/media/small/339818716/stock-photo-doubtful-hispanic-man-looking-with-disbelief-expression",
                              ),
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Syed Maaher Hossain',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          size: 22.0,
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Text(
                                          'Profile',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.settings_outlined,
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Text(
                                          'Settings',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      TextButton(
                        onPressed: () => context.go('/sign-in'),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).textTheme.titleLarge!.color,
                          minimumSize: const Size(80, 56),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppDefaults.borderRadius),
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Sign In"),
                      ),
                      gapW16,
                      ElevatedButton(
                        onPressed: () => context.go('/register'),
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

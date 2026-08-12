import 'package:flutter/material.dart';

void main() {
  runApp(const SeniorCareApp());
}

// ============================================================
// APP
// ============================================================

class SeniorCareApp extends StatelessWidget {
  const SeniorCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Senior Care',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFFFFCF7),
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottom = 0;

  // ==========================================================
  // SERVICES
  // ==========================================================

  final List<Map<String, dynamic>> services = [
    {
      'title': 'Documents',
      'subtitle': 'Save & manage\nyour documents',
      'icon': Icons.folder_rounded,
      'bg': const Color(0xFFE8F4FF),
      'iconColor': const Color(0xFF1976D2),
    },
    {
      'title': 'AI Assistant',
      'subtitle': 'Ask anything,\nget help instantly',
      'icon': Icons.smart_toy_rounded,
      'bg': const Color(0xFFF1EBFF),
      'iconColor': const Color(0xFF4338A8),
    },
    {
      'title': 'Government\nServices',
      'subtitle': 'Access all govt.\nservices',
      'icon': Icons.account_balance_rounded,
      'bg': const Color(0xFFEDF9E9),
      'iconColor': const Color(0xFF35A853),
    },
    {
      'title': 'Location\nServices',
      'subtitle': 'Find nearby places\n& services',
      'icon': Icons.location_on_rounded,
      'bg': const Color(0xFFFFF5E2),
      'iconColor': const Color(0xFFF59E0B),
    },
    {
      'title': 'Language',
      'subtitle': 'Change app\nlanguage',
      'icon': Icons.translate_rounded,
      'bg': const Color(0xFFFFEEF1),
      'iconColor': const Color(0xFFE84D72),
    },
    {
      'title': 'Accessibility\nTools',
      'subtitle': 'Features for easy\nuse',
      'icon': Icons.accessible_rounded,
      'bg': const Color(0xFFE7F8FA),
      'iconColor': const Color(0xFF087EA4),
    },
  ];

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void showMessage(String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ==========================================================
  // MENU
  // ==========================================================

  void openMenu() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  showMessage('Profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  showMessage('Settings');
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.pop(context);
                  showMessage('Help & Support');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // SOS
  // ==========================================================

  void emergencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text('Emergency SOS'),
            ],
          ),
          content: const Text(
            'Do you want to call emergency assistance?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                showMessage('Emergency Call');
              },
              icon: const Icon(Icons.phone),
              label: const Text('CALL'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // MAIN BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width > 1200 ? 1150 : width,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: width < 600 ? 16 : 28,
                          vertical: width < 600 ? 12 : 24,
                        ),
                        child: buildHome(width),
                      ),
                    ),

                    // Bottom navigation
                    buildBottomNavigation(width),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // HOME CONTENT
  // ==========================================================

  Widget buildHome(double width) {
    final bool phone = width < 600;
    final bool desktop = width >= 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ======================================================
        // TOP BAR
        // ======================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            roundButton(
              Icons.menu_rounded,
              openMenu,
            ),

            InkWell(
              onTap: () => showMessage('Listen'),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: phone ? 16 : 20,
                  vertical: phone ? 11 : 13,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.volume_up_rounded,
                      size: phone ? 23 : 26,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Listen',
                      style: TextStyle(
                        fontSize: phone ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: phone ? 24 : 35),

        // ======================================================
        // GREETING + COUPLE
        // ======================================================

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning! 👋',
                    style: TextStyle(
                      fontSize: phone
                          ? 29
                          : desktop
                          ? 39
                          : 34,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF11131A),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "We're here to make\nthings easier for you.",
                    style: TextStyle(
                      fontSize: phone ? 17 : 20,
                      height: 1.4,
                      color: const Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),

            // Couple illustration
            buildCouple(
              phone ? 125 : desktop ? 260 : 190,
              phone ? 120 : desktop ? 190 : 150,
            ),
          ],
        ),

        SizedBox(height: phone ? 18 : 25),

        // ======================================================
        // HELP CARD
        // ======================================================

        InkWell(
          onTap: () => showMessage('Help'),
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(phone ? 15 : 22),
            decoration: BoxDecoration(
              color: const Color(0xFFF1EAFF),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFD9CCF5),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: phone ? 58 : 70,
                  height: phone ? 58 : 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B4BB8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: phone ? 31 : 38,
                  ),
                ),

                SizedBox(width: phone ? 14 : 20),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Help is a tap away',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'All essential services in one place',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Color(0xFF6B4BB8),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ======================================================
        // SERVICE CARDS
        // ======================================================

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: phone ? 3 : 6,
            crossAxisSpacing: phone ? 9 : 14,
            mainAxisSpacing: phone ? 10 : 14,
            childAspectRatio: phone ? 0.67 : 0.85,
          ),
          itemBuilder: (context, index) {
            final service = services[index];

            return InkWell(
              onTap: () {
                showMessage(
                  '${service['title']} selected',
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: phone ? 6 : 10,
                  vertical: phone ? 10 : 15,
                ),
                decoration: BoxDecoration(
                  color: service['bg'],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      service['icon'],
                      size: phone ? 45 : 58,
                      color: service['iconColor'],
                    ),

                    SizedBox(
                      height: phone ? 8 : 12,
                    ),

                    Text(
                      service['title'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: phone ? 14 : 17,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      service['subtitle'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: phone ? 10 : 13,
                        height: 1.2,
                        color: const Color(0xFF555555),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // ======================================================
        // QUICK ACCESS
        // ======================================================

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: phone ? 10 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: phone
              ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: buildQuickItems(phone),
          )
              : buildQuickItems(phone),
        ),

        const SizedBox(height: 18),

        // ======================================================
        // EMERGENCY SOS
        // ======================================================

        InkWell(
          onTap: emergencyDialog,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(
              phone ? 14 : 20,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE7E4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFC8C3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: phone ? 52 : 62,
                  height: phone ? 52 : 62,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE94B35),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_rounded,
                    color: Colors.white,
                    size: phone ? 28 : 32,
                  ),
                ),

                SizedBox(width: phone ? 13 : 18),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency SOS',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8E1B0E),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tap to call for immediate help',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B4B47),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFE94B35),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),
      ],
    );
  }

  // ==========================================================
  // COUPLE ILLUSTRATION
  // ==========================================================

  Widget buildCouple(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Woman
          Positioned(
            left: 0,
            bottom: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: height * 0.24,
                  backgroundColor: const Color(0xFFFFE2D8),
                  child: Icon(
                    Icons.face_3_rounded,
                    size: height * 0.34,
                    color: const Color(0xFFE19B7E),
                  ),
                ),
                Container(
                  width: height * 0.55,
                  height: height * 0.40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE98968),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Man
          Positioned(
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: height * 0.27,
                  backgroundColor: const Color(0xFFFFDDCF),
                  child: Icon(
                    Icons.face_rounded,
                    size: height * 0.38,
                    color: const Color(0xFFD68C70),
                  ),
                ),
                Container(
                  width: height * 0.60,
                  height: height * 0.45,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4E8969),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(38),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // QUICK ACCESS ITEMS
  // ==========================================================

  Widget buildQuickItems(bool phone) {
    final items = [
      [
        Icons.campaign_rounded,
        'Notices &\nUpdates',
        Colors.blue,
      ],
      [
        Icons.phone_rounded,
        'Helpline',
        Colors.green,
      ],
      [
        Icons.medical_services_rounded,
        'Health\nServices',
        Colors.redAccent,
      ],
      [
        Icons.account_balance_wallet_rounded,
        'Payments',
        Colors.orange,
      ],
      [
        Icons.notifications_rounded,
        'Reminders',
        Colors.deepPurple,
      ],
    ];

    return Row(
      mainAxisAlignment: phone
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceEvenly,
      mainAxisSize:
      phone ? MainAxisSize.min : MainAxisSize.max,
      children: List.generate(
        items.length,
            (index) {
          final item = items[index];

          return Row(
            children: [
              InkWell(
                onTap: () {
                  showMessage(
                    (item[1] as String)
                        .replaceAll('\n', ' '),
                  );
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: phone ? 12 : 20,
                    vertical: 4,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        item[0] as IconData,
                        color: item[2] as Color,
                        size: phone ? 27 : 32,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item[1] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: phone ? 10 : 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (index != items.length - 1)
                Container(
                  width: 1,
                  height: 42,
                  color: Colors.grey.shade300,
                ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================================
  // TOP ROUND BUTTON
  // ==========================================================

  Widget roundButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 30,
        ),
      ),
    );
  }

  // ==========================================================
  // BOTTOM NAVIGATION
  // ==========================================================

  Widget buildBottomNavigation(double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            bottomItem(
              Icons.home_rounded,
              'Home',
              0,
            ),
            bottomItem(
              Icons.favorite_border_rounded,
              'Favourites',
              1,
            ),
            bottomItem(
              Icons.person_outline_rounded,
              'Profile',
              2,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomItem(
      IconData icon,
      String title,
      int index,
      ) {
    final selected = selectedBottom == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedBottom = index;
          });

          if (index != 0) {
            showMessage(title);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: selected
                    ? const Color(0xFF1976D2)
                    : Colors.grey.shade600,
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: selected
                      ? const Color(0xFF1976D2)
                      : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
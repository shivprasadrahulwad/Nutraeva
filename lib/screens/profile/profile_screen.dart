import 'package:fitness/screens/goal/goal_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTabIndex = 0;

  void _shareContent() {
    print("Tapped Share");
    Share.share('Check out this awesome app: https://yourapp.link');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTabSelection(),
              const SizedBox(height: 20),
              // Show different content based on the selected tab
              if (selectedTabIndex == 0)
                _buildProfileContent()
              else if (selectedTabIndex == 1)
                _buildSettingsContent()
              else
                _buildPlanContent(),
            ],
          ),
        ),
      ),
    );
  }

  // Profile content from the existing code
  Widget _buildProfileContent() {
    return Column(
      children: [
        _buildInfoTiles(),
        const SizedBox(height: 20),
        _buildSettingsOptions(),
      ],
    );
  }

  // New Settings content based on the provided image
  Widget _buildSettingsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Account section
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
          child: Text(
            'Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        _buildSettingMenuItem(
          icon: Icons.emoji_events_outlined,
          title: 'My Goals',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GoalUpdateScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingMenuItem(
          icon: Icons.phone_android_outlined,
          title: 'Automatic Tracking Apps',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildSettingMenuItem(
          icon: Icons.book_outlined,
          title: 'Diary Settings',
          onTap: () {},
        ),

        // Other section
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
          child: Text(
            'Other',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        _buildSettingMenuItem(
            icon: Icons.person_add_outlined,
            title: 'Invite Friends & Get ₹100',
            onTap: _shareContent),
        const SizedBox(height: 12),
        _buildSettingMenuItem(
          icon: Icons.logout_outlined,
          title: 'Log Out',
          onTap: () {},
        ),
        const SizedBox(height: 80), // Space for floating action button
      ],
    );
  }

  // Placeholder for the Plan content
  Widget _buildPlanContent() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'MY Plan content will go here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSettingMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue[800],
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // The following methods remain the same from your original code

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBackButton(),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 40), // Balance for back button
            ],
          ),
          const SizedBox(height: 24),
          _buildProfileInfo(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {},
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        _buildProfileAvatar(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shivri Rahulwad',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'rahulwad@gmail.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Blue progress circle
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: 0.5,
            strokeWidth: 4,
            backgroundColor: Colors.grey[300],
            color: const Color(0xFF4E5BF2),
          ),
        ),
        // White background circle
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        // Profile image
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                  'https://drive.google.com/file/d/1yUIVht0oFaA6nCsipDNztFoIjbxr54P1/view?usp=sharing'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Percentage indicator
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF4E5BF2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '50%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        icon: const Icon(Icons.edit_outlined, color: Colors.black54),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit profile pressed')),
          );
        },
      ),
    );
  }

  Widget _buildTabSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _buildTabButton('Profile', 0),
            _buildTabButton('Setting', 1),
            _buildTabButton('MY Plan', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTabIndex = index;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4E5BF2) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTiles() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoTile(
                icon: Icons.calendar_today,
                title: 'Age',
                value: '25yrs',
                color: const Color(0xFF4e5bf2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoTile(
                icon: Icons.male,
                title: 'Gender',
                value: 'Male',
                color: const Color(0xFF4e5bf2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInfoTile(
                icon: Icons.height,
                title: 'Height',
                value: '165cm',
                color: const Color(0xFF4e5bf2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoTile(
                icon: Icons.monitor_weight_outlined,
                title: 'Weight',
                value: '85kg',
                color: const Color(0xFF4e5bf2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptions() {
    return Column(
      children: [
        _buildSettingTile(
          icon: Icons.show_chart,
          title: 'Progress Tracking',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Progress Tracking selected')),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingTile(
          icon: Icons.restaurant_menu,
          title: 'Diet & Nutrition Stats',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Diet & Nutrition Stats selected')),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildSettingTile(
          icon: Icons.notifications_none,
          title: 'Notification',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification selected')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF4e5bf2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF4e5bf2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

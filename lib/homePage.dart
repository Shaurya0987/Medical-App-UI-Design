import 'package:bdver/Services/auth_services.dart';
import 'package:bdver/appointmentPage.dart';
import 'package:bdver/doctorPage.dart';
import 'package:bdver/profilePage.dart';
import 'package:bdver/signUp.dart';
import 'package:flutter/material.dart';

// --- This is now the main screen of your app ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService auth = AuthService();

  Future<void> logOut() async {
    return auth.signOut();
  }

  // 1. Variable to keep track of the selected tab index
  int _selectedIndex = 0;

  // 2. A list of the pages that will be displayed for each tab
  final List<Widget> _pages = [
    const HomeTabPage(), // Your home page content
    const DoctorsPage(), // Placeholder for doctors
    const AppointmentsPage(), // Placeholder for appointments
    const ProfilePage(), // Placeholder for profile
  ];

  // 3. A method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medical App",
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await logOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MinimalLoginPage()),
              );
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.orange.shade300,
              size: 30,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF4B6C68),
      // The body now shows the page corresponding to the selected index
      body: SafeArea(child: _pages[_selectedIndex]),

      // 4. ADD THE BOTTOM NAVIGATION BAR HERE
      bottomNavigationBar: BottomNavigationBar(
        // The type is important to keep the background color consistent
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF3A5450), // A slightly darker shade
        // These are the buttons on the navigation bar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Highlights the current tab
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor:
            Colors.orange, // Color for the selected tab's icon and label
        onTap: _onItemTapped, // Calls our method when a tab is tapped
      ),
    );
  }
}

// --- This widget holds your home screen's content ---
class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data lists moved inside the build method for better organization
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.medical_services_outlined, 'label': 'Consultation'},
      {'icon': Icons.health_and_safety_outlined, 'label': 'Dentist'},
      {'icon': Icons.favorite_border, 'label': 'Cardiologist'},
      {'icon': Icons.local_pharmacy_outlined, 'label': 'Pharmacy'},
      {'icon': Icons.visibility_outlined, 'label': 'Optician'},
      {'icon': Icons.bloodtype_outlined, 'label': 'Labs'},
    ];

    final List<Map<String, dynamic>> doctors = [
      {
        'imagePath': 'https://picsum.photos/id/237/200',
        'name': 'Dr. Aliyah Khan',
        'specialty': 'Consultant - Physiotherapy',
        'rating': '🥇 4.9 (37 Reviews)',
      },
      {
        'imagePath': 'https://picsum.photos/id/238/200',
        'name': 'Dr. Rohan Verma',
        'specialty': 'Consultant - Cardiology',
        'rating': '🥇 4.8 (52 Reviews)',
      },
      {
        'imagePath': 'https://picsum.photos/id/239/200',
        'name': 'Dr. Priya Singh',
        'specialty': 'Consultant - Dentistry',
        'rating': '🥇 4.9 (45 Reviews)',
      },
    ];

    final TextEditingController searchController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Shaurya Thakur",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search for doctor",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Show All",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return CategoryCard(
                  icon: items[index]['icon'],
                  label: items[index]['label'],
                );
              },
            ),
            const SizedBox(height: 25),
            const Text(
              "Top Doctors",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: doctors.map((doctor) {
                return DoctorCard(
                  imagePath: doctor['imagePath'],
                  name: doctor['name'],
                  specialty: doctor['specialty'],
                  rating: doctor['rating'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Reusable Card Widgets ---
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const CategoryCard({super.key, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF4B6C68), size: 35),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF4B6C68),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String specialty;
  final String rating;
  const DoctorCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.specialty,
    required this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 35, backgroundImage: NetworkImage(imagePath)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    rating,
                    style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
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

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/radar_widget.dart';
import 'friends_screen.dart';
import 'qr_scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const RadarWidget(),
    const FriendsScreen(),
    const QRScannerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Usuario falso para que nunca pete (sin Firebase)
    const String displayName = "Luis Alfonso";

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.cyan,
                      child: Text(
                        displayName[0],
                        style: const TextStyle(fontSize: 50, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(displayName, style: const TextStyle(fontSize: 22, color: Colors.white)),
                    const Text("Bilbao", style: TextStyle(color: Colors.cyan)),
                  ],
                ),
              ),
              _socialLink("Instagram", FontAwesomeIcons.instagram, "https://instagram.com/luisalfonso107"),
              _socialLink("TikTok", FontAwesomeIcons.tiktok, "https://tiktok.com/@luisalfonso107"),
              _socialLink("Twitter", FontAwesomeIcons.xTwitter, "https://x.com/luisalfonso107"),
              _socialLink("Spotify", FontAwesomeIcons.spotify, "https://open.spotify.com/user/luisalfonso107"),
              const SwitchListTile(
                title: Text("Modo Invisible", style: TextStyle(color: Colors.white)),
                value: false,
                onChanged: null, // desactivado por ahora
                activeColor: Colors.cyan,
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
                onTap: () {}, // desactivado por ahora
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          // 6 puntitos falsos que brillan y se pueden tocar
          ...List.generate(6, (i) => _FakeUserDot(index: i)),
          const Positioned(
            bottom: 100,
            left: 20,
            child: Text("Luis Alfonso • Visible", style: TextStyle(color: Colors.cyan, fontSize: 18)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.qr_code_scanner, size: 32),
        label: const Text("Escanear QR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        onPressed: () => setState(() => _selectedIndex = 2),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.radar), label: "Radar"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Amigos"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "QR"),
        ],
      ),
    );
  }

  Widget _socialLink(String name, IconData icon, String url) => ListTile(
        leading: Icon(icon, color: Colors.cyan),
        title: Text(name, style: const TextStyle(color: Colors.white)),
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      );
}

// PUNTITOS FALSOS (sin necesidad de archivo extra)
class _FakeUserDot extends StatelessWidget {
  final int index;
  const _FakeUserDot({required this.index});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40 + (index * 55) + (index * 13) % 120,
      top: 80 + (index * 70) % 340,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: const Color(0xFF111111),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text("Usuario cercano", style: TextStyle(color: Colors.cyan)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(radius: 50, backgroundColor: Colors.cyan, child: Icon(Icons.person, size: 50)),
                  const SizedBox(height: 15),
                  Text("Persona $index", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("A ${(50 + index * 27) % 200} metros", style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(icon: const Icon(Icons.message, color: Colors.cyan), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.person_add, color: Colors.cyan), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.block, color: Colors.red), onPressed: () {}),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar", style: TextStyle(color: Colors.cyan)),
                ),
              ],
            ),
          );
        },
        child: Container(
          width: 62,
          height: 62,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.cyan,
            boxShadow: [BoxShadow(color: Colors.cyan, blurRadius: 20, spreadRadius: 5)],
          ),
          child: Center(
            child: Text("$index", style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
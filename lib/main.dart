import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const BlinkApp());

class BlinkApp extends StatefulWidget {
  const BlinkApp({super.key});
  @override
  State<BlinkApp> createState() => _BlinkAppState();
}

class _BlinkAppState extends State<BlinkApp> {
  bool aceptoSerDescubierto = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        // MENÚ HAMBURGUESA (con el switch dentro)
        drawer: Drawer(
          backgroundColor: const Color(0xFF0F0F0F),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.cyan),
                child: const Text("Blink",
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              ListTile(leading: const Icon(Icons.person), title: const Text("Mi perfil"), onTap: () {}),
              ListTile(leading: const Icon(Icons.qr_code_scanner), title: const Text("Escanear QR"), onTap: () {}),
              ListTile(leading: const Icon(Icons.message), title: const Text("Mensajes"), onTap: () {}),
              ListTile(leading: const Icon(Icons.shield), title: const Text("Privacidad"), onTap: () {}),
              ListTile(leading: const Icon(Icons.block), title: const Text("Bloqueados"), onTap: () {}),
              const Divider(color: Colors.white24),

              // SWITCH DENTRO DEL MENÚ
              SwitchListTile(
                title: const Text("Acepto que me descubran", style: TextStyle(fontSize: 17)),
                subtitle: Text(aceptoSerDescubierto ? "Visible en el radar" : "Modo invisible",
                    style: const TextStyle(color: Colors.white60)),
                value: aceptoSerDescubierto,
                activeColor: Colors.cyan,
                onChanged: (v) => setState(() => aceptoSerDescubierto = v),
              ),

              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
                onTap: () {},
              ),
            ],
          ),
        ),

        // APPBAR SUPER LIMPIO
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, size: 32, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_off_outlined, color: Colors.white70),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notificaciones silenciadas 1h"), backgroundColor: Colors.red),
              ),
            ),
          ],
        ),

        // CUERPO PRINCIPAL
        body: Column(
          children: [
            const SizedBox(height: 30),

            // FOTO DE PERFIL
            CircleAvatar(
              radius: 78,
              backgroundColor: Colors.cyan.withOpacity(0.2),
              child: const CircleAvatar(
                radius: 74,
                backgroundImage: NetworkImage(
                  "https://i.imgur.com/8b1mW3D.png", // ← Cambia esta URL por la tuya cuando quieras
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text("Luis Alfonso",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text("Bilbao • España",
                style: TextStyle(fontSize: 19, color: Colors.cyanAccent)),
            const SizedBox(height: 50),

            const Text("Mis redes (solo se ven si aceptan)",
                style: TextStyle(color: Colors.white60, fontSize: 17)),
            const SizedBox(height: 25),

            // 6 CÍRCULOS BORROSOS PERFECTOS
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(35),
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 35,
                crossAxisSpacing: 35,
                children: [
                  _redBorroso(Icons.photo_camera, const Color(0xFFE1306C)),   // Instagram
                  _redBorroso(Icons.play_arrow, Colors.white),                // TikTok
                  _redBorroso(Icons.music_note, Colors.green),                // Spotify
                  _redBorroso(Icons.alternate_email, Colors.blue),            // X / Twitter
                  _redBorroso(Icons.snapchat, Colors.yellow),                 // Snapchat
                  _redBorroso(Icons.code, Colors.orange),                     // GitHub / Dev
                ],
              ),
            ),

            // DOS BOTONES GIGANTES: ACEPTAR / RECHAZAR
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 60),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("¡Conexión ACEPTADA!"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle, size: 40),
                      label: const Text("Aceptar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        elevation: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Conexión rechazada"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.cancel, size: 40),
                      label: const Text("Rechazar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        elevation: 12,
                      ),
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

  // CÍRCULO BORROSO REUTILIZABLE
  Widget _redBorroso(IconData icon, Color color) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Icon(icon, size: 56, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
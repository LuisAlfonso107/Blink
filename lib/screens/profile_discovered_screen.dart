import 'package:flutter/material.dart';
import '../models/user_model.dart';

/// ← ¡¡NOMBRE DE CLASE CORREGIDO!! Ahora coincide con el import del radar
class ProfileDiscoveredScreen extends StatelessWidget {
  final BlinkUser user;

  const ProfileDiscoveredScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.cyan),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Aquí puedes añadir reportar, bloquear, etc.
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80), // Espacio para el AppBar

              // Avatar con glow cian brutal
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.cyan, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withOpacity(0.7),
                      blurRadius: 30,
                      spreadRadius: 8,
                    ),
                  ],
                  image: user.photoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(user.photoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: user.photoUrl == null ? Colors.grey[800] : null,
                ),
                child: user.photoUrl == null
                    ? const Icon(Icons.person, size: 90, color: Colors.white70)
                    : null,
              ),

              const SizedBox(height: 32),

              // Nombre y ciudad
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.cyan, blurRadius: 10),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Text(
                user.city,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.cyan,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 80),

              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ACEPTAR
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aquí irás a pantalla de chat o añadir a amigos
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("¡Conexión aceptada con ${user.name.split(" ").first}!"),
                          backgroundColor: Colors.cyan,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check, color: Colors.black),
                    label: const Text(
                      "Aceptar",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  const SizedBox(width: 30),

                  // RECHAZAR
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white70),
                    label: const Text(
                      "Rechazar",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
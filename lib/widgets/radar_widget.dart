import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/profile_discovered_screen.dart'; // ← Correcto (tu archivo se llama así)
import '../services/firebase_service.dart';
import '../models/user_model.dart';

class RadarWidget extends StatelessWidget {
  const RadarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BlinkUser>>(
      stream: FirebaseService.getNearbyUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "Nadie cerca... ¡sal y conquista!",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        final users = snapshot.data!;

        return Stack(
          children: [
            // Ondas del radar (animadas y brutales)
            ...List.generate(8, (i) {
              final size = 600.0 - i * 70.0;
              final opacity = 0.4 - i * 0.04;

              return Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 4 + i),
                  curve: Curves.linear,
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.cyan.withOpacity(opacity),
                      width: 2,
                    ),
                  ),
                ),
              );
            }),

            // Usuarios en el radar
            ...users.map((user) {
              final double distance = _calculateDistance(
                user.latitude ?? 0.0,
                user.longitude ?? 0.0,
              );

              // Efecto de barrido real de radar + pequeño offset por usuario
              final double sweepAngle = DateTime.now().millisecondsSinceEpoch / 8000;
              final double userOffset = (user.uid.hashCode % 360) / 360 * 2 * pi;
              final double angle = sweepAngle + userOffset;

              final double radiusFactor = (distance / 500).clamp(0.0, 1.0);

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                top: 300 + 220 * radiusFactor * sin(angle),
                left: 180 + 220 * radiusFactor * cos(angle),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        // Asegúrate de que la clase dentro del archivo sea exactamente esta:
                        builder: (_) => ProfileDiscoveredScreen(user: user),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.cyan, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.withOpacity(0.6),
                              blurRadius: 14,
                              spreadRadius: 3,
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
                            ? const Icon(Icons.person, color: Colors.white70, size: 32)
                            : null,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user.name.split(" ").first,
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.black87, blurRadius: 6)],
                        ),
                      ),
                      Text(
                        "${distance.toInt()} m",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  // Distancia simulada (próximamente: Haversine real con Geolocator)
  double _calculateDistance(double? lat, double? lng) {
    final random = Random("${lat ?? 0}${lng ?? 0}".hashCode);
    return 40 + random.nextDouble() * 410; // 40–450 metros
  }
}
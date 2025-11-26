import 'package:flutter/material.dart';

class RandomUserDot extends StatelessWidget {
  final int index;

  const RandomUserDot({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    // Simula 6 usuarios falsos moviéndose por el radar
    return Positioned(
      left: 50 + (index * 60) + (index * 10) % 100,
      top: 100 + (index * 80) % 300,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.black87,
              title: Text("Usuario $index", style: const TextStyle(color: Colors.cyan)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(radius: 50, backgroundColor: Colors.cyan),
                  const SizedBox(height: 20),
                  const Text("Luis Alfonso", style: TextStyle(color: Colors.white, fontSize: 20)),
                  const Text("A 127 metros", style: TextStyle(color: Colors.white70)),
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
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.cyan,
          ),
          child: Center(
            child: Text(
              "$index",
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // CONTENIDO QUE CAMBIA
          Expanded(
            child: IndexedStack(
              index: page,
              children: [
                // Página 1
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.radar, size: 200, color: Colors.cyan),
                    const SizedBox(height: 50),
                    const Text("Descubre gente\ncerca en tiempo real", 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 30),
                    const Text("Radar vivo • Distancia exacta • Solo quien tú quieras",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.white70)),
                  ],
                ),
                // Página 2
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app_outlined, size: 200, color: const Color(0xFFFF0088)),
                    const SizedBox(height: 50),
                    const Text("Toca → Decide\nen 3 segundos", 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 30),
                    const Text("Aceptar o Rechazar\nTus redes solo se ven si dices SÍ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.white70)),
                  ],
                ),
                // Página 3
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shield_moon, size: 200, color: const Color(0xFF00FF9D)),
                    const SizedBox(height: 50),
                    const Text("Privacidad\nnivel Dios", 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: Colors.white)),
                    const SizedBox(height: 30),
                    const Text("Modo invisible • Control total • Tú mandas siempre",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),

          // BOTONES DE ABAJO
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // Puntitos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) => Container(
                    margin: const EdgeEdges.all(6),
                    width: page == i ? 40 : 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: page == i ? Colors.cyan : Colors.white30,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )),
                ),

                const SizedBox(height: 40),

                // Botones de navegación
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón ATRÁS
                    if (page > 0)
                      TextButton(
                        onPressed: () => setState(() => page--),
                        child: const Text("Atrás", style: TextStyle(color: Colors.white70, fontSize: 20)),
                      )
                    else
                      const SizedBox(width: 80),

                    // Botón SIGUIENTE o ENTRAR
                    TextButton(
                      onPressed: () {
                        if (page < 2) {
                          setState(() => page++);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        }
                      },
                      child: Text(
                        page == 2 ? "ENTRA EN BLINK" : "Siguiente",
                        style: TextStyle(
                          color: page == 2 ? Colors.cyan : Colors.white,
                          fontSize: page == 2 ? 32 : 20,
                          fontWeight: page == 2 ? FontWeight.w900 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
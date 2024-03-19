// Importation des dépendances nécessaires
import 'package:flutter/material.dart';
import 'auth_gate.dart';

// Définition de la classe MyApp, qui est une StatelessWidget
class MyApp extends StatelessWidget {
  // Constructeur de la classe MyApp
  const MyApp({Key? key}) : super(key: key);

  // Méthode build pour construire l'interface utilisateur de l'application
  @override
  Widget build(BuildContext context) {
    // Retourne un MaterialApp, qui est le widget racine de l'application Flutter
    return MaterialApp(
      // Configuration du thème de l'application
      theme: ThemeData(
        // Définition de la couleur principale utilisée dans l'application
        primarySwatch: Colors.orange,
        secondaryHeaderColor: Colors.blue,
      ),
      // Définition de la page d'accueil de l'application comme étant AuthGate
      home: const AuthGate(),
    );
  }
}

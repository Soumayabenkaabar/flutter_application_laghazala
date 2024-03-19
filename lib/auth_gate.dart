// Importation des dépendances nécessaires
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart'; // Nouveau
import 'package:flutter/material.dart';

import 'home.dart';

// Définition de la classe AuthGate, qui est une StatelessWidget
class AuthGate extends StatelessWidget {
  // Constructeur de la classe AuthGate
  const AuthGate({Key? key}) : super(key: key);

  // Méthode build pour construire l'interface utilisateur de l'authentification
  @override
  Widget build(BuildContext context) {
    // Retourne un StreamBuilder pour surveiller les changements d'état d'authentification de l'utilisateur
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Surveille les changements d'état d'authentification
      builder: (context, snapshot) {
        // Vérifie s'il y a des données dans le snapshot
        if (!snapshot.hasData) {
          // Si l'utilisateur n'est pas authentifié, retourne l'écran de connexion
          return SignInScreen(
            // Configuration des fournisseurs d'authentification disponibles
            providers: [
              EmailAuthProvider(), // Fournisseur d'authentification par email
              GoogleProvider(
                  clientId:
                      "620512232749-6fmoqdsavqd4c1pdmqdou4vel08fvqp7.apps.googleusercontent.com"), // Nouveau: Fournisseur d'authentification Google avec le clientId spécifié
            ],
            // Configuration du contenu de l'en-tête
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('images/A.png'), // Image de l'en-tête
                ),
              );
            },
            // Configuration du sous-titre en fonction de l'action (connexion ou inscription)
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Welcome to LAGHAZALA center, please sign in!') // Message pour la connexion
                    : const Text(
                        'Welcome to LAGHAZALA center, please sign up!'), // Message pour l'inscription
              );
            },
            // Configuration du pied de page
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.', // Message de consentement
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            // Configuration du contenu de côté
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child:
                      Image.asset('images/A.png'), // Image du contenu de côté
                ),
              );
            },
          );
        }

        // Si l'utilisateur est authentifié, retourne l'écran d'accueil
        return const HomeScreen();
      },
    
    );
  }
}

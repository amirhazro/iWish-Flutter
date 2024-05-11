import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:developer' as dev;

class SocialsController extends GetxController {
  Future<OAuthCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(forceCodeForRefreshToken: true).signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      return GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<LoginResult> loginWithFacebook() async {
    try {
      LoginResult res = await FacebookAuth.instance
          .login(permissions: ['email', 'public_profile']);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthorizationCredentialAppleID> loginWithApple() async {
    try {
      var res = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      dev.log('authorization Code: ${res.authorizationCode}');
      dev.log('identity token: ${res.identityToken ?? ''}');
      dev.log('useridentifier: ${res.userIdentifier ?? ''}');
      return res;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';
import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<AppUser?> currentUser = Rx<AppUser?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Add this getter for easier access across the app
  String? get currentUserId => currentUser.value?.id;

  @override
  void onInit() {
    _auth.authStateChanges().listen(_handleAuthState);
    super.onInit();
  }

  Future<void> uploadProfileImage(String imagePath) async {
    try {
      isLoading(true);
      
    } catch (e) {
      errorMessage.value = 'Failed to upload image';
    } finally {
      isLoading(false);
    }
  }

  // auth_controller.dart
  Future<void> checkInitialAuthState() async {
    await _auth.authStateChanges().first; // Wait for initial auth state
    if (_auth.currentUser != null) {
      await _handleAuthState(_auth.currentUser);
    }
  }

  Future<void> updateProfile(String name, String location) async {
    try {
      isLoading(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception('User not logged in');

      await _firestore.collection('users').doc(uid).update({
        'name': name,
        'location': location,
      });

      currentUser.value = currentUser.value?.copyWith(
        name: name,
        location: location,
      );

      Get.back();
      Get.snackbar('Success', 'Profile updated');
    } catch (e) {
      errorMessage.value = 'Failed to update profile';
    } finally {
      isLoading(false);
    }
  }

  Future<void> _handleAuthState(User? user) async {
    if (user == null) {
      currentUser.value = null;
      return;
    }

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      currentUser.value =
          userDoc.exists
              ? AppUser.fromMap(userDoc.data()!, userDoc.id)
              : await _createNewUser(user);
    } catch (e) {
      errorMessage.value = 'Failed to fetch user data';
    }
  }

  Future<AppUser> _createNewUser(User firebaseUser) async {
    final newUser = AppUser(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? 'New User',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
      location: '',
      attendingEvents: [],
      hostingEvents: [],
      badges: [],
    );

    await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(newUser.toMap());

    return newUser;
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.EVENTS);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Login failed';
    } finally {
      isLoading(false);
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      isLoading(true);
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        // Create the user document in Firestore
        await _createNewUser(user);

        // Optionally update the name
        await _firestore.collection('users').doc(user.uid).update({
          'name': name,
        });

        // Load user data into currentUser
        await _handleAuthState(user);

        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Signup failed';
      return false;
    } finally {
      isLoading(false);
    }
  }



  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.offAllNamed(AppRoutes.EVENTS);
    } catch (e) {
      errorMessage.value = 'Google sign-in failed';
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      Get.offAllNamed(AppRoutes.LOGIN);
      var box = await Hive.openBox('profileBox');
      await box.clear();
    } catch (e) {
      errorMessage.value = 'Logout failed';
    }
  }

}

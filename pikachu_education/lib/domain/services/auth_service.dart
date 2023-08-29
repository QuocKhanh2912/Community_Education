import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikachu_education/data/modal/user_modal.dart';

class AuthenticationService {
  static Future<void> firebasePhoneNumberLogout() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<void> firebaseGoogleLogout() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
  }

  static Future<bool> firebaseLoginChecked() async {
    var userId = FirebaseAuth.instance.currentUser;
    if (userId == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<String> firebaseGetUserId() async {
    var currentUserId = FirebaseAuth.instance.currentUser?.uid.toString() ?? '';
    return currentUserId;
  }

  static Future<DataUserModal> firebaseLoginByGoogle() async {
    DataUserModal userCurrentInfo =
        DataUserModal(userId: '', userName: '', email: '');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var userInfo =
          await FirebaseAuth.instance.signInWithCredential(credential);
      Map mapDataUser = {
        'email': userInfo.user?.email,
        'name': userInfo.user?.displayName,
        'avatarUrl': userInfo.user?.photoURL
      };
      userCurrentInfo =
          DataUserModal.fromMap(key: userInfo.user!.uid, map: mapDataUser);
      return userCurrentInfo;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return userCurrentInfo;
  }

  static String? verification;

  static Future<bool> firebaseLoginByPhoneNumber(
      {required String phoneNum}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {}
        },
        codeSent: (String verificationId, int? resendToken) async {
          verification = verificationId;
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static String otpCodeSending({required String verificationId}) {
    return verificationId;
  }

  static bool wrongNumberPhoneWaring() {
    return true;
  }

  static Future<bool> firebaseVerifyOTP(
      {required String verificationId, required String otpNumber}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpNumber);
      await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }
}

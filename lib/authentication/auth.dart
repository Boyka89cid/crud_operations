import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future signInMailPassword(String emailID, String password) async
  {
    try
    {
      await _auth.createUserWithEmailAndPassword(email: emailID, password: password);
      await _auth.signInWithEmailAndPassword(email: emailID, password: password); // //awaits for future of signIn to finish.
      User user = _auth.currentUser; // assigning current user value to the user object of Class User.
      print(user?.uid.toString());
      return user;
    } on FirebaseAuthException
    catch (e)
    {
      print(e.toString());
      return e.message;
    }
  }
}
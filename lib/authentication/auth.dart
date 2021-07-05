import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  Future signInWithEmailPassword(String email, String password) async
  {
    try
        {
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          User user=FirebaseAuth.instance.currentUser;
          if(user==null)
            print("no");
          print(user?.uid.toString());
          return user;
        } on FirebaseAuthException catch(e)
        {
          print(e);
          return e.message;
        }
  }
}
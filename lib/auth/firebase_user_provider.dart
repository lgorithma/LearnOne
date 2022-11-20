import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LearnOneFirebaseUser {
  LearnOneFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

LearnOneFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LearnOneFirebaseUser> learnOneFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<LearnOneFirebaseUser>(
      (user) {
        currentUser = LearnOneFirebaseUser(user);
        return currentUser!;
      },
    );

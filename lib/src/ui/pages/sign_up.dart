import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pr_12/src/models/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Регистрация',
            style: TextStyle(
              color: Color.fromRGBO(76, 23, 0, 1.0),
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nicknameController,
              decoration: const InputDecoration(labelText: 'Никнейм'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  debugPrint('User UID: ${userCredential.user?.uid}');

                  final user = UserFromDB(
                    userId: userCredential.user!.uid,
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: nicknameController.text,
                    phone: phoneController.text ?? '',
                    image: '',
                    role: 'user',
                  );

                  FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(user.toJson());

                  // await ApiService().addUser(user);


                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}



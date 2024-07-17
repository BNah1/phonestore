import 'package:flutter/material.dart';
import 'package:onlineappstore/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  static const routerName = '/auth';

  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void handleSubmit() {
      final email = _emailControler.text;
      final password = _passControler.text;
      if (email.isNotEmpty && password.isNotEmpty) {
        Provider.of<AuthProvider>(context, listen: false)
            .login(email, password);
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('LOGGIN'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _emailControler,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passControler,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: handleSubmit, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}

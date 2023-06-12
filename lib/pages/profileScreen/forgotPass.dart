import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() {
    // Şifre sıfırlama işlemlerini gerçekleştir
    String email = _emailController.text;
    // Şifre sıfırlama işlemlerini Firebase'e entegre ederek gerçekleştirin
    // Örneğin: firebaseAuth.sendPasswordResetEmail(email: email);
    print('Şifre sıfırlama isteği gönderildi: $email');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Şifre Sıfırlama'),
        content: Text('Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifremi Unuttum'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-posta',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Şifremi Sıfırla'),
            ),
          ],
        ),
      ),
    );
  }
}

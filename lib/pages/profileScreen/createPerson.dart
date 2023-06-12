import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'loginPage.dart';
import '../bottomNavigator.dart';
import '../Datas/auth.dart';

class signupPage extends StatefulWidget {
  const signupPage({Key? key}) : super(key: key);

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Auth _auth = Auth();

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Giriş Başarılı'),
          content: Text('Giriş işlemi başarıyla tamamlandı.'),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop(); // AlertDialog'ı kapat
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onPressed() async {
    try {
      await _auth.createPerson(
        _nameController.text,
        _usernameController.text,
        _passwordController.text,
      );
      _showAlertDialog(context);
    } catch (error) {
      _showErrorSnackBar(context, 'Hata: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: Text('Kayıt Ol'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset("asset/image/signup.svg"),
                height: 200,
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "İsminiz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: Icon(Icons.tag_faces),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "E-posta Veya Numaranız",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: Icon(Icons.person_outline),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                child: TextFormField(
                  controller: _passwordController,
                  cursorRadius: Radius.circular(30),
                  decoration: InputDecoration(
                    labelText: "Şifrenizi Oluşturun",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    icon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.login_rounded, color: Colors.white),
                  title: Text(
                    "Kayıt ol",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onTap: _onPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

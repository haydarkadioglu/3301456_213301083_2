import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bottomNavigator.dart';
import 'profilePage.dart';
import 'forgotPass.dart';
import '../Datas/auth.dart';

List<String?> personData = [];

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Auth _auth = Auth();

  Widget alertDialogBuilder(BuildContext context, String title, String message) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('Tamam'),
          onPressed: () {
            Navigator.of(context).pop(); // AlertDialog'ı kapat
          },
        ),
      ],
    );
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
        title: Text('Giriş'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: SvgPicture.asset("asset/image/login.svg", height: 150),),
          SizedBox(height: 5),

          Card(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Kullanıcı adı/Numara",
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
                  labelText: "Şifreniz",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  icon: Icon(Icons.lock_outline)),
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
                "Giriş Yap",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                _auth.signInFunc(_usernameController.text, _passwordController.text)
                    .then((value) {
                  String userId = value?.uid ?? '';

                  return _auth.getUserData(userId);
                })
                    .then((userData) {

                  personData.add(userData['username']);
                  personData.add(_usernameController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(),
                    ),
                  );
                })
                    .catchError((error) {
                  showDialog(
                    context: context,
                    builder: (context) => alertDialogBuilder(context, 'Giriş Hatası', 'Giriş işlemi başarısız oldu: $error'),
                  );
                });
              },

            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                ));
              },
              child: Text(
                'Şifrenizi unuttunuz mu?',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () async {
                try {
                  final userCredential = await _auth.signInAnonymously();
                  final userData = await _auth.getUserData(userCredential.uid);

                  personData.add(userCredential.uid);
                  personData.add("guest: ${userData['username']}");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(),
                    ),
                  );
                } catch (e) {
                  print('Anonim giriş sırasında hata oluştu: $e');
                }
              },



              child: Text(
                'Misafir girişi',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 13.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
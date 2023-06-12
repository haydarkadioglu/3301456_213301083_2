
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'loginPage.dart';
import 'createPerson.dart';



class enterPage extends StatefulWidget {
  const enterPage({Key? key}) : super(key: key);

  @override
  State<enterPage> createState() => _enterPageState();
}

class _enterPageState extends State<enterPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sirius'a Hoşgeldin"),
          SizedBox(child: SvgPicture.asset("asset/image/chat.svg"),height: 250),
          SizedBox(height: 15,),
          Card(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
            color: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListTile(

              leading: Icon(Icons.person, color: Colors.white),
              title: Text("Giriş Yap", style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ),
          SizedBox(height: 15),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
            color: Colors.pink,
            child: ListTile(

              leading: Icon(Icons.description,color: Colors.white),
              title: Text("Kayıt ol", style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => signupPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}

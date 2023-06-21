import 'package:flutter/material.dart';
import 'package:sirius/pages/Datas/weatherData.dart';
import 'package:sirius/pages/homeScreen/drawerFiles/Drawer.dart';


class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<String> date = [];
  List<String> statusWeather = [];
  List<String> daytime = [];
  List<String> night = [];

  @override
  initState() {
    super.initState();
    getInfo();
  }

  void getInfo() async{
    List<List<String>> _takelist = await getWeather15day('${selectedCity!}');
    if(selectedCity == ''){
      selectedCity = 'istanbul';
    }
    setState(() {

      date = _takelist[0];
      statusWeather = _takelist[1];
      daytime = _takelist[2];
      night = _takelist[3];

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('15 Günlük Hava Durumu'),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: date.isEmpty
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text("Hava durumu yükleniyor..."),
          SizedBox(
            height: 15,
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      )
          :ListView.builder(
        itemCount: date.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Başlık sütunu için widget döndür
            return Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tarih',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Gündüz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Gece',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            int dataIndex = index - 1;
            return GestureDetector(
              onTap: () {
                if(dataIndex<=2){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherDetailsScreen(indis: dataIndex),
                    ),
                  );
                }
              },
              child: Card(
                color: Colors.white60,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.cloud_circle_outlined),
                  title: Text(date[dataIndex]),
                  subtitle: Text(statusWeather[dataIndex]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(daytime[dataIndex]),
                      SizedBox(width: 60),
                      Text(night[dataIndex]),
                    ],
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class WeatherDetailsScreen extends StatefulWidget {
  final int indis;

  WeatherDetailsScreen({required this.indis});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  List<String> hours = [];
  List<String> statusWeather = [];
  List<String> wind = [];

  @override
  initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() async{

      List<List<String>> _takelist = await getWeatherHours('${selectedCity!}', widget.indis);
    setState((){
      hours = _takelist[0];
      statusWeather = _takelist[1];
      wind = _takelist[2];

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Saatlik Hava Durumu'),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: hours.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hava durumu yükleniyor..."),
          SizedBox(
            height: 15,
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      )
          :ListView.builder(
        itemCount: hours.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Başlık sütunu için widget döndür
            return Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saat',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Rüzgar Hızı',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            );
          } else {
            int dataIndex = index - 1;
            return GestureDetector(
              onTap: (){},
              child: Column(
                children: [
                  Card(
                    color: Colors.white60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.timer_sharp),
                      title: Text(hours[dataIndex]),
                      subtitle: Text(statusWeather[dataIndex]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(wind[dataIndex]),
                        ],
                      ),
                    ),
                  ),

                ],
              ),

            );
          }
        },
      ),
    );
  }
}

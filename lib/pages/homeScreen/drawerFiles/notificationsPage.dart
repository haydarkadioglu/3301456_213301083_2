import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<String> notifications = [
    'İstanbul\'da yapılan eğitim konferansı büyük ilgi gördü.',
    'Dünya genelindeki COVID-19 vakalarında artış yaşanmaya devam ediyor.',
    'Yerli otomobil üretimi için fabrika inşaatı tamamlandı.',
    'Türkiye milli takımı Avrupa Futbol Şampiyonası\'nda çeyrek finale yükseldi.',
    'Bilim insanları yeni bir aşı çalışması üzerinde çalışıyor.',
    'İstanbul Boğazı\'nda gemi trafiği yoğunluğu arttı.',
    'Yeni bir teknoloji şirketi yatırım aldı.',
    'Hava durumu raporuna göre yarın yağış bekleniyor.',
    'E-ticaret sektörü son yıllarda büyük bir ivme kazandı.',
    'Bilim adamları, uzay araştırmaları için yeni bir proje başlattı.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Bildirimler'),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Column(
            children: [
              Card(
                color: Colors.white60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.login),
                  title: Text(notification),
                ),
              )

            ],
          );
        },
      ),
    );
  }
}

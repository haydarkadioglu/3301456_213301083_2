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
      appBar: AppBar(
        title: Text('Bildirimler'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Column(
            children: [
              ListTile(
                title: Text(notification),
                onTap: () {

                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}

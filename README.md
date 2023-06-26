# Dershane Öğrenci Takip Uygulaması

Bu uygulama Flutter ile 2023 Nisan ayında başlamıştır.

### Projeyi Kopyala

```bash
  git clone https://github.com/Hazret-Apps/biren.git
```

Bu uygulama ile admin olarak giriş yapan öğretmen veya yönetici ([Admin Uygulaması](https://github.com/Hazret-Apps/biren-admin)) öğrenci için:

> Ödev Oluşturabilir,


> Duyuru Oluşturabilir,


> Yoklama Alabilir,


> Deneme sonucu girebilir

### Ödev Oluşturma Algoritması
Ödev oluştururken öğretmen bir tarihi, öğrenciyi, dersi ve konuyu girer. Seçilen öğrenci anasayfasındaki takvimde ve ödevler kısmında ödevini görür. Tamamladığı zaman "tamamlandı" seçeneğini işaretler ve ödevinin fotoğrafını çeker. Öğretmen ise gelen ödevler içerisinde öğrencinin ödevini görür ve "yaptı, yapmadı veya eksik" olarak işaretler. 

### Duyuru Oluşturma Algoritması
Öğretmen belli bir öğrenci grubuna veya herkese fotoğraf veya PDF ile birlikte duyuru atabilir.

## Paketler
- [easy_localization](https://pub.dev/packages/easy_localization) (Uygulama dil desteği için)
- [firebase_core](https://pub.dev/packages/firebase_core) (+ diğer temel Firebase paketleri)
- [kartal](https://pub.dev/packages/kartal) (Context extension)
- [image_picker](https://pub.dev/packages/image_picker)

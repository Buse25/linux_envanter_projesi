 Linux Envanter Yönetim Projesi

Bu proje, *Linux terminali* üzerinde çalışan bir *envanter yönetimi* uygulamasıdır. Kullanıcılar, ürünleri listeleyebilir, ekleyebilir, silebilir ve düzenleyebilir. Uygulama, kullanıcı dostu bir deneyim sunmak için *Zenity* arayüzü ile entegre edilmiştir.

Kullanıcı Rolleri:

Yönetici: Ürün ekleme, güncelleme, silme ve kullanıcı yönetimi işlemlerini gerçekleştirebilir.
Kullanıcı: Ürünleri görüntüleyebilir ve rapor alabilir.

## 📋 Özellikler

- *Ürün Listeleme*: Depoda kayıtlı ürünleri tablo formatında görüntüler.
- *Ürün Ekleme*: Yeni ürünler kolayca eklenebilir.
- *Ürün Silme*: Kayıtlı ürünler listeden silinebilir.
- *Kullanıcı Yönetimi*: Kullanıcılar kullanıcı.csv dosyasında tutulur.
- *Loglama*: İşlemler log.csv dosyasında kayıt altına alınır.

## 🛠️ Gereksinimler

Bu projeyi çalıştırmak için aşağıdaki gereksinimlere ihtiyacınız vardır:

- *Linux İşletim Sistemi*
- *Bash (Unix shell)* 
- *Zenity* (GUI desteği için)

Zenity'yi yüklemek için şu komutu çalıştırabilirsiniz:
git clone https://github.com/username/repository-name.git


```bash
sudo apt install zenity

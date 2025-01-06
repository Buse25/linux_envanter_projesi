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

``
sudo apt install zenity
``

Dosyalara izin vermek için

``
chmod +x envanter.sh
``

Dosya çalıştırmak için

``
./envanter.sh
``


Github reposuna bağlanmak için kullanılan kod

``
git clone https://github.com/username/repository-name.git
``

Dosyayı git reposuna yüklemek için tam yolunu veririz

``
/home/kullanici_adi/dosya
``

Dosyanın tamamını git reposuna yüklemek için

``
git add.
``


## 👥 Kullanıcı Rolleri
- **Yönetici**: Ürün ekleme, güncelleme, silme, kullanıcı yönetimi ve rapor alma yetkisine sahiptir.
- **Kullanıcı**: Sadece ürünleri görüntüleyebilir ve rapor alabilir.

## Ana Menü



Kullanıcı girişi sonrası aşağıdaki seçenekler görüntülenir:

**Ürün Ekle**: Yeni bir ürünün bilgilerini girerek kayıt oluşturun.

**Ürün Listele**: Mevcut envanteri inceleyin.

**Ürün Güncelle:** Bir ürünün stok miktarı veya fiyatını güncelleyin.

**Ürün Sil**: Seçilen bir ürünü silin.

**Rapor Al:** İhtiyacınıza uygun bir rapor oluşturun.

**Kullanıcı Yönetimi:** Kullanıcı ekleme, listeleme ve güncelleme işlemlerini yürütün.

**Hata Kayıtları:** Hata kayıtları teknik işlemleri yapın.



## Ekran Görüntüleri

**1. Giriş Ekranı**
   
![Ekran görüntüsü 2025-01-06 143705](https://github.com/user-attachments/assets/adf92ebb-ed0c-4a51-9f0f-d8da8125b4d0)
![Ekran görüntüsü 2025-01-06 144020](https://github.com/user-attachments/assets/918863c7-6bad-466d-992f-3f68d81a5385)

**2. Ana Menü**

![Ekran görüntüsü 2025-01-06 144034](https://github.com/user-attachments/assets/ae0817c8-f1bf-4658-a53f-800ffed60681)

**3. Ürün Listeleme**

![Ekran görüntüsü 2025-01-06 144048](https://github.com/user-attachments/assets/f7667690-db34-4c3b-8291-60b1f24d06a2)

**4. Ürün Ekleme**

![Ekran görüntüsü 2025-01-06 144112](https://github.com/user-attachments/assets/2620800b-4806-444a-a2d0-23f0d8f04f4e)
![Ekran görüntüsü 2025-01-06 144126](https://github.com/user-attachments/assets/56c3daa6-e597-4b8a-a357-53846ab4ca8e)

**5.  Kullanıcı Sayfası**
   
![Ekran görüntüsü 2025-01-06 144229](https://github.com/user-attachments/assets/46584aa3-6739-4273-8659-c27590e64a55)

**6.Kullanıcı Listele**

![Ekran görüntüsü 2025-01-06 144247](https://github.com/user-attachments/assets/48381281-1d17-4e47-85db-f5feba5135bd)

**7.Hata Listesi**

![Ekran görüntüsü 2025-01-06 144301](https://github.com/user-attachments/assets/601a138b-ad16-49a9-8f86-d6d11267142e)



## ⚙️  Teknik Sorular ve Yanıtlar

1. Karşılaştığınız en büyük teknik sorun neydi ve nasıl çözdünüz?

Sorun: CSV dosyalarının senkronizasyonunda veri kaybı yaşanması.

Çözüm: Veri yazma ve okuma işlemleri için dosya kilitleme mekanizması kullanıldı.

2. Zenity kullanımında en zorlandığınız kısım neydi?

Karmaşık form yapılarını sade bir şekilde oluşturma ve doğrulama mekanizmaları.

3. Hata tespiti için hangi adımları izlediniz?

Tüm hatalar log.csv dosyasında kaydedildi. Hata mesajları ve tarih bilgileri inceleyerek sorunun kaynağına ulaşıldı.

4. Ürün güncellerken farklı kategorilerde ürünlerin aynı ada sahip olabileceğini nasıl ele aldınız?

Her ürün için benzersiz bir kategori-ürün kimliği oluşturduk.

5. Veri kaybını önlemek için hangi adımları attınız?

Tüm veriler işlem sonrası otomatik olarak yedeklendi.


## Video Tanıtım

Youtube video linki : https://www.youtube.com/watch?v=3YdQrevc3yM








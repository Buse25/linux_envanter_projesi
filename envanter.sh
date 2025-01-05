#!/bin/bash

# Gerekli CSV dosyalarını kontrol et ve oluştur
function create_csv_files() {
    if [ ! -f kullanici.csv ]; then
        echo "ID,Kullanıcı Adı,Şifre,Tip" > kullanici.csv
        echo "1,admin,admin,Yönetici" >> kullanici.csv
    fi
    if [ ! -f depo.csv ]; then
        echo "ID,Ürün Adı,Stok,Birim Fiyat,Kategori" > depo.csv
    fi
    if [ ! -f log.csv ]; then
        echo "Tarih,Saat,Hata Mesajı" > log.csv
    fi
}

# Hata kaydetme fonksiyonu
function hata_kaydet() {
    local hata_mesaji="$1"
    local tarih=$(date +"%Y-%m-%d")
    local saat=$(date +"%H:%M:%S")
    echo "$tarih,$saat,$hata_mesaji" >> log.csv
}

# Kullanıcı girişi
function kullanici_girisi() {
    while true; do
        KULLANICI_ADI=$(zenity --entry --title="Kullanıcı Girişi" --text="Kullanıcı adınızı girin:" --width=400)
        SIFRE=$(zenity --password --title="Kullanıcı Girişi" --text="Şifrenizi girin:" --width=300)
        KULLANICI_KONTROL=$(grep -i "^.*,${KULLANICI_ADI},${SIFRE}" kullanici.csv)

        if [ -n "$KULLANICI_KONTROL" ]; then
            KULLANICI_TIPI=$(echo "$KULLANICI_KONTROL" | cut -d ',' -f 4)
            zenity --info --text="Giriş başarılı! Hoş geldiniz, $KULLANICI_ADI." --width=300
            break
        else
            zenity --error --text="Hatalı kullanıcı adı veya şifre! Lütfen tekrar deneyin." --width=300
            hata_kaydet "Hatalı kullanıcı giriş denemesi: Kullanıcı Adı=${KULLANICI_ADI}"
        fi
    done
}

# Ana menü
function ana_menu() {
    while true; do
        SECIM=$(zenity --list --title="Envanter Yönetim Sistemi" \
            --text="Bir işlem seçin:" --width=800 --height=600 \
            --column="İşlem" \
            "Ürün Listele" "Ürün Ekle" "Ürün Güncelle" "Ürün Sil" "Rapor Al" "Kullanıcı Yönetimi" "Hata Kaydı Göster" "Çıkış")

        case "$SECIM" in
            "Ürün Listele") urun_listele ;;
            "Ürün Ekle") urun_ekle ;;
            "Ürün Güncelle") urun_guncelle ;;
            "Ürün Sil") urun_sil ;;
            "Rapor Al") rapor_al ;;
            "Kullanıcı Yönetimi") kullanici_yonetimi ;;
            "Hata Kaydı Göster") hata_kaydi_goster ;;
            "Çıkış") exit 0 ;;
            *) zenity --error --text="Geçersiz seçim!" --width=300
               hata_kaydet "Geçersiz seçim yapıldı." ;;
        esac
    done
}

# Hata kaydı gösterme fonksiyonu
function hata_kaydi_goster() {
    if [ $(wc -l < log.csv) -le 1 ]; then
        zenity --info --text="Hiç hata kaydı bulunmamaktadır." --width=300
    else
        zenity --text-info --title="Hata Kayıtları" --filename=log.csv --width=600 --height=400
    fi
}

# Ürün listeleme fonksiyonu
function urun_listele() {
    if [ $(wc -l < depo.csv) -le 1 ]; then
        zenity --info --text="Hiç ürün kaydı bulunmamaktadır." --width=300
    else
        # CSV dosyasını tablo hâlinde düzenle
        formatted_data=$(column -s',' -t < depo.csv)
        
        # Düzenlenmiş veriyi geçici bir dosyaya yaz
        echo "$formatted_data" > /tmp/depo_formatted.txt
        
        # Zenity ile göster
        zenity --text-info --title="Ürün Listesi" --filename=/tmp/depo_formatted.txt --width=600 --height=400
    fi
}

# Ürün ekleme fonksiyonu
function urun_ekle() {
    URUN_BILGILERI=$(zenity --forms --title="Ürün Ekle" --text="Yeni ürün bilgilerini girin:" \
        --add-entry="Ürün Adı" --add-entry="Stok" --add-entry="Birim Fiyat")
    if [ $? -eq 0 ]; then
        IFS='|' read -r URUN_ADI STOK FIYAT <<< "$URUN_BILGILERI"
        KATEGORI=$(zenity --list --title="Kategori Seçimi" --text="Bir kategori seçin:" --column="Kategori" \
            "Sebze" "Meyve" "Gıda" "Et-Süt" "Hijyen" "Kırtasiye" "Diğer")
        if [ $? -eq 0 ] && [ -n "$KATEGORI" ]; then
            if [ $(wc -l < depo.csv) -gt 1 ]; then
                MAX_ID=$(tail -n +2 depo.csv | cut -d ',' -f 1 | sort -n | tail -1)
                YENI_ID=$((MAX_ID + 1))
            else
                YENI_ID=1
            fi
            echo "$YENI_ID,$URUN_ADI,$STOK,$FIYAT,$KATEGORI" >> depo.csv
            zenity --info --text="Ürün başarıyla eklendi (ID: $YENI_ID)." --width=300
        else
            zenity --error --text="Kategori seçilmedi!" --width=300
            hata_kaydet "Ürün ekleme sırasında kategori seçilmedi: Ürün Adı=${URUN_ADI}"
        fi
    else
        zenity --error --text="Ürün ekleme işlemi iptal edildi." --width=300
        hata_kaydet "Ürün ekleme işlemi iptal edildi."
    fi
}

# Ürün güncelleme fonksiyonu
function urun_guncelle() {
    URUN_ADI=$(zenity --entry --title="Ürün Güncelle" --text="Güncellenecek ürünün adını girin:" --width=300)
    SATIR=$(grep -i "^.*,${URUN_ADI}," depo.csv)
    if [ -n "$SATIR" ]; then
        IFS=',' read -r ID AD STOK FIYAT KATEGORI <<< "$SATIR"
        YENI_BILGILER=$(zenity --forms --title="Ürün Güncelle" --text="Yeni bilgileri girin:" \
            --add-entry="Yeni Stok (Mevcut: $STOK)" --add-entry="Yeni Fiyat (Mevcut: $FIYAT)")
        if [ $? -eq 0 ]; then
            IFS='|' read -r YENI_STOK YENI_FIYAT <<< "$YENI_BILGILER"
            sed -i "s/^$ID,$AD,$STOK,$FIYAT,$KATEGORI/$ID,$AD,$YENI_STOK,$YENI_FIYAT,$KATEGORI/" depo.csv
            zenity --info --text="Ürün başarıyla güncellendi." --width=300
        else
            zenity --error --text="Güncelleme işlemi iptal edildi." --width=300
            hata_kaydet "Ürün güncelleme işlemi iptal edildi: Ürün Adı=${URUN_ADI}"
        fi
    else
        zenity --error --text="Bu isimle eşleşen bir ürün bulunamadı!" --width=300
        hata_kaydet "Ürün bulunamadı: Ürün Adı=${URUN_ADI}"
    fi
}

# Ürün silme fonksiyonu
function urun_sil() {
    URUN_ADI=$(zenity --entry --title="Ürün Sil" --text="Silmek istediğiniz ürünün adını girin:" --width=300)
    SATIR=$(grep -i "^.*,${URUN_ADI}," depo.csv)
    if [ -n "$SATIR" ]; then
        sed -i "/^.*,$URUN_ADI,/Id" depo.csv
        zenity --info --text="Ürün başarıyla silindi." --width=300
    else
        zenity --error --text="Bu isimle eşleşen bir ürün bulunamadı!" --width=300
        hata_kaydet "Ürün silinemedi: Ürün Adı=${URUN_ADI}"
    fi
}

# Rapor alma fonksiyonu
function rapor_al() {
    zenity --text-info --title="Depo Raporu" --filename=depo.csv --width=600 --height=400
}

# Kullanıcı yönetimi
function kullanici_yonetimi() {
    SECIM=$(zenity --list --title="Kullanıcı Yönetimi" \
        --text="Bir işlem seçin:" --width=600 --height=400 \
        --column="İşlem" \
        "Kullanıcı Ekle" "Kullanıcı Listele" "Kullanıcı Sil")

    case "$SECIM" in
        "Kullanıcı Ekle") kullanici_ekle ;;
        "Kullanıcı Listele") kullanici_listele ;;
        "Kullanıcı Sil") kullanici_sil ;;
        *) zenity --error --text="Geçersiz seçim!" --width=300
           hata_kaydet "Kullanıcı yönetiminde geçersiz seçim yapıldı." ;;
    esac
}

# Kullanıcı ekleme fonksiyonu
function kullanici_ekle() {
    YENI_KULLANICI=$(zenity --forms --title="Kullanıcı Ekle" --text="Yeni kullanıcı bilgilerini girin:" \
        --add-entry="Kullanıcı Adı" --add-entry="Şifre" --add-list="Tip" --list-values="Yönetici|Kullanıcı")
    if [ $? -eq 0 ]; then
        IFS='|' read -r KULLANICI_ADI SIFRE TIP <<< "$YENI_KULLANICI"
        if [ $(wc -l < kullanici.csv) -gt 1 ]; then
            MAX_ID=$(tail -n +2 kullanici.csv | cut -d ',' -f 1 | sort -n | tail -1)
            YENI_ID=$((MAX_ID + 1))
        else
            YENI_ID=1
        fi
        echo "$YENI_ID,$KULLANICI_ADI,$SIFRE,$TIP" >> kullanici.csv
        zenity --info --text="Kullanıcı başarıyla eklendi." --width=300
    else
        zenity --error --text="Kullanıcı ekleme işlemi iptal edildi." --width=300
        hata_kaydet "Kullanıcı ekleme işlemi iptal edildi."
    fi
}

# Kullanıcı listeleme fonksiyonu
function kullanici_listele() {
    zenity --text-info --title="Kullanıcı Listesi" --filename=kullanici.csv --width=600 --height=400
}

# Kullanıcı silme fonksiyonu
function kullanici_sil() {
    KULLANICI_ID=$(zenity --entry --title="Kullanıcı Sil" --text="Silmek istediğiniz kullanıcının ID'sini girin:"
     --width=300)
    SATIR=$(grep -w "^$KULLANICI_ID" kullanici.csv)
    if [ -n "$SATIR" ]; then
        sed -i "/^$KULLANICI_ID,/d" kullanici.csv
        zenity --info --text="Kullanıcı başarıyla silindi." --width=300
    else
        zenity --error --text="Bu ID ile eşleşen bir kullanıcı bulunamadı!" --width=300
        hata_kaydet "Kullanıcı silinemedi: Kullanıcı ID=${KULLANICI_ID}"
    fi
}

# Program başlangıcı
create_csv_files
kullanici_girisi
ana_menu

# Real-Time

Real-Time, SA-MP (San Andreas Multiplayer) için gerçek zamanı oyun zamanıyla senkronize eden bir Filterscript'tir. Sunucuda gerçek zamana dayalı otomatik zaman değişiklikleri sağlayarak daha sürükleyici bir deneyim sunar.

## Diller

- Português: [README](../../)
- Deutsch: [README](../Deutsch/README.md)
- English: [README](../English/README.md)
- Español: [README](../Espanol/README.md)
- Français: [README](../Francais/README.md)
- Italiano: [README](../Italiano/README.md)
- Polski: [README](../Polski/README.md)
- Русский: [README](../Русский/README.md)
- Svenska: [README](../Svenska/README.md)

## İçindekiler
- [Real-Time](#real-time)
  - [Diller](#diller)
  - [İçindekiler](#i̇çindekiler)
  - [Kurulum](#kurulum)
  - [Teknik İşleyiş](#teknik-i̇şleyiş)
    - [Zaman Sistemi](#zaman-sistemi)
  - [Kullanım Alanları](#kullanım-alanları)
    - [İdeal Kullanım Alanları:](#i̇deal-kullanım-alanları)
  - [Teknik Detaylar](#teknik-detaylar)
    - [Uygulanan Optimizasyonlar](#uygulanan-optimizasyonlar)
    - [Ana Özellikler:](#ana-özellikler)
  - [Lisans](#lisans)
    - [Koşullar:](#koşullar)

## Kurulum

1. [Real-Time.amx](https://github.com/ocalasans/Real-Time/raw/refs/heads/main/src/Real-Time.amx) dosyasını indirin
2. Dosyayı sunucunuzun `filterscripts` klasörüne kopyalayın
3. `server.cfg` dosyasını düzenleyin
4. `filterscripts` satırına `Real-Time` ekleyin

**server.cfg'de örnek yapılandırma:**
```
filterscripts Real-Time
```

> [!WARNING]
> Eğer başka filterscript'ler zaten yüklüyse, Real-Time'ı onlardan sonra ekleyin.

## Teknik İşleyiş

Sistem, mevcut zamanı her 5 saniyede bir kontrol eden optimize edilmiş bir zamanlayıcı ile çalışır. Aşağıda kontrolün nasıl yapıldığını gösteren bir kod örneği bulunmaktadır:

```pawn
#define TRF_UPDATE_INTERVAL  5*1000 // Her 5 saniyede bir güncelleme
#define TRF_DAWN_TIME        5 // 00:00 - 05:59 -> 05:00
#define TRF_MORNING_TIME     7 // 06:00 - 10:59 -> 07:00
#define TRF_NOON_TIME        12 // 11:00 - 15:59 -> 12:00
#define TRF_EVENING_TIME     20 // 16:00 - 17:59 -> 20:00
#define TRF_NIGHT_TIME       0 // 18:00 - 23:59 -> 00:00
```

### Zaman Sistemi
Filterscript aşağıdaki zaman dönüşümlerini kullanır:
- **Şafak**: 00:00 - 05:59 → Oyunda 05:00
- **Sabah**: 06:00 - 10:59 → Oyunda 07:00
- **Öğlen**: 11:00 - 15:59 → Oyunda 12:00
- **Akşam**: 16:00 - 17:59 → Oyunda 20:00
- **Gece**: 18:00 - 23:59 → Oyunda 00:00

> [!NOTE]
> Sistem, mevcut sunucu zamanını almak için `gettime()` kullanır. Sunucunuzun doğru saat dilimi ile yapılandırılmış olması çok önemlidir.

## Kullanım Alanları

### İdeal Kullanım Alanları:
1. **RolePlay Sunucuları**
   - Gerçekçiliği artırır
   - Sunucu etkinliklerini gerçek zamanla senkronize eder
   - Oyuncu deneyimini geliştirir

2. **DayZ Sunucuları**
   - Gerçekçi gündüz/gece sistemi
   - Doğal zaman döngüsü
   - Gerçek zamana dayalı etkinlik planlaması

3. **Rekabetçi Sunucular**
   - Belirli zamanlarda etkinlik organizasyonu
   - Planlanmış çevre değişiklikleri
   - Hava durumu sistemleri ile entegrasyon

## Teknik Detaylar

### Uygulanan Optimizasyonlar
```pawn
// Gereksiz güncellemeleri önlemek için global değişken
static TRF_Last_WorldTime = -1;

// Optimize edilmiş güncelleme fonksiyonu
public TRF_UpdateWorldTime() {
    new TRF_Current_Hour,
        TRF_Current_Minute,
        TRF_Current_Second;
    
    gettime(TRF_Current_Hour, TRF_Current_Minute, TRF_Current_Second);
    
    // Sadece zaman değiştiğinde günceller
    if(TRF_New_WorldTime != TRF_Last_WorldTime)
    {
        SetWorldTime(TRF_New_WorldTime);
        TRF_Last_WorldTime = TRF_New_WorldTime;
    }
}
```

### Ana Özellikler:
- Gereksiz güncellemeleri önlemek için son zamanın önbelleğe alınması
- Kaynak kullanımını azaltmak için optimize edilmiş zamanlayıcı
- Diğer filterscript'lerle tam uyumluluk

> [!IMPORTANT]
> Sistem, performans göz önünde bulundurularak geliştirilmiş olup, kontrolleri yalnızca gerektiğinde yapar ve son ayarlanan zamanın önbelleğini tutar.

## Lisans

Bu Filterscript, Apache License 2.0 kapsamında korunmaktadır ve şunlara izin verir:

- ✔️ Ticari ve özel kullanım
- ✔️ Kaynak kodu değişikliği
- ✔️ Kod dağıtımı
- ✔️ Patent izni

### Koşullar:
- Telif hakkı bildirimini koruyun
- Önemli değişiklikleri belgeleyin
- Apache License 2.0'ın bir kopyasını ekleyin

Lisans hakkında daha fazla bilgi için: http://www.apache.org/licenses/LICENSE-2.0

**Copyright (c) Calasans - Tüm hakları saklıdır**
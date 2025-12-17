#!/bin/bash

# Sistem zaman dilimi ayari
export TZ="Europe/Istanbul"

# Sistem verilerinin degiskenlere atanmasi
TARIH=$(date "+%Y-%m-%d %H:%M:%S")
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
RAM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')
DISK=$(df -h / | awk 'NR==2{printf "%s / %s (%s)", $3,$2,$5}')
KULLANICI=$(who | wc -l)

# HTML rapor sablonu
HTML_CONTENT="<html>
<head>
    <meta charset='UTF-8'>
    <title>Sunucu Durum Paneli</title>
    <style>
        body { font-family: sans-serif; text-align: center; background: #f0f2f5; padding: 20px; }
        .box { display: inline-block; border: 2px solid #333; padding: 20px; border-radius: 10px; background: white; text-align: left; box-shadow: 5px 5px 15px rgba(0,0,0,0.1); }
        h1 { color: #1a73e8; }
        p { font-size: 1.1em; border-bottom: 1px solid #eee; padding: 5px 0; }
    </style>
</head>
<body>
    <h1>📊 Sunucu Durum Paneli</h1>
    <div class='box'>
        <p><b>🕒 Rapor Saati:</b> $TARIH</p>
        <p><b>⚡ İşlemci Yükü:</b> %$CPU</p>
        <p><b>💾 RAM Durumu:</b> $RAM</p>
        <p><b>💽 Disk Alanı:</b> $DISK</p>
        <p><b>👤 Aktif Kullanıcı Sayısı:</b> $KULLANICI</p>
    </div>
    <p><small>Bu sayfa her dakika otomatik olarak güncellenmektedir.</small></p>
</body>
</html>"

# Ciktinin web dizinine aktarilmasi
echo "$HTML_CONTENT" | sudo tee /var/www/html/index.html > /dev/null

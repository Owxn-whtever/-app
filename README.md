# 💰 Personal Finance Tracker App (Flutter)

แอปสำหรับติดตามรายรับรายจ่ายส่วนตัว พัฒนาโดยใช้ **Flutter** และ **SQLite** เหมาะสำหรับผู้ที่ต้องการจัดการการเงินในชีวิตประจำวันแบบง่ายๆ โดยไม่ต้องเชื่อมต่ออินเทอร์เน็ต

---

## 📱 Features

- เพิ่ม/แก้ไข/ลบ รายการรายรับ-รายจ่าย
- กำหนดหมวดหมู่ เช่น อาหาร เดินทาง ช้อปปิ้ง ฯลฯ
- แสดงรายการทั้งหมด พร้อมวันที่และเวลาที่บันทึก
- บันทึกข้อมูลภายในเครื่อง (ใช้ SQLite)
- UI ใช้งานง่าย รองรับทั้ง Android และ iOS

---

## 📦 วิธีติดตั้งและใช้งาน (Installation)

### 🧑‍💻 1. สำหรับนักพัฒนา (Developer)

> เหมาะสำหรับผู้ที่ต้องการแก้ไขหรือทดลองโค้ด

```bash
git clone https://github.com/Owxn-whtever/-app.git
cd -app
flutter pub get
flutter run
🧪 สามารถทดสอบผ่าน Emulator หรืออุปกรณ์จริง

📲 2. สำหรับผู้ใช้งานทั่วไป (ติดตั้ง .APK)
เหมาะสำหรับผู้ที่ต้องการใช้งานแอปโดยไม่ต้องเขียนโค้ด

ไปที่หน้า Releases

ดาวน์โหลดไฟล์ app-release.apk

เปิดไฟล์ .apk เพื่อติดตั้งบนอุปกรณ์ Android

หากมีข้อความแจ้งเตือน ให้เลือก "อนุญาตจากแหล่งที่ไม่รู้จัก"

📸 Screenshots
(ใส่รูปในโฟลเดอร์ screenshots/ แล้วแก้ลิงก์ด้านล่างให้ตรง)

หน้าหลัก	เพิ่มรายการ	แก้ไขรายการ

🛠️ เทคโนโลยีที่ใช้
Flutter

Dart

SQLite

📁 โครงสร้างโปรเจกต์เบื้องต้น
bash
คัดลอก
แก้ไข
/lib
 ├── main.dart               # Entry point
 ├── pages/                 # หน้าต่างๆ ในแอป
 ├── models/                # คลาสข้อมูล
 ├── db/                    # ฟังก์ชัน SQLite
 └── widgets/               # ส่วนประกอบ UI
📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙋‍♂️ ผู้พัฒนา
Owxn-whtever
GitHub: github.com/Owxn-whtever

💡 สนใจฟีเจอร์เพิ่มเติม?
สามารถติดต่อเพื่อปรับแต่งตามความต้องการ เช่น:

เพิ่มแผนภูมิรายจ่าย

รองรับหลายบัญชี

ระบบสำรองข้อมูล

Export ข้อมูลเป็น PDF / Excel

📩 ติดต่อผ่าน Issues หรือ Discussions บน GitHub ได้เลยครับ

yaml
คัดลอก
แก้ไข

---

### ✅ สิ่งที่ควรทำต่อ:
- สร้างโฟลเดอร์ `screenshots/` และใส่ภาพหน้าจอ (แอปหน้าหลัก, เพิ่ม/ลบรายการ ฯลฯ)
- อัปโหลด `.apk` ไปที่หน้า [Releases](https://github.com/Owxn-whtever/-app/releases)
- สร้างไฟล์ `LICENSE` ถ้ายังไม่มี → ใช้ MIT License ได้เลย

หากต้องการให้ช่วยเขียนไฟล์ LICENSE, Release Note หรือสร้าง .apk ก็แจ้งได้นะครับ 🙌

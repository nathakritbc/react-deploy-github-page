# ใช้ฐานข้อมูล official node แบบ LTS ในการสร้าง image
FROM node:14 AS build

# กำหนดไดเร็กทอรีที่จะใช้ในการสร้างและคอมไพล์โปรเจค React
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json ไปยังคอลัมน์ที่ชื่อว่า build
COPY package*.json ./

# ติดตั้ง dependencies และคอมไพล์โปรเจค
RUN npm install
COPY . .
RUN npm run build

# สร้าง image สำหรับการทำงานจริงๆ โดยใช้ nginx เป็นเซิร์ฟเวอร์สำหรับแอปพลิเคชัน React
FROM nginx:alpine3.18

# คัดลอกไฟล์ที่คอมไพล์จากคอลัมน์ build มายังตำแหน่งที่เหมาะสำหรับ nginx
COPY --from=build /app/dist /usr/share/nginx/html

# แก้ไขการกำหนดค่าตัวแปร PORT (ถ้ามี)
# ENV PORT=80

# แก้ไขการกำหนดค่าการใช้งาน nginx (ถ้ามี)
# EXPOSE 80

# คำสั่งเริ่มต้น nginx ในโหมดทำงานหลังหน้า (foreground mode)
CMD ["nginx", "-g", "daemon off;"]

# Nginx 베이스 이미지
FROM nginx:alpine

# Nginx 설정 복사
COPY default.conf /etc/nginx/conf.d/default.conf

# 정적 파일 복사
COPY ../public /usr/share/nginx/html

# Nginx 서버 시작
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

// frontend/config.

import dotenv from 'dotenv';

// .env 파일의 환경 변수 로드
dotenv.config();

const config = {
    API_URL: process.env.API_URL || 'http://127.0.0.1:8000', // 기본값 설정
    BACKEND1_URL: process.env.BACKEND1_URL,
    BACKEND2_URL: process.env.BACKEND2_URL,
    BACKEND3_URL: process.env.BACKEND3_URL,
    BACKEND4_URL: process.env.BACKEND4_URL,
};

export default config;
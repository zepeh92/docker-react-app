# 여기부터 다음 FROM까진 builder Stage임을 명시
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

FROM nginx

# builder 스테이지의 특정 경로 파일들을 모두 지정한 경로로 복사.
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

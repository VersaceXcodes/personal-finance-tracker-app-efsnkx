FROM node:18 as frontend-build

WORKDIR /app/vitereact

COPY vitereact/package.json  ./
RUN npm install --legacy-peer-deps

RUN npm install --save-dev eslint-plugin-import eslint-plugin-react @typescript-eslint/parser @typescript-eslint/eslint-plugin
RUN npm install --save-dev eslint-import-resolver-typescript

COPY vitereact ./
RUN npm run build

FROM node:18 as backend

WORKDIR /app/backend

COPY backend/package.json  ./
RUN npm install --production

COPY backend ./
# No need to copy the frontend build files since Vite is configured to output directly to backend/public

EXPOSE 8080
CMD ["node", "server.js"]
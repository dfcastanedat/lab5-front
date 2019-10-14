FROM node:lts-alpine
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
COPY node_modules app/node_modules
RUN npm install
RUN npm install @vue/cli@3.7.0 -g
RUN npm install apollo
RUN npm install axios
RUN vue add apollo
CMD ["npm", "run", "serve"]
EXPOSE 8080
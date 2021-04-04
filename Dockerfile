FROM node:12

ENV PORT=8080

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If you are building your code for production
# RUN npm ci --only=production
ENV APP_ENV=development
RUN if [ $APP_ENV != "production" ]; then \
        npm install; \
    else \
        npm ci --only=production; \
    fi

# Bundle app source
COPY . .

RUN npm run build

CMD [ "npm", "run", "start" ]

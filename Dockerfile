FROM nginx:alpine

# Install npm and node
RUN apk add --update npm

# Add bash
RUN apk add --no-cache bash

WORKDIR /app

COPY package.json ./

ENV APP_ENV=development
RUN if [ $APP_ENV != "production" ]; then \
        npm install; \
    else \
        npm ci --only=production; \
    fi

COPY . .

# # Make our shell script executable
RUN chmod +x start.sh

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD ["/bin/bash", "-c", "/app/start.sh && nginx -g 'daemon off;'"]

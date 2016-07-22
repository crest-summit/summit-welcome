FROM nginx:1.11.1

COPY public /usr/share/nginx/html

COPY entrypoint.sh /
RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

FROM node:lts-bookworm

    # Install Haraka and dependencies
RUN npm install -g Haraka@3.0.2 && \
    npm install -g express@4.18.2 && \
    # Initialize a configuration directory
    haraka -i /haraka

WORKDIR /haraka
    
    # Install external plugins
RUN npm install @mailprotector/haraka-plugin-prometheus --save

COPY ./fs/ /

    # Prepare for non-root execution
RUN chgrp -R node /haraka && \
    chown -R node /haraka

EXPOSE 2525
EXPOSE 9904

VOLUME [ "/haraka" ]

WORKDIR /
USER node

ENTRYPOINT [ "haraka" ]
CMD [ "-c", "/haraka" ]
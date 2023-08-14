FROM node:lts-bookworm

    # Install Haraka and dependencies
RUN npm install -g Haraka && \
    npm install -g express && \
    # Initialize a configuration directory
    haraka -i /haraka && \
    # Install external plugins
    cd /haraka && npm install @mailprotector/haraka-plugin-prometheus --save

COPY ./fs/ /

    # Prepare for non-root execution
RUN chgrp -R node /haraka && \
    chown -R node /haraka

USER node

EXPOSE 2525
EXPOSE 9904

VOLUME [ "/haraka" ]

ENTRYPOINT [ "haraka" ]
CMD [ "-c", "/haraka" ]
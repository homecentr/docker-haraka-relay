FROM node:lts-bookworm

    # Install Haraka and dependencies
RUN npm install -g Haraka@3.0.2 && \
    npm install -g express@4.18.2 && \
    # Initialize a configuration directory
    haraka -i /haraka && \
    # Create non-root user
    groupadd -g 7000 haraka && \
    useradd -rm -g haraka -u 7000 haraka

WORKDIR /haraka
    
    # Install external plugins
RUN npm install @mailprotector/haraka-plugin-prometheus@1.0.6 --save

COPY ./fs/ /

    # Prepare for non-root execution
RUN chgrp -R haraka /haraka && \
    chown -R haraka /haraka

EXPOSE 2525
EXPOSE 9904

VOLUME [ "/haraka" ]

WORKDIR /
USER haraka

ENTRYPOINT [ "haraka" ]
CMD [ "-c", "/haraka" ]
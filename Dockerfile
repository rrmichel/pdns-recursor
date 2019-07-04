FROM alpine:3.10

LABEL build="Thu 04 Jul 2019 10:52:38 PM CEST"

ENV alpine_version="3.10" \
    recursor_version="4.1.13-r0"

RUN apk add --no-cache \
    pdns-recursor \
    python3

RUN pip3 install --no-cache-dir envtpl

ENV PDNS_setuid=recursor \
	PDNS_setgid=recursor \
	PDNS_local_port=53 \
	PDNS_local_address=0.0.0.0 \
	PDNS_allow_from=0.0.0.0/0 \
	PDNS_daemon=no

EXPOSE 53 53/udp

COPY recursor.conf.tpl /
COPY recursor-entrypoint.sh /

ENTRYPOINT [ "/recursor-entrypoint.sh" ]

CMD [ "/usr/sbin/pdns_recursor" ]

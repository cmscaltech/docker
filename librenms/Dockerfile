FROM alpine:latest

RUN apk add python3
COPY add_switch.py /root/
RUN chmod +x /root/add_switch.py
COPY dbstart.sh /root/
RUN chmod +x /root/dbstart.sh

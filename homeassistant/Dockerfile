FROM archlinux:latest
LABEL Maintainer=lans.rf@gmail.com
RUN pacman -Syu --noconfirm archlinux-keyring \
   &&  pacman-key --init \
   &&  pacman -Suy --noconfirm \
   &&  pacman -Sy --noconfirm home-assistant python-pip ffmpeg \
   &&  systemctl enable home-assistant 
RUN python -m venv --upgrade /var/lib/hass/.venv \
   &&  /var/lib/hass/.venv/bin/python -m pip install --upgrade pip \
   &&  /var/lib/hass/.venv/bin/python -m pip install wheel websocket-client /usr/share/home-assistant/homeassistant*.whl
ENTRYPOINT ["/var/lib/hass/.venv/bin/hass", "--config", "/config", "--log-file", "/var/log/hass/home-assistant.log", "--log-rotate-days", "1"] 

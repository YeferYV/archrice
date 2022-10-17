#============ Docker build/run archrice-dockerfile ===========#

# sudo pkill dockerd && sleep 1 && sudo dockerd --experimental & disown
# docker build --squash . -t archrice-dockerfile
# docker run -it \
#            --name archrice-dockerfile \
#            --volume=${PWD%/*}:/home/drknss/.config/dotfiles/docker-shared-volume \
#            --volume=/run/user/1000/pulse/native:/run/user/1000/pulse/native \
#            --volume=/tmp/.X11-unix:/tmp/.X11-unix \
#            archrice-dockerfile

#============== Dockerfile: archrice-dockerfile ==============#

from archlinux:base-devel
RUN echo "export APPIMAGE_EXTRACT_AND_RUN=1 EDITOR='nvim'" >> /root/.profile
COPY . /root/.config/dotfiles/dotfiles
RUN cd /root/.config/dotfiles/dotfiles/.local/bin && RESETARCH_SNAPSHOT=true ./RiceArch
ENV APPIMAGE_EXTRACT_AND_RUN=1
USER drknss
WORKDIR /home/drknss
ENV XDG_RUNTIME_DIR=/run/user/1000
RUN sudo mkdir -p /run/user/1000/pulse && sudo chown -R drknss:drknss /run/user/1000
RUN yes | sudo pacman -S pulseaudio
RUN echo "/dev/pts/0" >> /tmp/sixel-$WEZTERM_PANE
CMD ["/bin/zsh","-l"]

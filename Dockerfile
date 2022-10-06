#================== Docker Build Dockerfile ==================#

# docker build . -t archrice-dockerfile
# docker run -it --name archrice-dockerfile -v /tmp/.X11-unix:/tmp/.X11-unix archrice-dockerfile

#========================= Dockerfile ========================#

from archlinux:base-devel
RUN echo "export APPIMAGE_EXTRACT_AND_RUN=1 EDITOR='nvim'" >> /root/.profile
COPY . /root/.config/dotfiles/dotfiles
RUN cd /root/.config/dotfiles/dotfiles/.local/bin && RESETARCH_SNAPSHOT=true ./RiceArch
ENV APPIMAGE_EXTRACT_AND_RUN=1
USER drknss
WORKDIR /home/drknss
CMD ["/bin/zsh","-l"]

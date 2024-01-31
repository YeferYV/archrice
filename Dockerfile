#================ Dockerfile run archrice ======================#

# xhost +
# docker build --tag archrice .
# docker run -it \
#     --name archrice \
#     --ipc=host \
#     --volume=/run/user/1000/pipewire-0:/run/user/1000/pipewire-0 \
#     --volume=/tmp/.X11-unix:/tmp/.X11-unix \
#     archrice

#====================== Dockerfile =============================#

FROM archlinux:base-devel

# add user:
RUN useradd -mG wheel drksl; \
  echo root:toor  | chpasswd; \
  echo drksl:toor | chpasswd; \
  echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

# Arch dependencies:
RUN pacman -Sy --noconfirm bat fzf lazygit libsixel lf ripgrep starship tmux unzip xclip zsh glibc \
  && curl -L https://github.com/Jguer/yay/releases/download/v12.1.2/yay_12.1.2_x86_64.tar.gz | tar -xzf- --strip-components=1 --directory="/usr/local/bin" "yay_12.1.2_x86_64/yay" \
  && curl -L https://github.com/neovim/neovim/releases/download/v0.9.1/nvim.appimage                               --create-dirs --output "/usr/local/bin/nvim" && chmod +x /usr/local/bin/nvim \
  && sudo -u "drksl" -s -- sh -c "yes | yay -S  --noconfirm ghostscript imagemagick mpv openssh pipewire-pulse poppler stow zsh-autosuggestions zsh-fast-syntax-highlighting" \
  && yes | yay -Scc

# locales for zsh-autosuggestions:
RUN sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen

USER drksl
WORKDIR /home/drksl
EXPOSE 22/tcp
EXPOSE 8080/tcp
ENV HOME="/home/drksl"
ENV USER="drksl"
ENV SHELL="/bin/zsh"
ENV DISPLAY=:0
ENV XDG_RUNTIME_DIR=/run/user/1000
SHELL ["/bin/zsh","-c"]

# Dotfiles:
COPY --chown=drksl . /home/drksl/.config/dotfiles/archrice

# stow:
RUN mkdir -p $HOME/.local \
  && cd $HOME/.config/dotfiles/archrice \
  && stow --restow --verbose --target="$HOME"/.config .config \
  && stow --restow --verbose --target="$HOME"/.local .local \
  && ln -sf "$HOME"/.config/shell/.zprofile "$HOME"/.zprofile \
  && rm -rf $HOME/{.bash_logout,.bash_profile,.bashrc}

# openssh:
# RUN  sudo /usr/bin/ssh-keygen -A && echo "sudo /sbin/sshd" >>$HOME/.zprofile

# CMD ["/bin/zsh","-l"]
# SHELL ["/bin/zsh","-l"]
ENTRYPOINT ["/bin/zsh","-l"]

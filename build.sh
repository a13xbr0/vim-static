#!/bin/sh

docker run -i --rm -v "$PWD":/out -w /root alpine /bin/sh <<EOF
apk add gcc make musl-dev ncurses-static
wget https://github.com/vim/vim/archive/refs/tags/v9.0.0399.tar.gz
tar -xf *.tar.gz
cd vim-*
LDFLAGS="-static" ./configure --disable-channel --disable-gpm --disable-gtktest --disable-gui --disable-netbeans --disable-nls --disable-selinux --disable-smack --disable-sysmouse --disable-xsmp --enable-multibyte --with-features=huge --without-x --with-tlib=ncursesw
make -j4
make install
cp /usr/local/bin/vim /out/
strip /out/vim
chown -R $(id -u):$(id -g) /out/vim
EOF

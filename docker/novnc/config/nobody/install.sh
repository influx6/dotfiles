#!/bin/bash

set -x

mkdir -p $HOME/lib/perl5
export PERL5LIB=${HOME}/lib/perl5
export PERL_MM_OPT="INSTALL_BASE=${PERL5LIB}"

# setup ls++
curl -L https://cpanmin.us | perl - --sudo App::cpanminus
cpanm Term::ExtendedColor File::LsColor
cpan Term::ExtendedColor File::LsColor
git clone https://github.com/forkkit/ls--.git
cd ls--
perl Makefile.PL
make
make install
cd -
rm -rf ls--

# setup sudo permissions
echo "novnc ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "%novnc ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "%users ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "%wheel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "1000 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
echo "%1000 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \

# setup NOVNC
git clone --depth 1 https://github.com/crt-fork/noVNC.git $HOME/noVNC && \
git clone --depth 1 https://github.com/crt-fork/websockify $HOME/noVNC/utils/websockify && \
rm -rf $HOME/noVNC/.git && \
rm -rf $HOME/noVNC/utils/websockify/.git && \
sed -i -- "s/ps -p/ps -o pid | grep/g" $HOME/noVNC/utils/novnc_proxy

# setup guacamole
sudo -H -u novnc mkdir -p /home/novnc/guacamole


# disable build
sudo -H -u novnc mkdir -p /home/novnc/tomcat
#sudo -H -u novnc wget https://mirror-hk.koddos.net/apache/tomcat/tomcat-connectors/native/1.2.31/source/tomcat-native-1.2.31-src.tar.gz -O /home/novnc/tomcat-native-1.2.31-src.tar.gz
#if [ -f /home/novnc/tomcat-native-1.2.31-src.tar.gz ]; then
#  sudo -H -u novnc mkdir -p /home/novnc/tomcat-native
#  sudo -H -u novnc tar xvzf /home/novnc/tomcat-native-1.2.31-src.tar.gz --strip-components 1 --directory /home/novnc/tomcat-native/
#  rm -rf tomcat-native-1.2.31-src.tar.gz
#  cd /home/novnc/tomcat-native/native
#  ./configure --with-apr=/usr/bin/apr-1-config \
#              --with-java-home="$JAVA_JOME" \
#              --with-ssl=yes \
#              --prefix="$CATALINA_HOME"
#else
#  echo "Failed to download tomcat, please investigate"
#  exit 1;
#fi

# setup guacamole-client
# --> we will place a predownloaded war from: wget https://dlcdn.apache.org/guacamole/1.4.0/binary/guacamole-1.4.0.war -O /opt/tomcat/webapps/guacamole.war
export PATH="/home/novnc/tomcat/bin:$PATH"

#rc-update add sshd
#rc-service xrdp start
#rc-service xrdp-sesman start
#rc-service vino start

# install oh my bash
sudo -H -u novnc bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

sudo -H -u novnc echo 'source $HOME/.base_profile' >> /home/novnc/.bashrc
sudo -H -u novnc echo 'source $HOME/.user_profile' >> /home/novnc/.bashrc

# create base profile
sudo -H -u novnc touch /home/novnc/.user_profile

sudo -H -u novnc mkdir -p /home/novnc/.sway

sudo rc-update add dbus;
sudo rc-update add elogind;

set +x

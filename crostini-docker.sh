#!/bin/bash
### 颜色样式 ###
function _colors() {
black=$(tput setaf 0)   ; red=$(tput setaf 1)          ; green=$(tput setaf 2)   ; yellow=$(tput setaf 3);  bold=$(tput bold)
blue=$(tput setaf 4)    ; magenta=$(tput setaf 5)      ; cyan=$(tput setaf 6)    ; white=$(tput setaf 7) ;  normal=$(tput sgr0)
on_black=$(tput setab 0); on_red=$(tput setab 1)       ; on_green=$(tput setab 2); on_yellow=$(tput setab 3)
on_blue=$(tput setab 4) ; on_magenta=$(tput setab 5)   ; on_cyan=$(tput setab 6) ; on_white=$(tput setab 7)
shanshuo=$(tput blink)  ; wuguangbiao=$(tput civis)    ; guangbiao=$(tput cnorm) ; jiacu=${normal}${bold}
underline=$(tput smul)  ; reset_underline=$(tput rmul) ; dim=$(tput dim)
standout=$(tput smso)   ; reset_standout=$(tput rmso)  ; title=${standout}
baihuangse=${white}${on_yellow}; bailanse=${white}${on_blue} ; bailvse=${white}${on_green}
baiqingse=${white}${on_cyan}   ; baihongse=${white}${on_red} ; baizise=${white}${on_magenta}
heibaise=${black}${on_white}   ; heihuangse=${on_yellow}${black}
CW="${bold}${baihongse} ERROR ${jiacu}";ZY="${baihongse}${bold} ATTENTION ${jiacu}";JG="${baihongse}${bold} WARNING ${jiacu}" ; }
_colors
# --------------------------------------------------------------------------------
apt-get update && apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update && apt-get install docker-ce docker-ce-cli containerd.io -y
docker run -d --name portainer_data -p 8000:8000 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --restart always portainer/portainer

mkdir /root/tmp

touch /root/tmp/fbrun && chmod +x /root/tmp/fbrun
cat > /root/tmp/fbrun <<EOF
#!/bin/bash
IMAGE_NAME=80x86/filebrowser

WEB_PORT=10000
FB_AUTH_SERVER_ADDR="127.0.0.1"
docker run -itd \\
        -e PUID=\$UID \\
        -e PGID=\$GID \\
        -e WEB_PORT=\$WEB_PORT \\
        -e FB_AUTH_SERVER_ADDR=\$FB_AUTH_SERVER_ADDR \\
        -p \$WEB_PORT:\$WEB_PORT \\
        -v /root/docker/fb/config:/config \\
        -v /:/myfiles \\
        --mount type=tmpfs,destination=/tmp \\
        --restart always \\
        \${IMAGE_NAME}:2.9.1-amd64
EOF
/root/tmp/fbrun
rm -r /root/tmp

IFCONFIG=$(ifconfig eth0|grep inet|grep -v inet6|awk '{print $2}')
echo -e "${bold}${yellow}以下网址可以在chromeos的浏览器中直接打开${jiacu}"
echo -e "\n${bold}${green}portainer 已安装完成！${jiacu}"
echo -e "${bold}${green}之后可在webui中设置webui密码${jiacu}"
echo -e "网址  ${cyan}http://"$IFCONFIG":9000${jiacu}"


echo -e "\n${bold}${green}filebrowser 已安装完成！${jiacu}"
echo -e "网址  ${cyan}http://"$IFCONFIG":10000${jiacu}"
echo -e "账号  ${cyan}admin${jiacu}"
echo -e "密码  ${cyan}adminadmin${jiacu}"


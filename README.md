# ReadMe

四个脚本都可以在 CentOS7 上完美运行.  
运行顺序是依次 ss.sh -> kcptun.sh -> xray.sh -> tcp.sh

```bash
sudo su
cd ~/
apt install git -y
git clone https://github.com/justin-himself/breakwall-vps-scripts.git ./scripts
sudo rm -r ./scripts/.git ./scripts/README.md
chmod +x ./scripts/*
cd ./scripts/
```

warp (menu.sh) 使用: https://github.com/fscarmen/warp/blob/main/README.md

hysteria:

```bash
su - root #Change to root
bash <(curl -fsSL https://git.io/hysteria.sh)
```

speedtest:

```bash
sudo apt-get install curl
curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
sudo apt-get install speedtest
```

# ReadMe

四个脚本都可以在 CentOS7 上完美运行.  
运行顺序是依次 ss.sh -> kcptun.sh -> xray.sh -> tcp.sh

```bash
sudo su
cd ~/
yum install git -y
git clone https://github.com/justin-himself/breakwall-vps-scripts.git ./scripts
sudo rm -r ./scripts/.git ./scripts/README.txt
chmod +x ./scripts/*
```

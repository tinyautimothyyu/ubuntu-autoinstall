# ubuntu-autoinstall

#### Work as root
```sh
sudo -i
```

#### apt update and upgrade
```sh
apt update && apt -y upgrade
```

#### install git
```sh
apt install -y git
```

#### Make git directory
```sh
mkdir git
cd git
```

#### Git clone this repo
```sh
git clone https://github.com/tinyautimothyyu/ubuntu-autoinstall.git
```

#### Run the autoinstall script part 1
```sh
cd ~
bash ~root/git/ubuntu-autoinstall/autoinstall-1.sh -h <hostname>
```
Example of a hostname: mpmt-test02.triumf.ca
The script automatically set the root password to be 'root'. Please use command `passwd` to change the root password after the autoinstall. The script will also prompt an UI session in the terminal, asking you to set up the postfix. Select "satellite system", enter full hostname "<hostname>", enter "smtp.triumf.ca". 


#### Run the autoinstall script part 2 after reboot if everything goes fine
```sh
bash ~root/git/ubuntu-autoinstall/autoinstall-2.sh
```

#### Install lightdm and configure it as the default display manager
There were some issues with lightdm installation during the autoinstall, so I decided to take out it out and install it separately.
```sh
bash ~root/git/ubuntu-autoinstall/scripts/lightdm.sh 2>&1 | tee ~root/debug_files/debug_lightdm.txt
```

#### Restart the machine
```sh
reboot
```

#### Remark
If there is any issues with the autoinstallation, please check the files in `~root/debug_files`.


# ubuntu-autoinstall

#### Work as root
```sh
sudo -i
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
bash ~root/git/ubuntu-autoinstall/autoinstall-1.sh -h <hostname> 2>&1 | tee debug_1.txt
```

#### Run the autoinstall script part 2 after reboot if everything goes fine
```sh
bash ~root/git/ubuntu-autoinstall/autoinstall-2.sh 2>&1 | tee debug_2.txt
```


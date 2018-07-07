# INSTALL(XUbuntu 14.04 LTS 32bit)

### 修改源后执行
    $ sudo apt-get update
    $ sudo apt-get upgrad

### Install necessary
    $ sudo apt-get install open-vm-tools            自动适应窗口大小
    $ sudo apt-get install open-vm-tools-desktop    虚拟机与主机之间复制粘贴

    $ sudo apt-get install openssh-server
    $ sudo apt-get install git    

### 编译内核必须
    $ sudo apt-get install libncurses-dev
    $ sudo apt-get install libssl-dev

    $ sudo apt install cgroup-tools

### 删除旧内核
    $ dpkg --get-selections | grep linux-
    $ sudo apt autoremove --purge   linux-image-xxx linux-headers-xxx   自动删除
    $ sudo update-grub2

### 删除无用软件包
    $ sudo apt-get remove thunderbird simple-scan gnome-mines transmission-common gnome-sudoku


### 显示grub菜单
    /etc/default/grub
    GRUB_HIDDEN_TIMEOUT=5
    GRUB_HIDDEN_TIMEOUT_QUIET=false
    $ sudo grub-update



# FAQ
## 1. piix4_smbus xxxx:xx:xx: smbus controller not enabled!
	/etc/modprobe.d/blacklist.conf   
    ___________________
	blacklist i2c_piix4      
    ___________________
	shell> reboot    

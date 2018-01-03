# INSTALL(archlinux-2017.09.01-x86_64.iso)

### 0. USB flash? dd bs=4M if=*.iso of=/dev/sd* && sync
    shell) timedatectl set-ntp true

### 1. Disk 
    shell) cfdisk
		MBR方式选择dos
		GPT方式选择gdt
	shell) mkfs.* /dev/sd*
	shell) mkswap /dev/sd* && swapon /dev/sd*

### 2. Mount
	shell) lsblk /dev/sd*
	shell) mount /dev/sd* /mnt
	shell) mkdir /mnt/data && mount /dev/sd* /mnt/data

### 3. Install
	# pacman -Syy
	# pacstrap /mnt base base-devel

4. genfstab -U -p /mnt >> /mnt/etc/fstab

5. arch-chroot /mnt /bin/bash

6. Time
    # ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  
7. Locale
	1) /etc/locale.gen
	_____________________
	en_US.UTF-8 UTF-8

	zh_CN.GB18030 GB18030
	zh_CN.GBK GBK
	zh_CN.UTF-8 UTF-8
	zh_CN GB2312
	_____________________

	2) # locale-gen

	
8. mkinitcpio -p linux

9. passwd root

10. Install bootloader
	# pacman -S grub os-prober
	# grub-install --recheck /dev/sda
	# grub-mkconfig -o /boot/grub/grub.cfg

11. Network
	1) hostname
	# echo Arch > /etc/hostname

	2) dhcp
	# systemctl enable dhcpcd.service   # 开机自动连接

	因为默认开启了DHCP服务, 所以写好的DNS将会在下次重启时消失.
	这是因为dhcpd服务刷新了这个文件.
	只需配置/etc/dhcpcd.conf 在末尾加上一句nohook resolv.conf即可,
	dhcpd就不会刷新resolv.conf文件.

12. umount 
	# exit
	# umount -R /mnt

13. reboot



INSTALL & CONFIG : PART2
========================

0.  pacman
	pacman -Syu	# 同步源, 并更新系统
	pacman -Sy	# 仅同步源 
	pacman -Su	# 更新系统
	pacman -Su --ignore foo	# 升级时不升级包foo 

	pacman -S  pkg	# 从本地数据库中得到pkg的信息, 下载安装pkg包 
	pacman -Sy pkg	# 和源同步后安装名为pkg的包 
	pacman -Sf pkg	# 强制安装包pkg 

	pacman -Ss pkg 	# 搜索有关pkg信息的包 
	pacman -Si pkg	# 从数据库中搜索包pkg的信息 
	pacman -Qi pkg	# 列出已安装的包pkg的详细信息 

	pacman -R   pkg	# 删除pkg包 
	pacman -Rc  pkg # 删除pkg包和依赖pkg的包 
	pacman -Rsc pkg	# 删除pkg包和pkg依赖的包 

	pacman -Sc	# 清理/var/cache/pacman/pkg目录下的旧包 
	pacman -Scc	# 清除所有下载的包和数据库 

	pacman -U  pkg	# 安装下载的abs包, 或新编译的pkg包
	pacman -Sd pkg  # 忽略依赖性问题, 安装包pkg 

1. piix4_smbus ****host smbus controller not enabled
	# lsmod | grep i2c_piix4 
	i2c_piix4              12574  0 
	/etc/modprobe.d/blacklist.conf 
	blacklist i2c_piix4 
	# reboot 

2. Users
	1) # useradd -m -s /bin/bash artist
	   # passwd artist

	2) pacman -S sudo

	3) sudo: /etc/sudoers
	__________________________________________
	## Allow root to run any commands anywhere
	root	ALL=(ALL)	ALL
	artist	ALL=(ALL)	NOPASSWD:ALL
	__________________________________________

	4) # userdel -r artist

3. create ~/.bash_profile

	____________________________________________________________________________________________________
	# PATH
	PATH=$PATH:/usr/local/sbin:/usr/local/bin
	export PATH

	PS1='[\u@\h \W]\$ '
	PS1='\[\033[0;32m\]\A \[\033[0;31m\]\u\[\033[0;34m\] \[\033[00;36m\]\W\[\033[0;33m\] \$\[\033[0m\] '
 
	eval "`dircolors -b`"
	alias ls="ls --color=auto"
	alias dir="dir --color=auto"
	alias vdir="vdir --color=auto"
	alias grep="grep --color=auto"
	alias fgrep="grep --color=auto"
	alias egrep="egrep --color=auto"
	alias ll="ls -l"
	____________________________________________________________________________________________________

4. X-window

    0) display driver
	# lspci | grep VGA (查看显卡型号)
	# pacman -S xf86-video-nouveau(开源的, 适合大多数人)
	or:
	NVIDIA:	# pacman -S nvidia
	ATI: 	# pacman -S xf86-video-ati
	or: 
	vmware: # pacman -S xf86-video-vmware

	1) 安装xorg组 
	# pacman -S xorg 
    # pacman -S xorg-xinit xterm

	3) 安装xfce4 
	# pacman -S xfce4

    4) 安装LightDM登录管理器
    # pacman -S lightdm lightdm-gtk-greeter
    # systemctl start lightdm.service
    # systemctl enable lightdm.service
	
	5) 安装open-vm-tools使自动调整屏幕分辨率
	# pacman -S open-vm-tools

    6) 安装中文字体
    # pacman -S wqy-microhei wqy-zenhei wqy-bitmapfont wqy-microhei-lite

5. qemu
    1) pacman -S python2
    2) ./configure --python=/usr/bin/python2.7
    3) make
    4) make install

6. clean /var/cache/pacman/pkg/*.pkg.tar.xz
	# pacman -Scc
	# pacman -Sc


INSTALL & CONFIG : PART3
========================

0. Grub
	0) # grub
	1) grub> find /boot/grub/stage1
	2) grub> root (hd0, X)
	3) grub> setup(hd0) # Install the grub to MBR.

1. ssh
	# pacman -S openssh
	# systemctl start sshd
	# systemctl enable sshd.service # 开机启动
	
	/etc/ssh/sshd_config
	PermitRootLogin yes	# 允许root登陆

2. lrzsz
	# pacman -S lrzsz
	sz: 将选定的文件发送(send)到本地机器
	rz: 运行该命令会弹出一个文件选择窗口, 从本地选择文件上传到Linux服务器.

3. ncftp-client:
	1) tar jxvf ncftp-3.2.5-src.tar.bz2
	2) ./configure
	3) make
	4) make install
	5) Eg: 将本地local/目录内的所有文件和目录, 上传到FTP服务器的Ftp/目录内(如果不存在Ftp/目录则自动创建).
          /usr/local/ncftp/bin/ncftpput -u FTP帐号 -p FTP密码 -P FTP端口 -m -R servip Ftp/ local/*

4. kermit
    kermrc
	_____________________
	set line /dev/ttyS0
	set speed 9600
	set carrier-watch off
	set handshake none
	set flow-control none
	robust
	set file type bin
	set file name lit
	set rec pack 1000
	set send pack 1000
	set window 5
	_____________________



COMPILE REDBOOT
===============

	1) cp libtcl.so /usr/lib
	2) cp libstdc++-libc6.1-1.so.2 /usr/lib
	3) vi ~/.bash_profile
		export PATH=${PATH}:/home/src/bootloader/x86/i386-elf/bin
		export _POSIX2_VERSION=199209

# INSTALL(CentOS 7)

### Install necessary
yum install vim  
yum install git   
yum install wget  
yum install gcc   
yum install gcc-c++   
yum install patch   
yum install bc   
yum install ncurses-devel   

yum install glibc-devel.i686   
yum install glibc-static.i686   
yum install libgcc.i686 (-m32 编译, 运行32位程序)   

yum install strace(跟踪系统调用)   
yum install ltrace(跟踪库函数调用)   

### Install qemu
git clone git://git.qemu-project.org/qemu.git

yum install zlib-devel   
yum install glib2-devel   
yum install pixman-devel   
yum install SDL   
yum install SDL-devel   
cd qemu; git submodule update --init dtc   

./configure
make 
make install

### lspci
1) yum whatprovides */lspci	查找lspci是通过哪个安装包来提供的   
2) yum install pciutils 

### Install Xfce Desktop
yum install epel-release    
yum groupinstall "X Window system"  
yum groupinstall Xfce   

yum install cjkuni-uming-fonts 中文字体 

### Startx
systemctl isolate graphical.target



# INSTALL(XUbuntu 16.04 LTS 32bit)

### Install necessary
sudo apt-get install vim    
sudo apt-get install git    
sudo apt-get install ncurses-devel  



# Config
## bash_profile
终端配置文件

## vimrc
vim配置文件

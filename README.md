# Install(CentOS 7)

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



# Install(XUbuntu 16.04 LTS 32bit)

### Install necessary
sudo apt-get install vim    
sudo apt-get install git    
sudo apt-get install ncurses-devel  



# Config
## bash_profile
终端配置文件

## vimrc
vim配置文件

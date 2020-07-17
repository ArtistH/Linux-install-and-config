## 修改源后执行
    $ sudo apt-get update
    $ sudo apt-get upgrade

## 清空不必要的安装缓存
    $ sudo apt-get autoclean
    $ sudo apt-get autoremove

## Install necessary
    $ sudo apt-get install open-vm-tools            自动适应窗口大小
    $ sudo apt-get install open-vm-tools-desktop    虚拟机与主机之间复制粘贴

    $ sudo apt-get install openssh-server
    $ sudo apt-get install git    

## 编译内核必须
    $ sudo apt-get install libncurses-dev
    $ sudo apt-get install libssl-dev

    $ sudo apt install cgroup-tools

## 删除旧内核
    $ dpkg --get-selections | grep linux-
    $ sudo apt-get purge linux-headers-
    $ sudo apt-get purge linux-modules-

## 显示grub菜单
    /etc/default/grub
    GRUB_HIDDEN_TIMEOUT=5
    GRUB_HIDDEN_TIMEOUT_QUIET=false
    $ sudo update-grub

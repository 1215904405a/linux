rm -rf /data/node //删除文件夹(-r递归 )

rm -f /data/node.js //删除文件

exit 退出

ls -al 显示所有文件（包括隐藏）

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

echo $PATH //echo命令, 在shell编程中极为常用, 在终端下打印变量value

tail -f 2017-11-16.log //

源文件夹重命名：mv ./dist ./dist2

复制：cp ./dist/* ./dist2

(1) 如果你只想看文件的前5行，可以使用head命令，如： 

head -5 /etc/passwd 

(2) 如果你想查看文件的后10行，可以使用tail命令，如：

tail -10 /etc/passwd 或 tail -n 10 /etc/passwd 

tail -f /var/log/messages 

参数-f使tail不停地去读最新的内容，这样有实时监视的效果 用Ctrl＋c来终止！ 

(3) 查看文件中间一段，你可以使用sed命令，如： 

sed -n '5,10p' /etc/passwd 

这样你就可以只查看文件的第5行到第10行。

下载：wget url

(4) sudo chown -R yong /data/logs 给指定用户和目录加管理员权限

配环境变量

(1)vim /etc/profile //配置path(node安装位置路径)

source /etc/profile //使配置生效

(2)软链接

查找文件夹下所有文件包含‘devb.qdingnet.com’  sudo grep -r devb.qdingnet.com ./

查找文件夹‘nginx’的文件夹  find / -name nginx


chmod是Linux下设置文件权限的命令，后面的数字表示不同用户或用户组的权限。

一般是三个数字：
第一个数字表示文件所有者的权限
第二个数字表示与文件所有者同属一个用户组的其他用户的权限
第三个数字表示其它用户组的权限。
权限分为三种：读（r=4），写（w=2），执行（x=1） 。 综合起来还有可读可执行（rx=5=4+1）、可读可写（rw=6=4+2）、可读可写可执行(rwx=7=4+2+1)。
所以，chmod 755 设置用户的权限为：
1.文件所有者可读可写可执行                                   --7
2.与文件所有者同属一个用户组的其他用户可读可执行 --5 
3.其它用户组可读可执行                                        --5

1.升级NODE
yum install -y wget
//下载
wget https://nodejs.org/dist/v8.9.1/node-v8.9.1-linux-x64.tar.xz 
//解压
tar xf node-v8.9.1-linux-x64.tar.xz 
//node 安装的位置（当前可用）
which node 
mv /root/node-v8.9.1-linux-x64 ./node //剪切文件到某个位置
cp -r /data/node-v8.9.1-linux-x64 ./node|/usr/local/node  //复制/data/node-v8.9.1-linux-x64下面的文件到/usr/local/node下面

2.清理旧缓存(缓存目录)
rm -rf ~/.npm | npm cache clean

3.配置NPM仓库
vim ~/.npmrc  i(编辑) esc(退出编辑) wq!(保存退出) q(退出)
registry=https://registry.npm.taobao.org

4.重新安装全局依赖
npm install yarn pm2 grunt-cli -g

5.创建新的日志目录
mkdir /data/logs/mobile-qd/

6.更新代码并重启
cd mobile-qd && git pull && node server.js

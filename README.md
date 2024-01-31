#### 说明 
* main分支为通用插件(即lua写的插件，版本通用)，囊括了大部分日常使用的插件
* js分支内的插件必须在高于18.06的版本上使用
* fw4分支是必须在openwrt的snapshot或者高于21.02的release版本可以使用
* mini分支为我个人使用的插件
* 主题插件我会单独放

#### 使用
一键命令
```yaml
sed -i '$a src-git kenzo https://github.com/r1172464137/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/r1172464137/small' feeds.conf.default
git pull
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
```
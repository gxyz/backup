# backup

## .vimrc

使用方法

```
cp vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

然后进入 vim 末行模式输入 PlugInstall 安装插件

## nvim

文件为`.config/nvim/init.vim`:

```
#curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#chmod u+x nvim.appimage
#./nvim.appimage

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt install neovim

cp init.vim .config/nvim/init.vim

sudo apt install python3-pip
sudo python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
sudo apt-get install python-dev python-pip python3-dev python3-pip
pip3 install --user pynvim
pip install --user pynvim
cnpm install -g neovim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \\n    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install clang


```

设置:


```
// .zshrc
if type nvim > /dev/null 2>&1; then
      alias vim='nvim'
fi<Paste>
```

## 安装sublime-text

```
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

```

## 安装ss

```
sudo apt install shadowsocks-libev
```

## 安装nvm

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
```

设置nvm代理:

```
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
nvm install 10.0
```

安装cnpm:

```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

## 安装rust

设置源:

```
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
```

安装: 

```
curl https://sh.rustup.rs -sSf | sh
rustup component add rls rust-analysis rust-src
```



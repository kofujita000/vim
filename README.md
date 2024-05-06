# vim設定

**vimのインストール**
- **Linux系**
```bash
cd ~/
git clone https://github.com/vim/vim.git
cd vim
./configure --enable-python3interp
make
sudo make install
cd ..
rm -rf vim
```
> ホームディレクトリにインストールしたい場合は次の設定を含める
> ```bash
> ./configure --prefix=${HOME}/local
> ```

<br>


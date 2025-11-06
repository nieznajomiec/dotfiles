```
Если были настройки:
rm -rf ~/.local/share/nvim
Скопировать файлы и потом запускать
```

```
rsync -a . ~/.config/nvim/
nvim --headless "+Lazy! sync" +qa
```

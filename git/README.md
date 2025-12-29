```
# copy
export org="git_hostname"
cp .gitconfig ~/ && cp org.template ~/.config/git-credential-pass/.${org}.template && cp ~/.gitconfig-work ~/.config/git-credential-pass/.gitconfig-work  

# gpg
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export ID

# pass
pass init ${org}
pass insert ${org}/username
```

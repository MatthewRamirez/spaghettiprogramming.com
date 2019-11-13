# README

# Prerequisite
In all environments install Node and Yarn.

Install Node on Debian/Ubuntu:
```bash
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Install Yarn on Debian/Ubuntu:
```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
```

## Bootstrap
In the development environment, one can download the bootstrap files from getbootstrap.com manually and place them in `app/assets/stylesheets/vendor`. Then manage dependencies via yarn:
```bash
yarn add jquery popper.js
```

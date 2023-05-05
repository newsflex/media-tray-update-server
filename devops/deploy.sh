
# run like ./devops/deploy.sh "gh_xxxxxxxxx"
# where first param is github token created in github for getting/downloading media tray releases
# so that token needs access to our private media tray repo

GITHUB_TOKEN=$1
PORT=3636

# open port on server
sudo ufw allow $PORT

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

nvm use default

pm2 stop media-tray-update-server

DIRECTORY="media-tray-update-server"

# keep previous copy in case we have to fall back
if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
  rm -rf media-tray-update-server-prev
  mv $DIRECTORY media-tray-update-server-prev
fi

# assumes prev deploy task has unziped into folder called "media-tray-update-server-prep"
mv media-tray-update-server-prep media-tray-update-server

# add         "DEBUG":"nuts*" to env if there are issues

rm ./media-tray.json
tee -a ./media-tray.json << END
{
  "apps": [
    {
      "name": "media-tray-update-server",
      "script": "./bin/web.js",
      "interpreter": "node@16.4.0",
      "args": [],
      "watch": false,
      "ignore_watch": ["*.log"],
      "node_args": "",
      "max_memory_restart": "800M",
      "instances": 1,
      "instance_var": "INSTANCE_ID",
      "exec_mode": "fork",
      "cwd": "/home/devadmin/media-tray-update-server",
      "max_restarts": 10,
      "restart_delay": 500,
      "env": {
        "NODE_PORT": $PORT,
        "PORT": $PORT,
        "GITHUB_TOKEN": "$GITHUB_TOKEN",
        "GITHUB_REPO": "newsflex/media-tray",
        "TRUST_PROXY": "loopback",
      }
    }
  ]
}
END

pm2 start ./media-tray.json
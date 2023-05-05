# Nexus Media Tray Update Server for Auto Updating

To run locally:

- copy start-template.sh to start.sh
- update start.sh with GITHUB_TOKEN to be able to fetch private repo releases
- make sure start.sh is in .gitignore. NEVER commit secrets in start.sh
- chmod +x ./start.sh
- run `./start.sh` from now on to run the project


Originaly forked from: nuts-electron-auto-updater

Nuts is a simple (and smart) application to serve desktop-application releases. Called Nuts because it uses windows.squirrel auto updates.

![Schema](./docs/schema.png)

It uses GitHub as a backend to store assets, and it can easily be deployed to Heroku as a stateless service. It supports GitHub private repositories (useful to store releases of a closed-source application available on GitHub).

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

#### Features

- :sparkles: Store assets on GitHub releases
- :sparkles: Proxy releases from private repositories to your users
- :sparkles: Simple but powerful download urls
    - `/download/latest`
    - `/download/latest/:os`
    - `/download/:version`
    - `/download/:version/:os`
    - `/download/channel/:channel`
    - `/download/channel/:channel/:os`
- :sparkles: Support pre-release channels (`beta`, `alpha`, ...)
- :sparkles: Auto-updates with [Squirrel](https://github.com/Squirrel)
    - For Mac using `/update?version=<x.x.x>&platform=osx`
    - For Windows using Squirrel.Windows and Nugets packages
- :sparkles: Private API
- :sparkles: Use it as a middleware: add custom analytics, authentication
- :sparkles: Serve the perfect type of assets: `.zip` for Squirrel.Mac, `.nupkg` for Squirrel.Windows, `.dmg` for Mac users, ...
- :sparkles: Release notes endpoint
    - `/notes/:version`
- :sparkles: Up-to-date releases (GitHub webhooks)
- :sparkles: Atom/RSS feeds for versions/channels

#### Deploy it / Start it

[Follow our guide to deploy Nuts](https://nuts.gitbook.com/deploy.html).


#### Auto-updater / Squirrel

This server provides an endpoint for [Squirrel auto-updater](https://github.com/atom/electron/blob/master/docs/api/auto-updater.md), it supports both [OS X](https://nuts.gitbook.com/update-osx.html) and [Windows](https://nuts.gitbook.com/update-windows.html).

#### Documentation

[Check out the documentation](https://nuts.gitbook.com) for more details.


curl -i http://localhost:8080/update/win32/0.0.6/RELEASES?id=npr-media-tray&localVersion=0.0.6&arch=amd64

curl -i http://10.36.68.36:3636/update/win32/0.0.6


curl -i http://10.36.68.36:3636/update/win32/0.0.6/RELEASES?id=npr-media-tray&localVersion=0.0.6&arch=amd64

ssh devadmin@10.36.68.36

curl -i http://localhost:8080/update/win32/0.0.7/RELEASES?id=npr-media-tray&localVersion=0.0.7&arch=amd64
curl -i http://10.36.68.36:3636/update/win32/0.0.7/RELEASES?id=npr-media-tray&localVersion=0.0.7&arch=amd64


 "GET /update/win32/0.0.7/RELEASES?id=npr-media-tray&localVersion=0.0.7&arch=amd64 HTTP/1.1" 200 161 "-" "-"
0|nuts  | ::ffff:10.36.68.49 - - [22/Feb/2022:19:37:12 +0000] "GET /download/0.0.8/npr-media-tray-0.0.8-full.nupkg HTTP/1.1" 200 127694778 "-" "-"


Really sorry for being late on this.

I'm not sure I understand this PR, Nuts already supports non-stable release channel (we are using it for our application).

'alpha', 'beta', 'unstable', 'rc'

Basically if you publish a tag 1.0.0 and 2.0.0-beta.1:

    /download/latest will download 1.0.0
    /download/channel/beta will download 2.0.0-beta.1

Then if you publish a version 2.0.0-beta.2, the user with version 1.0.0 will not be notified and the user with version 2.0.0-beta.1 will be notified and updated.

The only issue is when you publish a stable version of 2.0.0 and beta users switch to it, is it what you're trying to solve here?
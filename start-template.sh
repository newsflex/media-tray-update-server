# Set the port for the service
export PORT=8080

# Access token for the GitHub API (requires permissions to access the repository)
# If the repository is public you do not need to provide an access token
# you can also use GITHUB_USERNAME and GITHUB_PASSWORD
export GITHUB_TOKEN=ghp_*********************

# ID for the GitHub repository
export GITHUB_REPO=Newsflex/media-tray

# Authentication for the private API
# not needed if using github token
#export API_USERNAME=***
#export API_PASSWORD=***

# Express's "trust proxy" setting for trusting X-Forwarded-* headers when
# behind a reverse proxy like nginx
# http://expressjs.com/en/guide/behind-proxies.html
export TRUST_PROXY=loopback

export DEBUG=nuts

npm start
# docker-http
Control docker via http

# Install & Run
Clone this repo, run the following:

```sh
pip install -r requirements.txt
flask --app main.py run
```

# Authorization
Generate a random key and save value in a file called `key.txt` in this folder. It must then be passed in the HTTP header `key` in all calls.

# Usage
`/api/server/restart?image=IMAGE_NAME&port=PORT_NUMBER`

This will download the latest version of the given image, stop and delete any existing containers, then start a new container with the latest image, publishing the container at PORT_NUMBER, mapped to 8080 on the container.


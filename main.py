from flask import Flask, request
from subprocess import check_call
from auth import middleware

app = Flask(__name__)
app.wsgi_app = middleware(app.wsgi_app)

@app.route('/api/server')
def hello_world():
    return 'Hello World!'


@app.route('/api/server/start')
def start():
    check_call(['./manage-container.sh', 'start'])
    return 'Started.'


@app.route('/api/server/stop')
def stop():
    check_call(['./manage-container.sh', 'stop'])
    return 'stopped.'


@app.route('/api/server/restart')
def restart():
    image = request.args.get("image")
    port = request.args.get("port")
    if image is None or port is None:
        return 'Missing query string param image or port', 400
    check_call(['./manage-container.sh', 'restart', image, port])
    return 'restarted.'




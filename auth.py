from werkzeug.wrappers import Request, Response, ResponseStream

class middleware():
    '''
    Simple WSGI middleware
    '''

    def __init__(self, app):
        self.app = app
        self.key= open('./key.txt', 'r').read().rstrip()

    def __call__(self, environ, start_response):
        request = Request(environ)
        key_in_request = request.headers.get('key')
        if key_in_request == self.key:
            return self.app(environ, start_response)

        res = Response(u'Authorization failed', mimetype= 'text/plain', status=401)
        return res(environ, start_response)

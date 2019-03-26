from flask import Flask, jsonify, render_template
from os import getenv

app = Flask(__name__)

VERSION = 8
CREDS = {
    'username': getenv('USERNAME'),
    'password': getenv('PASSWORD')
}


@app.route('/api/version')
def api_version():
    # NOTE: this is just to test the creds. Nothing you would do in production!
    data = {
        'message': f'Api version: {VERSION}',
        'creds': CREDS
    }
    return jsonify(data)


@app.route('/')
def index():
    return render_template('index.html', version=VERSION)

if __name__ == '__main__':
    app.run(debug=True)

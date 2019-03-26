from flask import Flask, jsonify, render_template
from os import getenv

app = Flask(__name__)

NAME = 'Sami App 2'
VERSION = 2
CREDS = {
    'username': getenv('USERNAME'),
    'password': getenv('PASSWORD')
}


@app.route('/')
def root():
    return jsonify({'message': f'Root of {NAME}'})


@app.route('/api/version')
def api_version():
    # NOTE: this is just to test the creds. Nothing you would do in production!
    data = {
        'name': NAME,
        'message': f'Api version: {VERSION}',
        'creds': CREDS
    }
    return jsonify(data)


if __name__ == '__main__':
    app.run(debug=True)

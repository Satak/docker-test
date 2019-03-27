from flask import Flask, jsonify, render_template
from os import getenv
import requests

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


@app.route('/api/data')
def api_data():
    try:
        data = requests.get('http://samiapp3/').json()
        status_code = 200
    except Exception as err:
        data = {'error': str(err)}
        status_code = 500
    return jsonify(data), status_code


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

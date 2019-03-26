from flask import Flask, jsonify, render_template
from os import getenv

app = Flask(__name__)

NAME = 'Sami App 1'
VERSION = 1


@app.route('/')
def index():
    return render_template('index.html', version=VERSION, name=NAME)


if __name__ == '__main__':
    app.run(debug=True)

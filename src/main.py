from flask import Flask, jsonify, render_template

app = Flask(__name__)

VERSION = 7


@app.route('/api/version')
def api_version():
    data = {
        'message': f'Api version: {VERSION}'
    }
    return jsonify(data)


@app.route('/')
def index():
    return render_template('index.html', version=VERSION)

if __name__ == '__main__':
    app.run(debug=True)

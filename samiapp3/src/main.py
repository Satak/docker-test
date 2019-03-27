from flask import Flask, jsonify

app = Flask(__name__)

NAME = 'Sami App 3'
VERSION = 2


@app.route('/')
def root():
    return jsonify(
        {
            'message': f'Root of {NAME}',
            'version': VERSION
        }
    )


if __name__ == '__main__':
    app.run(debug=True)

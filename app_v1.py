from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_user():
       return 'Hello, this is the default path!'

@app.route('/v1')
def hello_org():
       return 'Hello, this is the version 1.0 path!'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port= 80)

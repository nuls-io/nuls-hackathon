from flask import Flask, render_template
from flask_cors import *
import urllib3, urllib

app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('index.html')


@app.route('/add')
def add():
    return render_template('addMessage.html')

@app.route('/search')
def search():
    return render_template('self.html')


@app.route('/self')
def self():
    return render_template('self.html')

@app.route('/test')
def test():
    return render_template('test.html')

if __name__ == '__main__':
    CORS(app, supports_credentials=True)  # 设置跨域
    app.run()

# app.py
from flask import Flask, render_template
from models import db, User

app = Flask(__name__)
app.config.from_pyfile('config.py')
db.init_app(app)

@app.route('/')
def index():
    users = User.query.all()
    return render_template('index.html', users=users)

if __name__ == '__main__':
    app.run(debug=True)
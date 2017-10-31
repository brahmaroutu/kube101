from flask import Flask
from redis import Redis
import os
import platform
app = Flask(__name__)
redis = Redis(host=os.environ.get('REDIS_HOST', 'redis'), port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    return 'Hello Container World from %s! I have been seen %s times.\n' %  ( platform.node(), redis.get('hits') )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
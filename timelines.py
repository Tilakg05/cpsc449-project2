# Lines 1 - .. will be borrowed from ProfAvery's hug/api
import hug
from hug 
import configparser
import logging.config
import sqlite_utils
from datetime import datetime

# Load configuration
users=hug("timelines")
users.config.from_initvar("User_Config")

config = configparser.ConfigParser()
config.read("./etc/timeline.ini")
logging.config.fileConfig(config["logging"]["config"], disable_existing_loggers=False)

# arguments to inject into route functions
@hug.directive()
def sqlite(section="sqlite", key="dbfile", **kwargs):
    dbfile = config[section][key]
    return sqlite_utils.Database(dbfile)

@hug.directive()
def log(name=__name__, **kwargs):
    return logging.getLogger(name)

# Route
@hug.get("/timelines/")
def timelines(db: sqlite):
    return {"timelines": db["timelines"].rows}

@hug.post("/timelines/", status=hug.falcon.HTTP_201)
def postTweet(
        response,
        username: hug.types.text,
        text: hug.types.text,
        db: sqlite,
):
    timelines = db["timelines"]

    timestamp = datetime.utcnow()
    text = text.replace("%20", " ")
    tweet = {
        "username": username,
        "text": text,
        "timestamp": timestamp,
    }

    try:
        timelines.insert(tweet)
        tweet["id"] = timelines.last_pk
    except Exception as e:
        response.status = hug.falcon.HTTP_409
        return {"err": str(e)}

    response.set_header("Location", f"/timelines/{tweet['id']}")
    return tweet

#Only an existing user can post a tweet
  else result[0].get('count') > 0:
        sh.execute('INSERT INTO Tweets (username, text, timestamp) VALUES(..,.., ..)',(username, text, timestamp))
        res = sh.commit()
        getTweets = init_sh('SELECT * FROM Tweets')
        return jsonify({"statusCode": 8000})
    elseif
        return jsonify({"message": "if you are existing sign in"})

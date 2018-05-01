import requests

BASE_URL = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/"

def post_like(userID, trackID, liked):
    url = ''.join([BASE_URL, "addLiked"])
    params = {
            "idUser": userID,
            "SongID": trackID,
            "liked": liked
            }
    r = requests.post(url, params=params)

import requests

def get_track(track_id, token):
    url = "".join(["https://api.spotify.com/v1/tracks/", track_id])
    headers = {"Authorization": "Bearer " + token}
    r = requests.get(url, headers=headers)
    return r.json()


import requests

SPOTIFY_URL = "https://api.spotify.com/v1/"

def get_several_tracks(track_ids, token):
    url = ''.join([SPOTIFY_URL, "tracks"])
    params = {"ids": track_ids}
    headers = {"Authorization": "Bearer " + token}
    r = requests.get(url, params=params, headers=headers)
    return r.json()

def get_several_tracks_features(track_ids, token):
    url = ''.join([SPOTIFY_URL, "audio-features"])
    params = {"ids": track_ids}
    headers = {"Authorization": "Bearer " + token}
    r = requests.get(url, params=params, headers=headers)
    return r.json()

def get_spotify_recs(limit, seed_artists, seed_genres, token):
    url = ''.join([SPOTIFY_URL, "recommendations"])
    params = {
            "limit": limit,
            "seed_artists": seed_artists,
            "seed_genres": seed_genres
            }
    headers = {"Authorization": "Bearer " + token}
    r = requests.get(url, params=params, headers=headers)
    return r.json()


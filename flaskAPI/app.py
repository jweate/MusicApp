from flask import abort, Flask, jsonify, make_response, request
from spotify_controller.spotify_controller import get_several_tracks
from recommender.recommender import get_recs, get_mock_recs
import requests

application = Flask(__name__)
#application.debug = True
application.config['JSONIFY_PRETTYPRINT_REGULAR'] = True

@application.route('/')
def api_root():
    return 'Welcome!'

@application.route('/recs')
def api_recs():
    access_token = request.args.get('access_token')
    user_id = request.args.get('user_id')
    if not access_token:
        abort(make_response(jsonify(message="missing access_token parameter"), 400))
    if not user_id:
        abort(make_response(jsonify(message="missing user_id parameter"), 400))
    recs = get_recs(user_id)
    #recs = get_mock_recs()
    tracks = []
    track_ids = ','.join(recs)
    resp = get_several_tracks(track_ids, access_token)

    if resp.status_code == requests.codes.unauthorized:
        abort(make_response(jsonify(resp.json()), resp.status_code))

    track_json = resp.json()
    for track in track_json['tracks']:
        artists = []
        for artist in track['artists']:
            artists.append(artist['name'])
        tracks.append({'id': track['id'],
            'name': track['name'],
            'duration_ms': track['duration_ms'],
            'artists': artists,
            'album': track['album']['name'],
            'albumArtUrl': track['album']['images'][1]['url']
            })
    return jsonify(tracks)

if __name__ == "__main__":
    application.run()

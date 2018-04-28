from flask import Flask, jsonify, request
from spotify_controller.spotify_controller import get_track
from recommender.recommender import get_recs, get_mock_recs

application = Flask(__name__)
#application.debug = True
application.config['JSONIFY_PRETTYPRINT_REGULAR'] = True

@application.route('/')
def api_root():
    return 'Welcome!'

@application.route('/recs')
def api_recs():
    token = request.args.get('access_token')
    #recs = get_recs()
    recs = get_mock_recs()
    tracks = []
    print 'hello'
    for item in recs:
        resp = get_track(item, token)
        artists = []
        for artist in resp['artists']:
            artists.append(artist['name'])
        tracks.append({'id': resp['id'],
            'name': resp['name'],
            'duration_ms': resp['duration_ms'],
            'artists': artists,
            'album': resp['album']['name'],
            'albumArtUrl': resp['album']['images'][1]['url']
            })
    return jsonify(tracks)

if __name__ == "__main__":
    application.run()

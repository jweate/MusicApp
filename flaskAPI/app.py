from flask import abort, Flask, jsonify, make_response, request
from spotify_controller.spotify_controller import *
from spring_controller.spring_controller import *
from recommender.recommender import *
import requests

application = Flask(__name__)
application.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
#application.debug = True

@application.route('/', defaults={'path': ''})
@application.route('/<path:path>')
def catch_all(path):
    abort(make_response(jsonify(message="Not found"), 404))

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
    track_ids = ','.join(recs)
    resp = get_several_tracks(track_ids, access_token)
    if resp.status_code == requests.codes.unauthorized:
        abort(make_response(jsonify(resp.json()), resp.status_code))

    track_json = resp.json()
    new_conn_list = get_new_connections(user_id, get_similar_users(user_id)) 

    tracks = []
    for track in track_json['tracks']:
        artists = []
        for artist in track['artists']:
            artists.append(artist['name'])

        curr_track_id = track['id']
        new_connection = ""
        for conn in new_conn_list:
            if has_liked(conn, curr_track_id) == 1:
                new_connection = conn
                break

        if new_connection:
            new_conn_list.remove(new_connection)

        tracks.append({'id': curr_track_id,
            'title': track['name'],
            'duration_ms': track['duration_ms'],
            'artists': artists,
            'album': track['album']['name'],
            'artworkURL': track['album']['images'][1]['url'],
            'new_connection': new_connection
            })
    return jsonify(tracks)

if __name__ == "__main__":
    application.run()

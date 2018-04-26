from flask import Flask, jsonify, request
from recommender.mockrecommender import get_recs
from spotify_controller.spt_controller import get_track
#import graphlab as gl
#from recommender.glrec.recommender import suggest_tracks


application = Flask(__name__)

@application.route('/')
def api_root():
    return 'Welcome!'

@application.route('/recs')
def api_recs():
    recs = get_recs()
    tracks = []
    token = request.args.get('access_token')
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

#@application_route('/graphlab')
#def api_graphlab():
#    gl_text = suggest_tracks()
#    return gl_text

if __name__ == "__main__":
    application.run()

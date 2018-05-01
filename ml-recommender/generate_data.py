import csv, glob, json, os, sys
import random
import datetime
from spotify_controller.spotify_controller import get_spotify_recs, get_several_tracks_features
from spring_controller.spring_controller import post_like

if len(sys.argv) != 2:
    print "ERROR: Missing args\nUsage: python convert.py accessToken"
else:
    curr_path = os.path.dirname(os.path.abspath(__file__))
    data_dir = 'dataset'
    unformatted_data_files = os.path.join(data_dir, 'unformatted-data/*.json')
    output_dir = os.path.join(curr_path, data_dir)
    access_token = sys.argv[1]
    unique_tracks = set()
    users = ["j.park21", "12149981331", "user0", "user1", "user2", "user3", "user4", "user5"]

    # converting users' top track info to csv
    with open(os.path.join(data_dir, "rec_tracks.csv"), 'wb') as out, open(os.path.join(data_dir, "rec_tracks_features.csv"), 'wb') as out2:
        print ''.join(["writing to ", os.path.join(output_dir, "rec_tracks.csv")])
        writer = csv.writer(out, delimiter=',')
        writer.writerow(["trackID", "artistID", "albumID"])

        limit = "100"

        # Young Thug
        seed_artists = "50co4Is1HCEo8bhOyUWKpn"
        track_json = get_spotify_recs(limit, seed_artists, "", access_token)
        for track in track_json['tracks']:
            curr_track = track['id']
            curr_album = track['album']['id']
            curr_artist = track['artists'][0]['id']
            if curr_track not in unique_tracks:
                unique_tracks.add(curr_track)
                writer.writerow([curr_track, curr_artist, curr_album])

        # Travis Scott
        seed_artists2 = "0Y5tJX1MQlPlqiwlOH1tJY"
        track_json2 = get_spotify_recs(limit, seed_artists2, "", access_token)
        for track in track_json2['tracks']:
            curr_track = track['id']
            curr_album = track['album']['id']
            curr_artist = track['artists'][0]['id']
            if curr_track not in unique_tracks:
                unique_tracks.add(curr_track)
                writer.writerow([curr_track, curr_artist, curr_album])
        
        # Bruno Mars
        #seed_artists3 = "0du5cEVh5yTK9QJze8zA0C"
        #track_json3 = get_spotify_recs(limit, seed_artists3, "", access_token)
        #for track in track_json3['tracks']:
        #    curr_track = track['id']
        #    curr_album = track['album']['id']
        #    curr_artist = track['artists'][0]['id']
        #    if curr_track not in unique_tracks:
        #        unique_tracks.add(curr_track)
        #        writer.writerow([curr_track, curr_artist, curr_album])

        print "done\n"

        print ''.join(["writing to ", os.path.join(output_dir, "rec_tracks_features.csv")])
        writer2 = csv.writer(out2, delimiter=',')
        writer2.writerow(["trackID", "acousticness", "danceability", "energy", "instrumentalness", "speechiness", "valence"])

        my_track_list = list(unique_tracks)
        # make composite list. each list has max 50 items.
        track_list = [my_track_list[x:x+50] for x in range(0, len(my_track_list), 50)]

        for tracks in track_list:
            track_ids = ','.join(tracks)
            track_features_json = get_several_tracks_features(track_ids, access_token)

            for feature in track_features_json['audio_features']:
                curr_track = feature['id']
                acousticness = feature['acousticness']
                danceability = feature['danceability']
                energy = feature['energy']
                instrumentalness = feature['instrumentalness']
                speechiness = feature['speechiness']
                valence = feature['valence']
                writer2.writerow([curr_track, acousticness, danceability, energy, instrumentalness, speechiness, valence])


    with open(os.path.join(data_dir, "rec_observation.csv"), 'wb') as out3:
        print ''.join(["writing to ", os.path.join(output_dir, "rec_observation.csv")])
        writer3 = csv.writer(out3, delimiter=',')
        writer3.writerow(["userID", "trackID", "liked", "timestamp"])
        
        for user in users:
            skip_count = 0
            if user == "j.park21":
                skip_count = 15
                like_pct = 83
            elif user == "12149981331":
                like_pct = 92
            elif user == "user0":
                like_pct = 70
            elif user == "user1":
                like_pct = 40
            elif user == "user2":
                skip_count = 10
                like_pct = 89
            elif user == "user3":
                skip_count = 20 
                like_pct = 89
            elif user == "user4":
                skip_count = 23
                like_pct = 74
            elif user == "user5":
                skip_count = 53
                like_pct = 87
            
            for track in unique_tracks:
                if skip_count > 0:
                    skip_count = skip_count - 1
                    continue
                num = random.randint(1,100)
                if (num <= like_pct):
                    liked = 1
                else:
                    liked = 0
                timestamp = datetime.datetime.utcnow()
                #post_like(user, track, liked, timestamp)
                writer3.writerow([user, track, liked, timestamp])



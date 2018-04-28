import csv, glob, json, os, sys
from spotify_controller.spotify_controller import get_several_tracks, get_several_tracks_features

if len(sys.argv) != 3:
    print "ERROR: Missing args\nUsage: python convert.py outFileName accessToken"
elif not sys.argv[1].endswith('.csv'):
    print "ERROR: output file is not a csv file"
else:
    curr_path = os.path.dirname(os.path.abspath(__file__))
    data_dir = 'dataset'
    unformatted_data_files = os.path.join(data_dir, 'unformatted-data/*.json')
    files = glob.glob(unformatted_data_files)
    output_dir = os.path.join(curr_path, data_dir)
    unique_tracks = set()
    access_token = sys.argv[2]

    # converting users' top track info to csv
    with open(os.path.join(data_dir, sys.argv[1]), 'wb') as out:
        print ''.join(["writing to ", os.path.join(output_dir, sys.argv[1])])
        writer = csv.writer(out, delimiter=',')
        writer.writerow(["userID", "trackID"])
        for idx, name in enumerate(files):
            with open(name, 'r') as inp:
                data = json.load(inp)
                for item in data['items']:
                    unique_tracks.add(item['id'])
                    writer.writerow([idx, item['id']])
        print "done\n"

    # writing track info to tracks.csv
    # writing track features to track_features.csv
    tracks_file = "tracks.csv"
    features_file = "track_features.csv"
    with open(os.path.join(data_dir, tracks_file), 'wb') as out2, open(os.path.join(data_dir, features_file), 'wb') as out3:
        print ''.join(["writing to ", os.path.join(output_dir, tracks_file)])
        print ''.join(["writing to ", os.path.join(output_dir, features_file)])
        writer2 = csv.writer(out2, delimiter=',')
        writer2.writerow(["trackID", "artistID", "albumID", "year"])
        writer3 = csv.writer(out3, delimiter=',')
        writer3.writerow(["trackID", "acousticness", "danceability", "energy", "instrumentalness", "speechiness", "valence"])
        temp_track_list = list(unique_tracks)

        # make composite list. each list has max 50 items.
        track_list = [temp_track_list[x:x+50] for x in range(0, len(temp_track_list), 50)]

        for tracks in track_list:
            track_ids = ','.join(tracks)

            track_json = get_several_tracks(track_ids, access_token)
            for track in track_json['tracks']:
                curr_track = track['id']
                curr_album = track['album']['id']
                curr_release_year = track['album']['release_date'][:4]
                curr_artist = track['artists'][0]['id']
                writer2.writerow([curr_track, curr_artist, curr_album, curr_release_year])
            
            track_features_json = get_several_tracks_features(track_ids, access_token)
            for feature in track_features_json['audio_features']:
                curr_track = feature['id']
                acousticness = feature['acousticness']
                danceability = feature['danceability']
                energy = feature['energy']
                instrumentalness = feature['instrumentalness']
                speechiness = feature['speechiness']
                valence = feature['valence']
                writer3.writerow([curr_track, acousticness, danceability, energy, instrumentalness, speechiness, valence])

        print "done"

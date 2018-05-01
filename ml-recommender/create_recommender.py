from os import path
import graphlab as gl

data_dir = './dataset'

actions = gl.SFrame.read_csv(path.join(data_dir, 'rec_observation.csv'))
tracks = gl.SFrame.read_csv(path.join(data_dir, 'rec_tracks.csv'))
track_features = gl.SFrame.read_csv(path.join(data_dir, 'rec_tracks_features.csv'))
tracks = tracks.join(track_features, on='trackID')
training_data, validation_data = gl.recommender.util.random_split_by_user(actions, user_id='userID', item_id='trackID')

model = gl.recommender.ranking_factorization_recommender.create(training_data, user_id='userID', item_id='trackID', item_data=tracks)
eval = model.evaluate(validation_data)
print eval
model.save('recommender_model')

view = model.views.evaluate(validation_data)
view.show()

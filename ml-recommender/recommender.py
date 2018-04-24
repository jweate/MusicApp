from os import path
import graphlab as gl

data_dir = './dataset'

tracks = gl.SFrame.read_csv(path.join(data_dir, 'tracks.csv'))
actions = gl.SFrame.read_csv(path.join(data_dir, 'actions.csv'))
training_data, validation_data = gl.recommender.util.random_split_by_user(actions, user_id='userID', item_id='trackID')

model = gl.recommender.ranking_factorization_recommender.create(training_data, 
                                                                user_id='userID', 
                                                                item_id='trackID', 
                                                                target='rating', 
                                                                item_data=tracks)
eval = model.evaluate(validation_data)
print eval
model.save('recommender_model')


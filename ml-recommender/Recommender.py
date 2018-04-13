from os import path
import graphlab as gl

data_dir = './dataset'

tracks = gl.SFrame.read_csv(path.join(data_dir, 'tracks.csv'))
training_data = gl.SFrame.read_csv(path.join(data_dir, 'train_0.csv'))
validation_data = gl.SFrame.read_csv(path.join(data_dir, 'test_0.csv'))

model = gl.recommender.ranking_factorization_recommender.create(training_data, 
                                                                user_id='userID', 
                                                                item_id='trackID', 
                                                                target='rating', 
                                                                item_data=tracks)
eval = model.evaluate(validation_data)
print eval
model.save('recommender_model')


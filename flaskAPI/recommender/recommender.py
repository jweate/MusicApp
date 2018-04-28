import graphlab as gl
import os

def get_recs(user_id):
    curr_path = os.path.dirname(os.path.abspath(__file__))
    model_dir = os.path.join(curr_path, 'recommender_model')
    model = gl.load_model(model_dir)
    recs = model.recommend(users=[user_id])
    rec_list = list(recs['trackID'])
    return rec_list

def get_mock_recs():
    rec_list = []
    rec_list.append("25oOaleife6E2MIKmFkPvg")
    rec_list.append("4DTpngLjoHj5gFxEZFeD3J")
    rec_list.append("40oKW22ZNNkEdZLJTScaQI")
    rec_list.append("5I30ByMf5nhgbSokY1EZiN")
    rec_list.append("0JaN65P0DapRjboDEv2g08")
    rec_list.append("2BAmF6QyK5IYEOp1TFmt0u")
    rec_list.append("6scpNkWEmUxmKY7nYjVLsX")
    rec_list.append("4Q3N4Ct4zCuIHuZ65E3BD4")
    rec_list.append("1WIZiOuNO3woKfdlSK2gNn")
    return rec_list

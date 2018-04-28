import graphlab as gl
import os

def get_recs():
    #todo
    model = gl.load_model('recommender_model')
    return 'Okay'

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

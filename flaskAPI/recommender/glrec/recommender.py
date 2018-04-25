from os import path
#import graphlab as gl

def suggest_tracks():
    graphlab.product_key.set_product_key('CAA5-57BE-342E-0782-9DC3-0CE7-F506-CED2')
    data_dir = './dataset'
    tracks = gl.SFrame.read_csv(path.join(data_dir, 'actions.csv'))
    return 'OKAY WE GOOD'

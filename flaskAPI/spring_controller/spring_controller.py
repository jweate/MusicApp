import requests

BASE_URL = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/"

def get_new_connections(user_id, similar_users_list):
    resp = get_connections(user_id)
    json_arr = resp.json()
    conn_list = []
    for user in json_arr:
        conn_list.append(user['idUser'])

    # remove existing connections from similar_users_list
    new_conn_list = [x for x in similar_users_list if x not in conn_list]
    return new_conn_list

def get_connections(user_id):
    url = ''.join([BASE_URL, "getCons"])
    params = { 
            "idUser": user_id
            }
    r = requests.get(url, params=params)
    return r
    
def has_liked(userID, trackID):
    url = ''.join([BASE_URL, "getLiked"])
    params = {
            'idUser': userID,
            'SongID': trackID
            }
    r = requests.get(url, params=params)
    like_val = r.json()
    return like_val

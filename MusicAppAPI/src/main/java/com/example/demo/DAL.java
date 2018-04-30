package com.example.demo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entities.User;
import entities.Event;
import entities.Job;
import entities.Track;

@Repository
@Transactional
public class DAL {

    @Autowired
    JdbcTemplate jdbcTemplate;

    class EventRowMapper implements RowMapper<Event> {

        @Override
        public Event mapRow(ResultSet arg0, int arg1) throws SQLException {
        	
            Event event = new Event();

            event.setIdEvent(arg0.getInt("idEvent"));
            event.setEventType(arg0.getString("EventType"));
            event.setSongID(arg0.getString("SongID"));
            event.setIdUser(arg0.getString("idUser"));
            event.setTrackName(arg0.getString("trackName"));
            event.setArtistName(arg0.getString("artistName"));
            
            return event;
        }

    }
    
    class UserRowMapper implements RowMapper<User> {

		@Override
		public User mapRow(ResultSet arg0, int arg1) throws SQLException {
			
			User user = new User();
			
			user.setIdUser(arg0.getString("idUser"));
			
			
			return user;
		}
    }
    
    

    public List<Event> getAllEvents() {
        String sql = "SELECT * FROM Events ORDER BY idEvent DESC;";
        return jdbcTemplate.query(sql, new EventRowMapper());
    }
    
//    String sql = "select * from \n" + 
//			"(select * from Events) as x \n" + 
//			"inner join\n" + 
//			"(select * from Users where idUsers = '"
//			+ user.getIdUser() +"') as y\n" + 
//			"on x.idUser = y.idUsers;";
    
    public List<Event> getConEvents(User user) {
    		String sql = "select idEvent, EventType, SongID, trackName, artistName, idUser from \n" + 
    				"(select * from Events) as x \n" + 
    				"inner join \n" + 
    				"(select * from Users_has_Users where Users_idUsers = '"+user.getIdUser()+"') as y \n" + 
    				"on x.idUser = y.Users_idUsers1;";
    		
    		return jdbcTemplate.query(sql, new EventRowMapper());
    }
    
    public void addUser(User user) {
    		String sql = "INSERT IGNORE INTO Users VALUES ('" +
    				user.getIdUser() + "');";
    		jdbcTemplate.execute(sql);
    }
    
    public void addCon(User user1, User user2) {
    		String sql = "INSERT INTO Users_has_Users VALUES ('"+
    				user1.getIdUser() + "','"+
    				user2.getIdUser() + "');";
    		
    		String sql1 = "INSERT INTO Users_has_Users VALUES ('"+
    				user2.getIdUser() + "','"+
    				user1.getIdUser() + "');";
    		
		jdbcTemplate.execute(sql);
		jdbcTemplate.execute(sql1);
		
	}

    public void addEvent(Event event) {
        String sql = "INSERT IGNORE INTO Events VALUES (null,'";
        sql += event.getEventType() + "','";
        sql += event.getSongID() + "','";
        sql += event.getTrackName() + "','";
        sql += event.getArtistName() + "','";
        sql += event.getIdUser() + "');";
        jdbcTemplate.execute(sql);
    }

    public List<Track> getRecs(String token, String id) {
        String url = "http://http://ec2-18-205-232-42.compute-1.amazonaws.com//recs?access_token=" + token + "&user_id=" + id;
        JSONArray jsonArray = null;
        try {
            URL obj = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
            conn.setRequestMethod("GET");
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                jsonArray = new JSONArray(response.toString());

            } else {
                System.out.println(conn.getResponseMessage());
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        List<Track> tracks = new ArrayList<>();
        try {
            for (int i = 0; i < jsonArray.length(); i++) {

                JSONObject json = jsonArray.getJSONObject(i);
                Track track = new Track();
                track.setTrackID(json.getString("id"));
                track.setTrackName(json.getString("name"));
                track.setDuration(json.getInt("duration_ms"));
                JSONArray artists = json.getJSONArray("artists");
                for (int j = 0; j < artists.length(); j++) {
                    track.addArtist(artists.getString(j));
                }
                track.setAlbumName(json.getString("album"));
                track.setAlbumArtUrl(json.getString("albumArtUrl"));
                tracks.add(track);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return tracks;
    }

	
	
}

    


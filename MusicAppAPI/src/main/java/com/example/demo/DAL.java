package com.example.demo;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entities.User;
import spotify.controller.SPTController;
import entities.Event;
import entities.Job;
import entities.Track;

@Repository
@Transactional
public class DAL {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private SPTController spt = new SPTController();
	
	
	class EventRowMapper implements RowMapper<Event>{

		@Override
		public Event mapRow(ResultSet arg0, int arg1) throws SQLException {
			Event event = new Event();
			
			event.setIdEvent(arg0.getInt("idEvent"));
			event.setEventType(arg0.getString("EventType"));
			event.setSongID(arg0.getString("SongID"));
			event.setIdUser(arg0.getInt("idUser"));
			return event;
		}
		
	
	}

	public List<Event> getAllEvents() {
		String sql = "SELECT * FROM Events";
		return jdbcTemplate.query(sql, new EventRowMapper());
	}

	public void addEvent(Event event) {
		String sql = "INSERT INTO Events VALUES (null,'";
		sql += event.getEventType() + "','";
		sql += event.getSongID() + "','";
		sql += event.getIdUser() + "');";
		jdbcTemplate.execute(sql);
	}
	
	public List<Track> getRecs(String token) {
		List<Track> tracks = new ArrayList<>();
		try {
            Process pr = Runtime.getRuntime().exec("python ml-recommender/mockrecommender.py");
            BufferedReader bfr = new BufferedReader(new InputStreamReader(pr.getInputStream()));
            String line = "";
            while((line = bfr.readLine()) != null) {
            	JSONObject json = spt.getTrack(line, token);
            	if (json == null) {
            		continue;
            	}
            	Track track = new Track();
            	track.setTrackID(json.getString("id"));
            	track.setTrackName(json.getString("name"));
            	track.setDuration(json.getInt("duration_ms"));
            	JSONArray artists = json.getJSONArray("artists");
            	for (int i = 0; i < artists.length(); i++) {
            		track.addArtist(artists.getJSONObject(i).getString("name"));
            	}
            	JSONObject album = json.getJSONObject("album");
            	track.setAlbumName(album.getString("name"));
            	JSONArray albumArt = album.getJSONArray("images");
            	track.setAlbumArtUrl(albumArt.getJSONObject(1).getString("url"));
            	tracks.add(track);
            }           
        } catch (Exception e) {
            e.printStackTrace();
        }
		return tracks;
	}
	
	
	
	
	
	
//	class UserRowMapper implements RowMapper<User>{
//
//		@Override
//		public User mapRow(ResultSet arg0, int arg1) throws SQLException {
//			User user = new User();
//			
//			user.setIdUsers(arg0.getInt("idUsers"));
//			user.setFirstName(arg0.getString("FirstName"));
//			user.setLastName(arg0.getString("LastName"));
//			user.setAddress(arg0.getString("Address"));
//			user.setBirthDate(arg0.getString("BirthDate"));
//			user.setDev(arg0.getBoolean("Dev"));
//			user.setEmail(arg0.getString("Email"));
//			user.setIdUsers(arg0.getInt("idUsers"));
//			user.setJoinDate(arg0.getString("JoinDate"));
//			user.setPassword(arg0.getString("Password"));
//			user.setPhone(arg0.getString("Phone"));
//			return user;
//		}
//		
//	
//	}
//	
//	class JobRowMapper implements RowMapper<Job>{
//
//		@Override
//		public Job mapRow(ResultSet arg0, int arg1) throws SQLException {
//			Job job = new Job();
//			
//			job.setDescrtiption(arg0.getString("Description"));
//			job.setIdJobs(arg0.getInt("idJobs"));
//			job.setIdUsers(arg0.getInt("idUsers"));
//			job.setJobName("JobName");
//			
//			return job;
//		}
//		
//		
//	}
//	
//	
//
//	public List<User> getAllUsers() {
//		String sql = "SELECT * FROM Users";
//		return jdbcTemplate.query(sql, new UserRowMapper());
//	}
//	
//	
//	public String addUser(User user) {
//		String sql = "INSERT INTO Users VALUES (null,'";
//		sql += user.getFirstName() + "','";
//		sql += user.getLastName() + "','";
//		sql += user.getAddress() + "','";
//		sql += user.getPhone() + "','";
//		sql += user.getEmail() + "',";
//		sql += "null,'";
//		sql += user.getBirthDate() + "','";
//		sql += user.getPassword() + "',";
//		sql += "1);";
//		
//		jdbcTemplate.execute(sql);
//		
//		return "Good";
//	}
//	
//	public String verifyUser(String email, String password) {
//		String sql = "SELECT * FROM Users WHERE Email = '"  + email + "' && ";
//		sql += "Password = '" + password + "'";
//		
//		List<User> list = jdbcTemplate.query(sql, new UserRowMapper());
//		if (list.size() != 0) {
//			return "idUsers = " + list.get(0).getIdUsers();
//		}
//		return "bad credentials";
//	}
//	
//	public User getUserInfo(String email) {
//		String sql = "select * from Users where Email = '" +
//				email + "' limit 1;";
//		
//		
//		try {
//			User user = jdbcTemplate.queryForObject(sql, new UserRowMapper());
//			return user;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return null;
//		}
//		
//		
//		
//		
//	}
//	
//	public String updateUser(User user) {
//		String sql = "update Users set  FirstName = '"
//				+ user.getFirstName() + "', LastName = '"
//				+ user.getLastName()+ "', Address = '"
//				+ user.getAddress() +"', Phone = '"
//				+ user.getPhone()+"', Email = '"
//				+ user.getEmail()+"',BirthDate = '"
//				+ user.getBirthDate()+"',Password = '"
//				+ user.getPassword() +
//				"' where idUsers = " + user.getIdUsers();
//		
//		jdbcTemplate.execute(sql);
//		
//		
//		return "Good";
//	}
//	
//	public List<Job> getJobs(int idUser) {
//		String sql = "select * from Jobs where idUsers = ";
//		sql += idUser + "";
//		
//		return jdbcTemplate.query(sql, new JobRowMapper());
//	}
	
	
	
	
}

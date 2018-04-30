package com.example.demo;
import java.util.List;

import org.jboss.logging.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import entities.Event;
import entities.Job;
import entities.Track;
import entities.User;


@RestController
public class AController {

	@Autowired
	private DAL dal;
	
	
	//**************---------GET-----------******************
	
	
	@RequestMapping(value = "/getEvents", method = RequestMethod.GET)
	@ResponseBody
	public List<Event> getAllEvents(){
		return dal.getAllEvents();
	}
	
	@RequestMapping(value = "/getConEvents", method = RequestMethod.GET)
	@ResponseBody
	public List<Event> getConEvents(@RequestParam("idUser") String idUser){
		
		User user = new User();
		user.setIdUser(idUser);
		
		return dal.getConEvents(user);
	}
	
	@RequestMapping(value = "/getCons", method = RequestMethod.GET)
	@ResponseBody
	public List<User> getCons(@RequestParam("idUser") String idUser) {
		User user = new User();
		user.setIdUser(idUser);
		return dal.getConnections(user);
	}
	
	@RequestMapping(value = "/getUsers", method = RequestMethod.GET)
	@ResponseBody
	public List<User> getUsers() {
		
		return dal.getUsers();
	}
	
	@RequestMapping(value = "/getLiked", method = RequestMethod.GET)
	@ResponseBody
	public int getLiked(@RequestParam("idUser") String idUser, 
						@RequestParam("SongID") String SongID) {
		return dal.getLiked(idUser, SongID);
		
	}
	
	@RequestMapping(value = "/getRecs", method = RequestMethod.GET)
	@ResponseBody
	public List<Track> getRecs(@RequestParam("access_token") String token,
								@RequestParam("user_id") String id) {
		return dal.getRecs(token, id);
	}
	
	//**************---------POST-----------******************
	
	@RequestMapping(value = "/addLiked", method = RequestMethod.POST)
	@ResponseBody
	public void addLiked(@RequestParam("idUser") String idUser,
					   @RequestParam("SongID") String SongID,
					   @RequestParam("liked") int liked)
	{
		
		
		
		dal.addLiked(idUser, SongID, liked);
	}
	
	
	@RequestMapping(value = "/addCon", method = RequestMethod.POST)
	@ResponseBody
	public void addCon(@RequestParam("idUser1") String idUser1,
					   @RequestParam("idUser2") String idUser2) {
		User user1 = new User();
		User user2 = new User();
		
		user1.setIdUser(idUser1);
		user2.setIdUser(idUser2);
		
		
		dal.addCon(user1, user2);
	}
	
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	@ResponseBody
	public void addUser(@RequestParam("idUser") String idUser) {
		User user = new User();
		
		user.setIdUser(idUser);
		
		
		dal.addUser(user);
	}
	
	
	
	
	
	@RequestMapping(value = "/addEvent", method = RequestMethod.POST)
	@ResponseBody
	public void addEvent(@RequestParam("EventType") String EventType,
							@RequestParam("SongID") String SongID,
							@RequestParam("trackName") String trackName,
							@RequestParam("artistName") String artistName,
							@RequestParam("idUser") String idUser)
							{
		Event event = new Event();
		event.setEventType(EventType);
		event.setSongID(SongID);
		event.setTrackName(trackName);
		event.setArtistName(artistName);
		event.setIdUser(idUser);
		
		dal.addEvent(event);
	}
	
		
	
}
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
	
	@RequestMapping(value = "/getEvents", method = RequestMethod.GET)
	@ResponseBody
	public List<Event> getAllEvents(){
		return dal.getAllEvents();
	}
	
	@RequestMapping(value = "/addEvent", method = RequestMethod.POST)
	@ResponseBody
	public void addEvent(@RequestParam("EventType") String EventType,
							@RequestParam("SongID") String SongID,
							@RequestParam("UserID") int UserID) {
		Event event = new Event();
		event.setEventType(EventType);
		event.setSongID(SongID);
		event.setIdUser(UserID);
	}
	
	@RequestMapping(value = "/getRecs", method = RequestMethod.GET)
	@ResponseBody
	public List<Track> getRecs(@RequestParam("access_token") String token,
								@RequestParam("user_id") String id) {
		return dal.getRecs(token, id);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	@RequestMapping(value = "/getUsers", method = RequestMethod.GET)
//	@ResponseBody
//	public List<User> getAllUsers(){
//		return dal.getAllUsers();
//	}
//	
//	@RequestMapping(value = "/getJobs", method = RequestMethod.GET)
//	@ResponseBody
//	public List<Job> getJobs(@RequestParam("idUsers") int idUsers){
//		return dal.getJobs(idUsers);
//	}
//	
//	@RequestMapping(value = "/getUserInfo", method = RequestMethod.GET)
//	@ResponseBody
//	public User getUserInfo(String email){
//		return dal.getUserInfo(email);
//	}
//	
//	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
//	@ResponseBody
//	public String addUser(@RequestParam("FirstName") String FirstName,
//							@RequestParam("LastName") String LastName,
//							@RequestParam("Address") String Address,
//							@RequestParam("Phone") String Phone,
//							@RequestParam("Email") String Email,
//							@RequestParam("BirthDate") String BirthDate,
//							@RequestParam("Password") String Password) {
//		User user = new User();
//		user.setFirstName(FirstName);
//		user.setLastName(LastName);
//		user.setAddress(Address);
//		user.setPhone(Phone);
//		user.setEmail(Email);
//		user.setBirthDate(BirthDate);
//		user.setPassword(Password);
//		
//	
//		return dal.addUser(user);
//	}
//	
//	@RequestMapping(value = "/verifyUser", method = RequestMethod.GET)
//	@ResponseBody
//	public String verifyUser(@RequestParam("email") String email, 
//							@RequestParam("password") String password) {
//		return dal.verifyUser(email, password);
//		
//	}
//	
//	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
//	@ResponseBody
//	public String updateUser(@RequestParam("FirstName") String FirstName,
//							@RequestParam("LastName") String LastName,
//							@RequestParam("Address") String Address,
//							@RequestParam("Phone") String Phone,
//							@RequestParam("Email") String Email,
//							@RequestParam("BirthDate") String BirthDate,
//							@RequestParam("Password") String Password,
//							@RequestParam("idUsers") int idUsers ){
//		
//		User user = new User();
//		user.setFirstName(FirstName);
//		user.setLastName(LastName);
//		user.setAddress(Address);
//		user.setPhone(Phone);
//		user.setEmail(Email);
//		user.setBirthDate(BirthDate);
//		user.setPassword(Password);
//		user.setIdUsers(idUsers);
//		
//	
//		return dal.updateUser(user);
//	}
	
	
	
	
}
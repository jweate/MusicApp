package entities;

public class Event {
	
	private int idEvent;
	private String EventType;
	private String SongID;
	private String idUser;
	
	public Event() {
		
	}

	public int getIdEvent() {
		return idEvent;
	}

	public void setIdEvent(int idEvent) {
		this.idEvent = idEvent;
	}

	public String getEventType() {
		return EventType;
	}

	public void setEventType(String eventType) {
		EventType = eventType;
	}

	public String getSongID() {
		return SongID;
	}

	public void setSongID(String songID) {
		SongID = songID;
	}

	public String getIdUser() {
		return idUser;
	}

	public void setIdUser(String userID) {
		this.idUser = userID;
	}
	
	

}

package entities;

import java.util.ArrayList;

public class Track {
	private ArrayList<String> artists;
	private int duration;
	private String trackName;
	private String trackID;
	private String albumArtUrl;
	private String albumName;
	
	public Track() {
		artists = new ArrayList<>();
	}
	
	public void addArtist(String a) {
		artists.add(a);
	}
	
	public ArrayList<String> getArtists() {
		return artists;
	}
	
	public void setDuration(int d) {
		duration = d;
	}
	
	/**
	 * Gets the duration of the track in milliseconds.
	 * @return duration in milliseconds
	 */
	public int getDuration() {
		return duration;
	}
	
	public void setTrackName(String t) {
		trackName = t;
	}
	
	public String getTrackName() {
		return trackName;
	}
	
	public void setTrackID(String tid) {
		trackID = tid;
	}
	
	public String getTrackID() {
		return trackID;
	}
	
	public void setAlbumArtUrl(String url) {
		albumArtUrl = url;
	}
	
	public String getAlbumArtUrl() {
		return albumArtUrl;
	}
	
	public void setAlbumName(String n) {
		albumName = n;
	}
	
	public String getAlbumName() {
		return albumName;
	}

}

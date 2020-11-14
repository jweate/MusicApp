package spotify.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONException;
import org.json.JSONObject;

public class SPTController {

	public JSONObject getTrack(String trackID, String token) {
		String url = "https://api.spotify.com/v1/tracks/" + trackID;
		JSONObject json = null;
		try {
			URL obj = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + token);
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();

				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				json = new JSONObject(response.toString());
				
			} else {
				System.out.println(conn.getResponseMessage());
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return json;
	}

}

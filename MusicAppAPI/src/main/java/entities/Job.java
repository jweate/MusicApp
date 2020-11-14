package entities;

public class Job {
	
	private int idJobs;
	private String JobName;
	private String Descrtiption;
	private int idUsers;
	
	public Job() {
		
	}

	public int getIdJobs() {
		return idJobs;
	}

	public void setIdJobs(int idJobs) {
		this.idJobs = idJobs;
	}

	public String getJobName() {
		return JobName;
	}

	public void setJobName(String jobName) {
		JobName = jobName;
	}

	public String getDescrtiption() {
		return Descrtiption;
	}

	public void setDescrtiption(String descrtiption) {
		Descrtiption = descrtiption;
	}

	public int getIdUsers() {
		return idUsers;
	}

	public void setIdUsers(int idUsers) {
		this.idUsers = idUsers;
	}
	
	

}

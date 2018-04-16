package entities;




public class User {

	private int idUsers;
	private String FirstName;
	private String LastName;
	private String Address;
	private String Phone;
	private String Email;
	private String JoinDate;
	private String BirthDate;
	private String Password;
	private Boolean Dev;
	
	public User() {
		
	}

	
	public String getPassword() {
		return Password;
	}


	public void setPassword(String password) {
		Password = password;
	}


	public Boolean getDev() {
		return Dev;
	}


	public void setDev(Boolean dev) {
		Dev = dev;
	}


	public int getIdUsers() {
		return idUsers;
	}


	public void setIdUsers(int idUsers) {
		this.idUsers = idUsers;
	}


	public String getFirstName() {
		return FirstName;
	}


	public void setFirstName(String firstName) {
		FirstName = firstName;
	}


	public String getLastName() {
		return LastName;
	}


	public void setLastName(String lastName) {
		LastName = lastName;
	}


	public String getAddress() {
		return Address;
	}


	public void setAddress(String address) {
		Address = address;
	}


	public String getPhone() {
		return Phone;
	}


	public void setPhone(String phone) {
		Phone = phone;
	}


	public String getEmail() {
		return Email;
	}


	public void setEmail(String email) {
		Email = email;
	}


	public String getJoinDate() {
		return JoinDate;
	}


	public void setJoinDate(String joinDate) {
		JoinDate = joinDate;
	}


	public String getBirthDate() {
		return BirthDate;
	}


	public void setBirthDate(String birthDate) {
		BirthDate = birthDate;
	}
	
	
}

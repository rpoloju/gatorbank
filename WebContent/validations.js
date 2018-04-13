/**
 * This file is to validate the fields
 */

function validLogin() {

	if (document.welcomepage.onlineid.value == "") {
		alert("Please enter Login id.");
		document.welcomepage.onlineid.focus();
		return false;
	}
	if (document.welcomepage.passcode.value == "") {
		alert("Please enter passcode.");
		document.welcomepage.passcode.focus();
		return false;
	}
	return true;
}

function forgotpasscodecheck() {
	
	if (document.changepasscode.passcode1.value == "") {
		alert("Please enter a valid passcode");
		document.changepasscode.passcode1.focus();
		return false;
	}
	return true;
}

function validnew() {
	if (!(document.createaccount.sex.value == 0 || document.createaccount.sex.value == 1)) {
		alert("Please select gender");
		return false;
	}
	var dateofbirth = document.createaccount.dob.value;
	if (dateofbirth.length != 8) {
		alert("Invalid Date of Birth");
		document.createaccount.dob.focus();
		return false;
	}
	var month = parseInt(dateofbirth.substring(0,2));
	var day = parseInt(dateofbirth.substring(2,4));
	var year = parseInt(dateofbirth.substring(4,8));
	
	if (month > 12 || month < 1) {
		alert("Invalid Month");
		document.createaccount.dob.focus();
		return false;
	}
	
	if (month == 1 || month == 3 || month == 5 || month == 7 ||month == 8 || month == 10 || month == 12) {
		if (parseInt(dateofbirth.substring(2,4)) > 31 || parseInt(dateofbirth.substring(2,4)) < 1) {
			alert("Invalid date");
			document.createaccount.dob.focus();
			return false;
		}
	}
	
	if (month == 4 || month == 6 || month == 9 || month == 11) {
		if (parseInt(dateofbirth.substring(2,4)) > 30 || parseInt(dateofbirth.substring(2,4)) < 1) {
			alert("Invalid date");
			document.createaccount.dob.focus();
			return false;
		}
	}
	
	if (month == 2) {
		if (parseInt(dateofbirth.substring(2,4)) > 28 || parseInt(dateofbirth.substring(2,4)) < 1) {
			alert("Invalid date");
			document.createaccount.dob.focus();
			return false;
		}
	}
	
	var d = new Date(year,month,day);
	var curr = new Date();
	var timeDiff = curr.getTime() - d.getTime();
	
	if (timeDiff < 0) {
		alert("Invalid date");
		document.createaccount.dob.focus();
		return false;
	}
	
	var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
	
	if (diffDays < 6570) {
		alert("You are too young to get an account");
		document.createaccount.dob.focus();
		return false;
	}
	
	if (document.createaccount.passcode.value == "") {
		alert("Please enter passcode");
		document.createaccount.passcode.focus();
		return false;
	}
	return true;
}
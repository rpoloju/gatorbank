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

	var dateofbirth = document.createaccount.dob.value;
	if (dateofbirth.length != 8) {
		alert("Invalid Date of Birth");
		document.createaccount.dob.focus();
		return false;
	}
	var month = parseInt(dateofbirth.substring(0, 2));
	var day = parseInt(dateofbirth.substring(2, 4));
	var year = parseInt(dateofbirth.substring(4, 8));

	if (month > 12 || month < 1) {
		alert("Invalid Month");
		document.createaccount.dob.focus();
		return false;
	}

	if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8
			|| month == 10 || month == 12) {
		if (parseInt(dateofbirth.substring(2, 4)) > 31
				|| parseInt(dateofbirth.substring(2, 4)) < 1) {
			alert("Invalid date");
			document.createaccount.dob.focus();
			return false;
		}
	}

	if (month == 4 || month == 6 || month == 9 || month == 11) {
		if (parseInt(dateofbirth.substring(2, 4)) > 30
				|| parseInt(dateofbirth.substring(2, 4)) < 1) {
			alert("Invalid date");
			document.createaccount.dob.focus();
			return false;
		}
	}

	if (month == 2) {
		if (parseInt(dateofbirth.substring(2, 4)) > 28
				|| parseInt(dateofbirth.substring(2, 4)) < 1) {
			alert("Invalid date");
			document.createaccount.dob.focus();
			return false;
		}
	}

	var d = new Date(year, month, day);
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

function validstDates() {
	var stDate = document.statementDates.startDate.value;
	document.write(startDate);
	document.write(startDate.length);
	if (stDate.length != 8) {
		alert("Invalid start date");
		document.statementDates.startDate.focus();
		return false;
	}
	var month1 = parseInt(stDate.substring(0, 2));
	var day1 = parseInt(stDate.substring(2, 4));
	var year1 = parseInt(stDate.substring(4, 8));

	if (month1 > 12 || month1 < 1) {
		alert("Invalid Month in start date");
		document.statementDates.startDate.focus();
		return false;
	}

	if (month1 == 1 || month1 == 3 || month1 == 5 || month1 == 7 || month1 == 8
			|| month1 == 10 || month1 == 12) {
		if (parseInt(stDate.substring(2, 4)) > 31
				|| parseInt(stDate.substring(2, 4)) < 1) {
			alert("Invalid start date");
			document.statementDates.startDate.focus();
			return false;
		}
	}

	if (month1 == 4 || month1 == 6 || month1 == 9 || month1 == 11) {
		if (parseInt(stDate.substring(2, 4)) > 30
				|| parseInt(stDate.substring(2, 4)) < 1) {
			alert("Invalid start date");
			document.statementDates.startDate.focus();
			return false;
		}
	}

	if (month1 == 2) {
		if (parseInt(stDate.substring(2, 4)) > 28
				|| parseInt(stDate.substring(2, 4)) < 1) {
			alert("Invalid start date");
			document.statementDates.startDate.focus();
			return false;
		}
	}

	var eDate = document.statementDates.endDate.value;
	if (eDate.length != 8) {
		alert("Invalid start date");
		document.statementDates.endDate.focus();
		return false;
	}
	var month2 = parseInt(eDate.substring(0, 2));
	var day2 = parseInt(eDate.substring(2, 4));
	var year2 = parseInt(eDate.substring(4, 8));

	if (month2 > 12 || month2 < 1) {
		alert("Invalid Month in end date");
		document.statementDates.endDate.focus();
		return false;
	}

	if (month2 == 1 || month2 == 3 || month2 == 5 || month2 == 7 || month2 == 8
			|| month2 == 10 || month2 == 12) {
		if (parseInt(eDate.substring(2, 4)) > 31
				|| parseInt(eDate.substring(2, 4)) < 1) {
			alert("Invalid end date");
			document.statementDates.endDate.focus();
			return false;
		}
	}

	if (month2 == 4 || month2 == 6 || month2 == 9 || month2 == 11) {
		if (parseInt(eDate.substring(2, 4)) > 30
				|| parseInt(eDate.substring(2, 4)) < 1) {
			alert("Invalid end date");
			document.statementDates.endDate.focus();
			return false;
		}
	}

	if (month2 == 2) {
		if (parseInt(eDate.substring(2, 4)) > 28
				|| parseInt(eDate.substring(2, 4)) < 1) {
			alert("Invalid end date");
			document.statementDates.endDate.focus();
			return false;
		}
	}
	return true;
}
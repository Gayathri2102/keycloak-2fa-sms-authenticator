var passwordInput = document.getElementById("password");
function togglePasswordFunc() {
	if (passwordInput === null||passwordInput === undefined)
	{
		passwordInput = document.getElementById("password");
	}
	passwordInput.type === "password" ? passwordInput.type = "text" : passwordInput.type = "password";
}

function onSubmitFunc() {
	var confirmPasswordInput = document.getElementById("confirm-password");
	var matchingErrorMsg = document.getElementById("matching-error-msg");

	if (passwordInput.value != confirmPasswordInput.value) {
		matchingErrorMsg.style.display = 'inline-block'
	}
}

var letter = document.getElementById("letter");
var special = document.getElementById("special-character");
var number = document.getElementById("number");
var length = document.getElementById("length");

passwordInput.onkeyup = function() {
	var letters = /[a-zA-Z]+/g ;
	var specialCharacters = /[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
	var numbers = /\d+/g;

	if (passwordInput.value.match(letters)) {
		letter.classList.remove("invalid");
		letter.classList.add("valid");
	} else {
		letter.classList.remove("valid");
		letter.classList.add("invalid");
	}

	if (passwordInput.value.match(specialCharacters)) {
		special.classList.remove("invalid");
		special.classList.add("valid");
	} else {
		special.classList.remove("valid");
		special.classList.add("invalid");
	}

	if (passwordInput.value.match(numbers)) {
		number.classList.remove("invalid");
		number.classList.add("valid");
	} else {
		number.classList.remove("valid");
		number.classList.add("invalid");
	}

	if (passwordInput.value.length >= 8) {
		length.classList.remove("invalid");
		length.classList.add("valid");
	} else {
		length.classList.remove("valid");
		length.classList.add("invalid");
	}
}

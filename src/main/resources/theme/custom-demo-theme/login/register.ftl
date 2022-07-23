<#import "template.ftl" as layout>
<link href="resources/css/bootstrap-material-design-alerts.css">
<link href="resources/css/material-components-web.min.css">
<link href="resources/css/material-keycloak-theme.css">
<link href="resources/css/register.css">

<link href="resources/css/common.css">
<script src="js/polyfill/nodelist-foreach.js"></script>
<script src="js/material-components-web.min.js"></script>
<script src="js/material-keycloak-theme.js"></script>

<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("registerWithTitle",(realm.displayName!''))?no_esc}
    <#elseif section = "header">
		<img id="cancelimg" />
	<div class="title">
        ${msg("Register",(realm.displayNameHtml!''))?no_esc}
		<p id="kc-header-p">
			This information will be used when two-factor authentication is
			enable
		</p>
	</div>
    <#elseif section = "form">
		<form id="kc-register-form" class="register form ${properties.kcFormClass!}" action="${url.registrationAction}" method="post" >
			<input type="text" readonly value="this is not a login form" style="display: none;">
			<input type="password" readonly value="this is not a login form" style="display: none;">

            <#if !realm.registrationEmailAsUsername>
				<div>
					<input id="username"   name="username" type="text" autofocus required value="${(register.formData.username!'')}">
				</div>
				<br/>
            </#if>
			<div>
				<input required id="email" name="email" type="text"  placeholder="Email" required value="${(register.formData.email!'')}">

			</div>
			<br/>
            <#if passwordRequired>
				<div>
					<div style="position: absolute; height: 56px;width: 100%">
						<input type="password" id="password" name="password" minlength="8" placeholder="Password" required>
					</div>
					<div onclick="togglePasswordFunc()" style="position: absolute; z-index: 9; margin: 18px 40px; right: 0; color: #ffffff; font-family: sfPro; text-align: end;">
						Show
					</div>
				</div>
				<br/><br/><br/><br/>
				<div>
					<input required id="password-confirm"  name="password-confirm" minlength="8" placeholder="Confirm password" type="password">

				</div>
				<p id="matching-error-msg" style="color: #ff453a; font-size: 14px; display: none;">
					Passwords don't match
				</p>
				<div class="flex-container">
					<div class="flex-container" style="width: 35%">
						<div class="center-align" style="margin-right: 6px;">
							<img class="invalid" id="letter"/>
						</div>
						<p class="validation-title">One letter</p>
					</div>
					<div class="flex-container">
						<div class="center-align" style="margin-right: 6px;">
							<img class="invalid" id="special-character"/>
						</div>
						<p class="validation-title">One special character</p>
					</div>
				</div>

				<div class="flex-container">
					<div class="flex-container" style="width: 35%">
						<div class="center-align" style="margin-right: 6px;">
							<img class="invalid" id="number"/>
						</div>
						<p class="validation-title">One number</p>
					</div>
					<div class="flex-container">
						<div class="center-align" style="margin-right: 6px;">
							<img class="invalid" id="length"/>
						</div>
						<p class="validation-title">8 characters minimum</p>
					</div>
				</div>
            </#if>
			<div id="kc-form-options" style="display: none" class="${properties.kcFormOptionsClass!}">
				<div class="${properties.kcFormOptionsWrapperClass!}">
                        <span>
                            <button class="mdc-button" onclick="window.location.href = ${url.loginUrl}" novalidate>
                                <i class="material-icons mdc-button__icon" aria-hidden="true">arrow_back</i>
                                ${msg("backToLogin")?no_esc}
                            </button>
                        </span>
				</div>
			</div>
				<div >

					<button onclick="onSubmitFunc()" style="width: 100%" class="mdc-button mdc-button--raised ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit">
                        ${msg("doRegister")?no_esc}
					</button>
				</div>


		</form>
    </#if>


	<script type="text/javascript">
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

	</script>
</@layout.registrationLayout>

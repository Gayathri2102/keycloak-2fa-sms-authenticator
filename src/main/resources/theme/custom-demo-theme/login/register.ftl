<#import "template.ftl" as layout>
<link href="resources/css/bootstrap-material-design-alerts.css">
<link href="resources/css/material-components-web.min.css">
<link href="resources/css/material-keycloak-theme.css">
<link href="resources/css/register.css?v1.0">

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
					<input id="username"   name="username" type="text" style="color: #9c9ea3!important;" autofocus required value="${(register.formData.username!'')}">
				</div>
				<br/>
            </#if>
			<div>
				<input required id="email" name="email" type="text"  placeholder="Email" style="color: #9c9ea3!important;" required value="${(register.formData.email!'')}">

			</div>
			<br/>
            <#if passwordRequired>
				<div>
					<div style="position: absolute; height: 56px;width: 100%">
						<input type="password" id="password" name="password" minlength="8" placeholder="Password" style="color: #9c9ea3!important;" required>
					</div>
					<div onclick="togglePasswordFunc()" style="position: absolute; z-index: 9; margin: 18px 40px; right: 0; color: #ffffff; font-family: sfPro; text-align: end;">
						Show
					</div>
				</div>
				<br/><br/><br/><br/>
				<div>
					<input required id="password-confirm"  name="password-confirm" minlength="8" placeholder="Confirm password" type="password" style="color: #9c9ea3!important;">

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

					<button style="background-color: #9f0ccc; width: 100%; height: 48px; border-radius: 8px; outline: none; border: none;" onclick="onSubmitFunc()" style="width: 100%" class="mdc-button mdc-button--raised ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit">
                        ${msg("Submit")?no_esc}
					</button>
				</div>


		</form>
    </#if>
</@layout.registrationLayout>

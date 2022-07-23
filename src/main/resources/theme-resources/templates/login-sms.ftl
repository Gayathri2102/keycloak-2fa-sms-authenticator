<#import "template.ftl" as layout>
<link href="resources/css/bootstrap-material-design-alerts.css">
<link href="resources/css/material-components-web.min.css">
<link href="resources/css/material-keycloak-theme.css">
<link href="resources/css/login_sms.css">
<script src="js/polyfill/nodelist-foreach.js"></script>
<script src="js/material-components-web.min.js"></script>
<script src="js/material-keycloak-theme.js"></script>
<@layout.registrationLayout displayInfo=true; section>
	<#if section = "header">
		${msg("smsAuthTitle",realm.displayName)}
		<p id="kc-header-p">
            ${msg("smsAuthInstruction")}
		</p>
	<#elseif section = "form">
		<form id="kc-sms-code-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">

			<div class="mdc-text-field mdc-text-field--outlined mdc-text-field--with-leading-icon ${properties.kcLabelClass!}">
				<i class="material-icons mdc-text-field__icon" tabindex="-1" role="button">email</i>
				<input required id="text" class="mdc-text-field__input ${properties.kcInputClass!}" name="code" type="text" value="">
				<div class="${properties.kcLabelWrapperClass!}">
					<label for="code" class="mdc-floating-label ${properties.kcLabelClass!}">${msg("smsAuthLabel")?no_esc}</label>
				</div>
				<div class="mdc-notched-outline">
					<svg>
						<path class="mdc-notched-outline__path"/>
					</svg>
				</div>
				<div class="mdc-notched-outline__idle"></div>
			</div>


		<#--	<div class="${properties.kcFormGroupClass!}">
				<div class="${properties.kcLabelWrapperClass!}">
					<label for="code" class="${properties.kcLabelClass!}">${msg("smsAuthLabel")}</label>
				</div>
				<div class="${properties.kcInputWrapperClass!}">
					<input type="text" id="code" name="code" class="${properties.kcInputClass!}" autofocus/>
				</div>
			</div>-->
			<div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
				<div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
					<div class="${properties.kcFormOptionsWrapperClass!}">
						<#--<span><a class="mdc-button mdc-ripple-upgraded" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>-->
						<span>
                            <button class="mdc-button" onclick="window.location.href = '${url.loginUrl}'" novalidate>
                                <i class="material-icons mdc-button__icon" aria-hidden="true">arrow_back</i>
                                ${msg("backToLogin")?no_esc}
                            </button>
                        </span>
					</div>
				</div>

				<div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
					<input style="float: right" class="mdc-button mdc-button--raised mdc-ripple-upgraded" ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}"/>
				</div>
			</div>
		</form>
	</#if>
</@layout.registrationLayout>

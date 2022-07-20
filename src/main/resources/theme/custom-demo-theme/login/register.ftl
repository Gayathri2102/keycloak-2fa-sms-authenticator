<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "title">
        ${msg("registerWithTitle",(realm.displayName!''))?no_esc}
    <#elseif section = "header">
        ${msg("Email & Password",(realm.displayNameHtml!''))?no_esc}
    <#elseif section = "form">
		<form id="kc-register-form" class="register form ${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
			<input type="text" readonly value="this is not a login form" style="display: none;">
			<input type="password" readonly value="this is not a login form" style="display: none;">

            <#--<#if !realm.registrationEmailAsUsername>
			</#if>-->

			<div class="mdc-text-field mdc-text-field--outlined mdc-text-field--with-leading-icon ${properties.kcLabelClass!}">
				<i class="material-icons mdc-text-field__icon" tabindex="-1" role="button">email</i>
				<input required id="email" class="mdc-text-field__input ${properties.kcInputClass!}" name="email" type="text" value="${(register.formData.email!'')}">
				<div class="${properties.kcLabelWrapperClass!}">
					<label for="email" class="mdc-floating-label ${properties.kcLabelClass!}">${msg("email")?no_esc}</label>
				</div>
				<div class="mdc-notched-outline">
					<svg>
						<path class="mdc-notched-outline__path"/>
					</svg>
				</div>
				<div class="mdc-notched-outline__idle"></div>
			</div>

            <#if passwordRequired>

				<div class="mdc-text-field mdc-text-field--outlined mdc-text-field--with-leading-icon ${properties.kcLabelClass!}">
					<i class="material-icons mdc-text-field__icon" tabindex="-1" role="button">lock</i>
					<input required id="password" class="mdc-text-field__input ${properties.kcInputClass!}" name="password" type="password">
					<div class="${properties.kcLabelWrapperClass!}">
						<label for="password" class="mdc-floating-label ${properties.kcLabelClass!}">${msg("password")?no_esc}</label>
					</div>
					<div class="mdc-notched-outline">
						<svg>
							<path class="mdc-notched-outline__path"/>
						</svg>
					</div>
					<div class="mdc-notched-outline__idle"></div>
				</div>

				<div class="form-group" style="display: none">
					<div class="${properties.kcLabelWrapperClass!}">
						<label for="user.attributes.mobile_number" class="${properties.kcLabelClass!}">Mobile number</label>
					</div>

					<div class="${properties.kcInputWrapperClass!}">
						<input type="text" class="${properties.kcInputClass!}" id="user.attributes.mobile_number" name="user.attributes.mobile_number" value="1234567890"/>
					</div>
				</div>
            </#if>

			<div class="${properties.kcFormGroupClass!} register-button-container">

				<div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
					<div class="${properties.kcFormOptionsWrapperClass!}">
                        <span>
                            <button class="mdc-button" onclick="window.location.href = '${url.loginUrl}'" novalidate>
                                <i class="material-icons mdc-button__icon" aria-hidden="true">arrow_back</i>
                                ${msg("backToLogin")?no_esc}
                            </button>
                        </span>
					</div>
				</div>

				<div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
					<button  class="mdc-button mdc-button--raised  ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit">
                        ${msg("doRegister")?no_esc}
					</button>
				</div>
			</div>
		</form>
    </#if>
</@layout.registrationLayout>

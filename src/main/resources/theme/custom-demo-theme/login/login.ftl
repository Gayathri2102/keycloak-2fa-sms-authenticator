<#import "template.ftl" as layout>
<link href="resources/css/register.css">

<link href="resources/css/common.css">
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))?no_esc}
    <#elseif section = "header">
		<img id="cancelimg" />
		<div class="title">
            ${msg("Email & password",(realm.displayNameHtml!''))?no_esc}
			<p id="kc-header-p">
				This information will be used when two-factor authentication is enabled
			</p>
		</div>
    <#elseif section = "form">
        <#if realm.password>
			<form id="kc-form-login" class="form ${properties.kcFormClass!}" action="${url.loginAction}" method="post">
				<input type="text" id="username" name="username" placeholder="Email" value="${(login.username!'')}"  autofocus autocomplete="off" required <#if usernameEditDisabled??>disabled</#if>>
				<div>
					<br/>
					<div style="position: absolute; height: 56px;width: 100%">
						<input type="password" id="password" name="password" autocomplete="off" minlength="2" placeholder="Password" required>
					</div>
					<div onclick="togglePasswordFunc()" style="position: absolute; z-index: 9; margin: 18px 40px; right: 0; color: #ffffff; font-family: sfPro; text-align: end;">
						Show
					</div>
				</div>
				<br/><br/><br/><br/>
				<button class="mdc-button mdc-button--raised ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit">
                    ${msg("doLogIn")}
				</button>
				<div id="kc-registration" class="col-xs-12" <#if realm.password && realm.registrationAllowed && !usernameEditDisabled?? && realm.resetPasswordAllowed>style="margin-bottom: 15px;"</#if>>
					<span style="color: white">${msg("noAccount")} <a class="mdc-button mdc-ripple-upgraded" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
				</div>
			</form>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && social.providers??>
			<div id="kc-social-providers">
				<ul>
                    <#list social.providers as p>
						<li><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span class="text">${p.displayName}</span></a></li>
                    </#list>
				</ul>
			</div>
        </#if>
    </#if>
</@layout.registrationLayout>

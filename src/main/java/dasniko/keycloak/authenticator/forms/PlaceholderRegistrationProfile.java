package dasniko.keycloak.authenticator.forms;


import org.keycloak.Config;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.authentication.FormAction;
import org.keycloak.authentication.FormActionFactory;
import org.keycloak.authentication.FormContext;
import org.keycloak.authentication.ValidationContext;
import org.keycloak.authentication.forms.RegistrationPage;
import org.keycloak.events.Details;
import org.keycloak.events.Errors;
import org.keycloak.events.EventType;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.models.*;
import org.keycloak.models.utils.FormMessage;
import org.keycloak.protocol.oidc.OIDCLoginProtocol;
import org.keycloak.provider.ProviderConfigProperty;
import org.keycloak.services.messages.Messages;
import org.keycloak.services.validation.Validation;
import org.keycloak.userprofile.UserProfile;
import org.keycloak.userprofile.UserProfileContext;
import org.keycloak.userprofile.UserProfileProvider;

import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 * Based on org.keycloak.authentication.forms.RegistrationProfile
 */
public class PlaceholderRegistrationProfile implements FormAction, FormActionFactory {


	private static final String TPL_CODE = "regmobilenumber.ftl";
	public static final String PROVIDER_ID = "pl-spi-registration-profile"; // MAX 36 chars !!!!

	@Override
	public String getHelpText() {
		return "Validates email and stores it in user data.";
	}

	@Override
	public List<ProviderConfigProperty> getConfigProperties() {
		return null;
	}

	@Override
	public void validate(ValidationContext context) {
		MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
		List<FormMessage> errors = new ArrayList<>();

		context.getEvent().detail(Details.REGISTER_METHOD, "form");
		String eventError = Errors.INVALID_REGISTRATION;

//        if (Validation.isBlank(formData.getFirst((RegistrationPage.FIELD_FIRST_NAME)))) {
//            errors.add(new FormMessage(RegistrationPage.FIELD_FIRST_NAME, Messages.MISSING_FIRST_NAME));
//        }
//
//        if (Validation.isBlank(formData.getFirst((RegistrationPage.FIELD_LAST_NAME)))) {
//            errors.add(new FormMessage(RegistrationPage.FIELD_LAST_NAME, Messages.MISSING_LAST_NAME));
//        }


		String email = formData.getFirst(Validation.FIELD_EMAIL);
		String password = formData.getFirst(Validation.FIELD_PASSWORD);
		System.out.println("===>FIELD_PASSWORD"+ password);
		formData.add(Validation.FIELD_PASSWORD_CONFIRM, password);
		String confirmPassword =  formData.getFirst(Validation.FIELD_PASSWORD_CONFIRM);
		System.out.println("===>FIELD_PASSWORD_CONFIRM"+ confirmPassword);
		System.out.println("===>email"+ email);

		boolean emailValid = true;
		if (Validation.isBlank(email)) {
			errors.add(new FormMessage(RegistrationPage.FIELD_EMAIL, Messages.MISSING_EMAIL));
			emailValid = false;
		} else if (!Validation.isEmailValid(email)) {
			context.getEvent().detail(Details.EMAIL, email);
			errors.add(new FormMessage(RegistrationPage.FIELD_EMAIL, Messages.INVALID_EMAIL));
			emailValid = false;
		}

		if (emailValid && !context.getRealm().isDuplicateEmailsAllowed() && context.getSession().users().getUserByEmail(email, context.getRealm()) != null) {
			eventError = Errors.EMAIL_IN_USE;
			formData.remove(Validation.FIELD_EMAIL);
			context.getEvent().detail(Details.EMAIL, email);
			errors.add(new FormMessage(RegistrationPage.FIELD_EMAIL, Messages.EMAIL_EXISTS));
		}

		if (errors.size() > 0) {
			context.error(eventError);
			context.validationError(formData, errors);
			return;

		} else {
			context.success();
		}
	}

	@Override
	public void success(FormContext context) {
		MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();

		String email = formData.getFirst(UserModel.EMAIL);
		String username = formData.getFirst(UserModel.USERNAME);

		if (context.getRealm().isRegistrationEmailAsUsername()) {
			username = email;
		}

		context.getEvent().detail(Details.USERNAME, username)
			.detail(Details.REGISTER_METHOD, "form")
			.detail(Details.EMAIL, email);

		KeycloakSession session = context.getSession();

		UserProfileProvider profileProvider = session.getProvider(UserProfileProvider.class);
		UserProfile profile = profileProvider.create(UserProfileContext.REGISTRATION_USER_CREATION, formData);
		UserModel user = profile.create();

		user.setEnabled(true);

		context.setUser(user);

		context.getAuthenticationSession().setClientNote(OIDCLoginProtocol.LOGIN_HINT_PARAM, username);

		context.getEvent().user(user);
		context.getEvent().success();
		context.newEvent().event(EventType.LOGIN);
		context.getEvent().client(context.getAuthenticationSession().getClient().getClientId())
			.detail(Details.REDIRECT_URI, context.getAuthenticationSession().getRedirectUri())
			.detail(Details.AUTH_METHOD, context.getAuthenticationSession().getProtocol());
		String authType = context.getAuthenticationSession().getAuthNote(Details.AUTH_TYPE);
		if (authType != null) {
			context.getEvent().detail(Details.AUTH_TYPE, authType);
		}
	}

	@Override
	public void buildPage(FormContext context, LoginFormsProvider form) {
		// complete
System.out.println("===========> creating registering ");
	try {
			//context.challenge(context.form().setAttribute("realm", context.getRealm()).createForm(TPL_CODE));
			form.setAttribute("realm", context.getRealm()).createForm(TPL_CODE);

	} catch (Exception e) {

		System.out.println("===========> creating registering "+e.getMessage());

	}
	}

	@Override
	public boolean requiresUser() {
		return false;
	}

	@Override
	public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
		return true;
	}

	@Override
	public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {

	}

	@Override
	public boolean isUserSetupAllowed() {
		return false;
	}


	@Override
	public void close() {

	}

	@Override
	public String getDisplayType() {
		return "Placeholder Profile Validation";
	}

	@Override
	public String getReferenceCategory() {
		return null;
	}

	@Override
	public boolean isConfigurable() {
		return false;
	}

	private static AuthenticationExecutionModel.Requirement[] REQUIREMENT_CHOICES = {
		AuthenticationExecutionModel.Requirement.REQUIRED,
		AuthenticationExecutionModel.Requirement.DISABLED
	};
	@Override
	public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
		return REQUIREMENT_CHOICES;
	}
	@Override
	public FormAction create(KeycloakSession session) {
		return this;
	}

	@Override
	public void init(Config.Scope config) {

	}

	@Override
	public void postInit(KeycloakSessionFactory factory) {

	}

	@Override
	public String getId() {
		return PROVIDER_ID;
	}
}

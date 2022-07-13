package dasniko.keycloak.authenticator.gateway;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Map;
import java.util.Properties;

public class TelnyxSmsService implements SmsService{

	private static final String YOUR_TELNYX_NUMBER = System.getenv("TELNYX_NUMBER");
	private static final String YOUR_TELNYX_API_KEY = System.getenv("TELNYX_AUTH_TOKEN");

	private final String senderId;

	TelnyxSmsService(Map<String, String> config) {
		senderId = config.get("senderId");
	}

	@Override
	public  void send(String phoneNumber, String message) throws IOException, InterruptedException {

		try (InputStream input = TelnyxSmsService.class.getClassLoader().getResourceAsStream("config.properties")) {

			Properties prop = new Properties();

			if (input == null) {
				System.out.println("Sorry, unable to find config.properties");
				return;
			}

			//load a properties file from class path, inside static method
			prop.load(input);

			//get the property value
			String YOUR_TELNYX_NUMBER = prop.getProperty("TELNYX_NUMBER");
			String YOUR_TELNYX_API_KEY = prop.getProperty("TELNYX_AUTH_TOKEN");

			String requestBody = "{\"from\": \"" + YOUR_TELNYX_NUMBER + "\",    \"to\": \"" + phoneNumber + "\",    \"text\": \"" + message + "\",     \"type\" : \"SMS\"  }";

			HttpClient client = HttpClient.newHttpClient();
			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(
					"https://api.telnyx.com/v2/messages"
				)).POST(HttpRequest.BodyPublishers.ofString(requestBody)
				).header("Content-Type", "application/json").header("Accept", "application/json")
				.header("Authorization", YOUR_TELNYX_API_KEY)
				.build();

			HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
			System.out.println("response:" + response.body());

		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}

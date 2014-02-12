note
	description: "Summary description for {FACEBOOK_TEST}."
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_TEST

create
	make


feature {NONE} -- Initialization

	make
		local
			facebook : OAUTH_20_FACEBOOK_API
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token : detachable OAUTH_TOKEN
			json_factory : FACEBOOK_JSON_FACTORY
			user : detachable FACEBOOK_USER
			app_data : FACEBOOK_APP_SPECIFIC_DATA
		 	empty_token : detachable  OAUTH_TOKEN
		do
			create {TEST_FACEBOOK_APP_SPECIFIC_DATA} app_data
			create config.make_default (app_data.api_key, app_data.api_secret)



			config.set_callback (app_data.callback)
			config.set_scope (app_data.permissions)
			create facebook
			api_service := facebook.create_service (config)
			print ("%N=== My Facebook OAuth Workflow ===%N");

				-- Obtain the Authorization URL
			print ("%NFetching the Authorization URL...");
			if attached api_service.authorization_url (empty_token) as lauthorization_url then
				print ("%NGot the Authorization URL!%N");
				print ("%NNow go and authorize here:%N");
				print (lauthorization_url);
				print ("%NAnd paste the authorization code here%N");
				io.read_line
			end
			access_token := api_service.access_token_get (empty_token, create {OAUTH_VERIFIER}.make (io.last_string))
			if attached access_token as l_access_token then
				print ("%NGot the Access Token!%N");
				print ("%N(Token: " + l_access_token.debug_output + " )%N");

					--Now let's go and ask for a protected resource!
				print ("%NNow we're going to access a protected resource...%N");
				create request.make ("GET", protected_resource_url)
				request.add_header ("Authorization", "Bearer " + l_access_token.token)
				api_service.sign_request (l_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					print ("%NOk, let see what we found...")
					print ("%NResponse: STATUS" + l_response.status.out)
					if attached l_response.body as l_body then
						print ("%NBody:" + l_body)
						create json_factory
						user := json_factory.user_from_string (l_body)
						if attached user as u then
							print ("%NUser ID: " + u.id.out)
							print ("%NUser name: " + u.name)
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	protected_resource_url : STRING = "https://graph.facebook.com/me"

note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

note
	description: "[
				This class implements login to Facebook and then get some data from the users account.
				This example has used (2014-02-12 version) the step 4 of the turorial of EWF as a start.
				For details about the web server specific code look at that tutorial.
			]"

class
	HELLO_APP

inherit
	WSF_ROUTED_SERVICE

	WSF_DEFAULT_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	setup_router
		do
			map_agent_uri ("/test", agent execute_test, Void)
			map_agent_uri ("/login", agent execute_login, Void)
		end

feature -- Helper: mapping

	map_agent_uri (a_uri: READABLE_STRING_8; a_action: like {WSF_URI_AGENT_HANDLER}.action; rqst_methods: detachable WSF_REQUEST_METHODS)
		do
			router.map_with_request_methods (create {WSF_URI_MAPPING}.make (a_uri, create {WSF_URI_AGENT_HANDLER}.make (a_action)), rqst_methods)
		end

feature -- Execution

	execute_test (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Computed response message.
		local
			mesg: WSF_HTML_PAGE_RESPONSE
			s: STRING_8
			facebook : OAUTH_20_FACEBOOK_API
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			app_data : TEST_FACEBOOK_APP_SPECIFIC_DATA
		 	empty_token : detachable  OAUTH_TOKEN
			redir: WSF_HTML_DELAYED_REDIRECTION_RESPONSE
			html: WSF_HTML_PAGE_RESPONSE

		do
			create app_data
			create config.make_default (app_data.api_key, app_data.api_secret)
			config.set_callback (app_data.callback)
			config.set_scope (app_data.permissions)
			create facebook
			api_service := facebook.create_service (config)

			if attached api_service.authorization_url (empty_token) as lauthorization_url then
				create redir.make (lauthorization_url.to_string_8, 5)
				create html.make
				redir.set_title ("Login with Facebook example")
				redir.set_body ("Login to facebook ,<br/> see you soon again.<p>You will be redirected to " +
								redir.url_location + " in " + redir.delay.out + " second(s) ...</p>"
						)
				res.send (redir)
			else
				create mesg.make
				mesg.set_title ("Facebook example error! ")
				s := (create {HTML_ENCODER}).encoded_string ({STRING_32} "Did not get facebook authorization url. Check implementation of OAUTH_20_FACEBOOK_API and feature authorization_url ")
				mesg.set_body (s)
				res.send (mesg)
			end
		end

	execute_login (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Computed response message.
		local
			mesg: WSF_HTML_PAGE_RESPONSE
			s: STRING_8
			facebook : OAUTH_20_FACEBOOK_API
			config : OAUTH_CONFIG
			api_service : OAUTH_SERVICE_I
			request : OAUTH_REQUEST
			access_token : detachable OAUTH_TOKEN
			json_factory : FACEBOOK_JSON_FACTORY
			user : detachable FACEBOOK_USER
			app_data : TEST_FACEBOOK_APP_SPECIFIC_DATA
		 	empty_token : detachable  OAUTH_TOKEN

			do
			create mesg.make
				mesg.set_title ("Login with Facebook example")
				s := (create {HTML_ENCODER}).encoded_string ({STRING_32} " code:  " )
				if attached req as r then
					if attached r.query_parameter ("code") as w_s then
						s.append (  w_s.as_string.value + "<br>")

-- Can I create these variables again or must I keep the original that was earlier created? It works at least in this example.
						create app_data
						create config.make_default (app_data.api_key, app_data.api_secret)
						config.set_callback (app_data.callback)
						config.set_scope (app_data.permissions)
						create facebook
						api_service := facebook.create_service (config)


						s.append ("<p>Try to get access token!</p>")
						access_token := api_service.access_token_get (empty_token, create {OAUTH_VERIFIER}.make ( w_s.as_string.value))
						if attached access_token as l_access_token then
							s.append ("<p>Got access token!</p>")
							create request.make ("GET", protected_resource_url)
							request.add_header ("Authorization", "Bearer " + l_access_token.token)
							api_service.sign_request (l_access_token, request)
							if attached {OAUTH_RESPONSE} request.execute as l_response then
								s.append ("<p>Response: STATUS" + l_response.status.out + " from request.execute</p>")
								if attached l_response.body as l_body then
									s.append("<p>Body:" + l_body + "</p>")
									create json_factory
									user := json_factory.user_from_string (l_body)
									if attached user as u then
										s.append ("<p>   User ID: " + u.id.out + "</p>")
										s.append ("<p>   User name: " + u.name + "</p>")
									end
								end
							else
								s.append ("<p>request.execute failed!</p>")
							end
						else
							s.append ("<p>Get access token failed! Feature api_service.access_token_get failed.</p>")
						end
					end
				end
				mesg.set_body (s)
				res.send (mesg)
		end
	protected_resource_url : STRING = "https://graph.facebook.com/me"


feature {NONE} -- Initialization

	initialize
		do

			set_service_option ("port", 9898)

				--| If you don't need any custom options, you are not obliged to redefine `initialize'
			Precursor

				--| Initialize router
			initialize_router
		end


end

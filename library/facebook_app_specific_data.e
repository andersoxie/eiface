note
	description: "OAuth Data required for Facebook"
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "Login-Flow",  "src=https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow/", "protocol=uri"
	EIS: "Permissions", "src= https://developers.facebook.com/docs/reference/login/", "protocol=uri"


deferred class
	FACEBOOK_APP_SPECIFIC_DATA

feature

	api_key : STRING
			-- Facebook apps key. A long string of 0-9
		deferred
		end

	api_secret :STRING
			-- Facebook apps secret key. A ling string of characters
		deferred
		end

	callback : STRING
			-- For example yuor Facebook apps canvas adess. Read more at
			-- https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow/
		deferred
		end

	permissions : STRING
			-- For example "publish_actions"
			-- One can read about the possible permissions at
			-- https://developers.facebook.com/docs/reference/login/
		deferred
		end
note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

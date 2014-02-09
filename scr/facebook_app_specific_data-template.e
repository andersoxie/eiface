note
	description: "Summary description for {FACEBOOK_APP_SPECIFIC_DATA_TEMPLATE}."
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_APP_SPECIFIC_DATA_TEMPLATE

feature

	api_key : STRING =""
	-- Facebook apps key. A long string of 0-9

	api_secret :STRING =""
	-- Facebook apps secret key. A ling string of characters

	callback : STRING =""
	-- For example yuor Facebook apps canvas adess. Read more at
	-- https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow/

	permissions : STRING = "" -- For example "publish_actions"
	-- One can read about the possible permissins at
	-- https://developers.facebook.com/docs/reference/login/

note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	FACEBOOK_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
--			assert ("not_implemented", False)
		end

	on_clean
			-- <Precursor>
		do
--			assert ("not_implemented", False)
		end

feature -- Test routines

	test_facebook_user
			-- New test routine
		local
			json_factory : FACEBOOK_JSON_FACTORY
			user : detachable FACEBOOK_USER
		do
			create json_factory
			user := json_factory.user_from_string (json_data_from_facebook)
			if attached user as u then
				assert ("Did not get user id", user.id.is_equal ("100000638559234"))
				assert ("Did not get name", user.name.is_equal ("First Second"))
			else
				assert("User not attached to user", false)
			end
		end


--		json_data_from_facebook : STRING = "{%"id%": %"100000638559234%"}"
	json_data_from_facebook : STRING = "{%"id%": %"100000638559234%",%"name%": %"First Second%",%"first_name%": %"First%",%"last_name%": %"Second%",%"link%": %"https://www.facebook.com/first.second.925%",%"work%": [{%"employer%": {%"id%": %"258154631234%",%"name%": %"BSharp AB%"}}],%"favorite_teams%": [{%"id%": %"391607047581345%",%"name%": %"Team%"}],%"favorite_athletes%": [{%"id%": %"111575292289234%",%"name%": %"Fav Atl%"}],%"education%": [{%"school%": {%"id%": %"16726059345%",%"name%": %"ABC%"},%"type%": %"College%"},%"{%"school%": {%"id%": %"126404914095345%",%"name%": %"ECB%"},%"type%": %"College%"}],%"gender%": %"male%",%"timezone%": 1,%"locale%": %"sv_SE%",%"verified%": true,%"updated_time%": %"2013-12-27T09%":41%":12+0000%",%"username%": %"first.last.925%"}"

note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end



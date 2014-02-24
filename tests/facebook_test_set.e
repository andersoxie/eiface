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

	test_facebook_friend_list
			-- From a JSON answer I get an array of friends.
		local
			json_factory : FACEBOOK_JSON_FACTORY
			user : detachable FACEBOOK_USER
			file_with_friends : RAW_FILE
			json_data_friend_list : STRING_8
			my_friends : detachable  ARRAY [FACEBOOK_USER]
		do
			create file_with_friends.make_open_read ("friendsdata.txt")
			file_with_friends.read_line
			json_data_friend_list := file_with_friends.last_string
			create json_factory

			my_friends := json_factory.list_of_friends_from_string (json_data_friend_list)
			if attached my_friends as my_f then
				assert ("Should get 201 friends", my_f.count.is_equal (201))
			else
				assert("Did not get list", false)
			end
		end

	test_next_page_from_friends_lists
			-- When getting a lot of data each json might not contain all data. Then one can get a "next"-link to get the next set of data.
		local
			json_factory : FACEBOOK_JSON_FACTORY
			next_page : detachable FACEBOOK_NEXT_PAGING
			file_with_friends : RAW_FILE
			json_data_friend_list : STRING_8
		do
			create file_with_friends.make_open_read ("friendsdata.txt")
			file_with_friends.read_line
			json_data_friend_list := file_with_friends.last_string
			create json_factory

			next_page := json_factory.next_page_from_string (json_data_friend_list)
			if attached next_page as n then
				assert ("Should not be an empty string",  n.http_link.count > 10 )
				assert ("Should start with http",  n.http_link.substring (1, 4).is_equal ("http") )
			else
				assert("Next page not found", false)
			end
		end

		test_next_page_from_post_data
				-- Checking that next link is available in posts that.
			local
				json_factory : FACEBOOK_JSON_FACTORY
				next_page : detachable FACEBOOK_NEXT_PAGING
				file_with_friends : RAW_FILE
				json_data_friend_list : STRING_8
			do
				create file_with_friends.make_open_read ("postdata.txt")
				file_with_friends.read_line
				json_data_friend_list := file_with_friends.last_string
				create json_factory

				next_page := json_factory.next_page_from_string (json_data_friend_list)
				if attached next_page as n then
					assert ("Should not be an empty string",  n.http_link.count > 10 )
					assert ("Should start with http",  n.http_link.substring (1, 4).is_equal ("http") )
				else
					assert("Next page not found", false)
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



note
	description: "Summary description for {TEST_FACEBOOK_APP_SPECIFIC_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_FACEBOOK_APP_SPECIFIC_DATA

inherit

	FACEBOOK_APP_SPECIFIC_DATA

feature -- Access

	api_key : STRING = ""
			-- <Precursor>

	api_secret :STRING = ""
			-- <Precursor>

	callback : STRING = ""
			-- <Precursor>

	permissions : STRING = ""
			-- <Precursor>
end

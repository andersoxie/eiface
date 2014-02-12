note
	description : "tests application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			 l_face_test: FACEBOOK_TEST
		do
			create l_face_test.make
		end

end

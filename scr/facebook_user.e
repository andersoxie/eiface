note
    description:"Summary description for {FACEBOOK_USER}."
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_USER

inherit
	FACEBOOK_ID_NAME
		redefine
			make_with_id
		end

create
	make_empty

create
	make_with_id

feature {NONE} -- Creation

	make_with_id (a_id: like id)
		do
			Precursor (a_id)
			create email.make_empty
			create photo.make_empty
		end

feature -- Access


	email: STRING assign set_email
		-- The user's email address.

	photo: STRING assign set_photo
		-- The user's photo.

feature -- Element modification

	set_email (value: STRING)
			-- Set `email' to `value'
		do
			email := value
		end

	set_photo (value: STRING)
			-- Set `photo' to `value'
		do
			photo := value
		end

note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

note
	description: "A user represents a person on Facebook."
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "User", "src=https://developers.facebook.com/docs/graph-api/reference/user/", "protocol=uri"
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

	set_email (a_value: STRING)
			-- Set `email' to `a_value'
		do
			email := a_value
		ensure
			email_set:  email = a_value
		end

	set_photo (a_value: STRING)
			-- Set `photo' to `a_value'
		do
			photo := a_value
		ensure
			photo_set: photo = a_value
		end

note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		BSharp AB
	]"

end

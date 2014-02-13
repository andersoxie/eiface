note
	description: "Summary description for {FACEBOOK_ID_NAME}."
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_ID_NAME

create
	make_empty,
	make_with_id

feature {NONE} -- Creation

	make_with_id (an_id: like id)

			-- Create current object with `an_id'.
		do
			set_id (an_id)
			create name.make_empty
		ensure
			id_set: id = an_id
		end

	make_empty
			-- Create an empty project object
		do
			make_with_id ("0")
		ensure
			id_set_to_zero: id.same_string ("0")
		end

feature -- Access

	id: STRING assign set_id
			-- Id of the entity

	name: STRING assign set_name
			-- Name of the entity.

feature -- Change	

	set_id (a_value: like id)
			-- Set `id' to `a_value'
		do
			id := a_value
		ensure
			id_set: id = a_value
		end

	set_name (a_value: like name)
			-- Set `name' to `a_value'
		do
			name := a_value
		ensure
			name_set: name = a_value
		end


note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

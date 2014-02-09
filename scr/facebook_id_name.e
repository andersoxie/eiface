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
		end

	make_empty
			-- Create an empty project object
		do
			make_with_id ("0")
		end

feature -- Access

	id: STRING assign set_id
			-- Id of the entity

	name: STRING assign set_name
			-- Name of the entity.

feature -- Change	

	set_id (value: like id)
			-- Set `id' to `value'
		do
			id := value
		end

	set_name (value: like name)
			-- Set `name' to `value'
		do
			name := value
		end


note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

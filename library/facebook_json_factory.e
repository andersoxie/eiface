note
    description: "[
                  Object factory for JSON sourced Facebook objects
]"
	author: "Anders Persson"
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_JSON_FACTORY

feature -- Factory: user

	user_from_string (response: detachable READABLE_STRING_8): detachable FACEBOOK_USER
			--
		do
			if attached json_object_data_from_string (response) as json then
				Result := user_from_json (json)
			end
		end

	next_page_from_string (response: detachable READABLE_STRING_8): detachable FACEBOOK_NEXT_PAGING
				-- When getting data from Facebook it might be a lot. If it goes over a certain limit the JSON includes a "next"-link that can be used to get more data.
		do
			if attached json_paging_from_string (response) as json then
				Result := next_page_from_json (json)
			end
		end

	user_from_json (json: JSON_OBJECT): detachable FACEBOOK_USER
			-- User from `json' object if well formed.
		do
			-- TODO Might be that we need to use other type of STRING to handle all character sets
			if json.has_key ("id") then
				if attached id_from_json ("id", json) as id then
					create Result.make_with_id (id)
				end
				if attached string_from_json ("name", json) as l_name and attached Result then
					Result.set_name (l_name)
				end
			end
		end

	list_of_friends_from_string (response: detachable READABLE_STRING_8):  ARRAY[FACEBOOK_USER]
			-- List of friends in this JSON. It might be that one have more friends. Check with "next_page_from_string"
		local
			j_array : detachable JSON_ARRAY
			iterator : ITERATION_CURSOR [JSON_VALUE]
			value : JSON_VALUE
			f_user : detachable FACEBOOK_USER
			i :INTEGER
		do
			i := 1
			j_array := json_array_data_from_string (response)
			create Result.make_empty

			if attached j_array as j_a then
				from
					iterator := j_a.new_cursor
				until
					iterator.after
				loop
					value := iterator.item
					if attached {JSON_OBJECT}value as v then
						f_user := user_from_json (v)
						if attached f_user as f then
							-- If it is not possible to read a certain value it is just ignored.
							Result.force (f, i)
							i:=i+1
						end
					end
					iterator.forth
				end
			end
		end

	next_page_from_json (json: JSON_OBJECT): detachable FACEBOOK_NEXT_PAGING
			-- User from `json' object if well formed.
		do
			if attached string_from_json ("next", json) as link then
				create Result.make (link)
			end
		end


feature {NONE} -- JSON helper -- TODO Might be moved to a common ancestor with eiasan

	json_object_data_from_string (s: detachable READABLE_STRING_8): detachable JSON_OBJECT
			-- JSON_OBJECT object from json string `s'.	
		local
			parser: JSON_PARSER
		do
			if attached s then
				create parser.make_parser (s)
				if
					parser.is_parsed and then
					attached parser.parse_object as json_doc
				then
					Result := json_doc
				else
					check well_formed_json_data: False end
				end
			end
		end

	json_array_data_from_string (s: detachable READABLE_STRING_8): detachable JSON_ARRAY
			-- JSON_ARRAY object from json string `s'.
			--| the `data' item has to be a JSON Array, otherwise return Void
		local
			parser: JSON_PARSER
		do
			if attached s then
				create parser.make_parser (s)
				if
					parser.is_parsed and then
					attached parser.parse_object as json_doc
				then
					if attached {JSON_ARRAY} json_doc.item ("data") as json_data then
						Result := json_data
					else
						check has_json_array: False end
					end
				else
					check well_formed_json_data: False end
				end
			end
		end

	json_paging_from_string (s: detachable READABLE_STRING_8): detachable JSON_OBJECT
			-- JSON_OBJECT object from json string `s'.
		local
			parser: JSON_PARSER
		do
			if attached s then
				create parser.make_parser (s)
				if
					parser.is_parsed and then
					attached parser.parse_object as json_doc
				then
					if attached {JSON_OBJECT} json_doc.item ("paging") as json_data then
						Result := json_data
					else
						check has_json_array: False end
					end
				else
					check well_formed_json_data: False end
				end
			end
		end

	id_from_json (k: STRING; json: JSON_OBJECT): detachable STRING
			-- Asana ID value stored in json.item (k).
			-- currently represented as a STRING value.
		require
			json.has_key (k)
		do
			Result :=  string_from_json (k, json)
		end

	integer_64_from_json (k: STRING; json: JSON_OBJECT): INTEGER_64
			-- Integer value stored in json.item (k) if any.			
		do
			if attached {JSON_NUMBER} json.item (k) as j_number then
				Result := j_number.item.to_integer_64
			else
				check is_number: False end
				-- Catch any bad usage of the data
			end
		end

	boolean_from_json (k: STRING; json: JSON_OBJECT; dft: BOOLEAN): BOOLEAN
			-- Boolean stored in json.item (k) if any.		
			-- if no value is available return the default `dft' value.
		do
			if json.has_key (k) then
				if attached {JSON_BOOLEAN} json.item (k) as j_boolean then
					Result := j_boolean.item
				else
					check is_boolean: False end
				end
			else
				Result := dft
			end
		end

	string_from_json (k: STRING; json: JSON_OBJECT): detachable STRING
			-- String of text stored in json.item (k) if any.	
		do
			if json.has_key (k) then
				if attached {JSON_STRING} json.item (k) as j_string then
--					Result := create {UC_UTF8_STRING}.make_from_string (j_string.item)
					Result := j_string.item
				else
					check is_string_or_null: attached {JSON_NULL} json.item (k) end
						-- Catch any bad usage of the data
				end
			end
		end

note
	copyright: "2014, Anders Persson and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			BSharp AB
		]"
end

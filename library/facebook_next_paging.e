note
	description: "Summary description for {FACEBOOK_NEXT_PAGING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_NEXT_PAGING

create
	make

feature
	make( an_http_link : STRING )
	do
		http_link := an_http_link
	end


	http_link : STRING
end

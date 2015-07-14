# Configuration module holds all the configuration information of search engine.
# column_name holds the name of the model column on which search needs to be performed.
# limit holds the value of the maximum number of rows to be returned by the search result
module SearchEngine
	module Configuration
		allowed_keys = [:model_name,:column_name,:limit,:sql_query]

		def configure(options)
			@configuration = options
		end
	end
end
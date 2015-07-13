module SearchEngine
	module Configuration
		allowed_keys = [:model_name,:column_name,:limit]

		def configure(options)
			@configuration = options
		end
	end
end
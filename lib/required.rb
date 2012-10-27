module FormProcessor
	# Checks to make sure all required fields are present and accounted for.
	class Required
		# A String with the list of missing fields.
		attr_reader :result
		# Expects a Hash passed from Main.
		def initialize(values)
			@values = values
			@result = String.new
			run
		end
		private
		def run
			if @values.has_key? 'required'
				@values['required'].to_s.split(',').each do |val|
					val.strip!
					if !@values.has_key? val or @values[val].empty?
						if @result.length == 0 then @result = 'You forgot to fill in the following required fields:<br />' end
						@result += val.capitalize + '<br />'
					end
				end
			end
		end
	end
end
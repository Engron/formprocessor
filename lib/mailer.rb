module FormProcessor
	# Sends an email with form results to the address specified in "mailto".
	# A valid SMTP server running on localhost is required.
	class Mailer
		# Expects a Hash value and String for the email body passed from Main.
		def initialize(values,output)
			@values = values
			@output = output
			run
		end
		private
		def run
			msg = <<END_OF_MESSAGE
From: Automated Form Mailer <#{@values['mailto']}>
To: <#{@values['mailto']}>
Content-type: text/html
Subject: #{@values['subject']}

#{@output}
END_OF_MESSAGE
			Net::SMTP.start('localhost') do |smtp|
				smtp.send_message(msg,@values['mailto'],@values['mailto'])
				smtp.finish
			end
		end
	end
end
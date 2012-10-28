Gem::Specification.new do |s|
	s.name = "formprocessor"
	s.summary = "Process web forms and have the results emailed to you."
	s.description = File.read(File.join(File.dirname(__FILE__), 'README'))
	s.requirements = ['An SMTP server running on localhost']
	s.version = "0.0.4"
	s.author = "Kenton Small"
	s.email = "kentonthegreat@gmail.com"
	s.homepage = "http://www.kentonsmall.com"
	s.platform = Gem::Platform::RUBY
	s.required_ruby_version = '>=1.9'
	s.files = Dir['lib/*.rb']
	s.license = 'MIT'
	s.post_install_message = 'Thanks for installing! If you have any questions please feel free to contact me. http://www.kentonsmall.com'
end
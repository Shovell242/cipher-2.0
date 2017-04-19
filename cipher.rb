class Cipher
	attr_reader :file, :offset, :text

	KEY = ("a".."z").to_a

	def initialize(file, offset)
		@file   = file
		@offset = offset
		@text   = ""
		append_text
		cipher
	end

	def append_text
		text << File.read(file)
	end

	def cipher
		text.each_char.with_index do |letter, i|
			dcase = letter.downcase
			if KEY.include?(dcase)
				new_char = KEY[(KEY.index(dcase) + offset) % 26]
				final = letter == letter.upcase ? new_char.upcase : new_char
				text[i] = final
			end
		end
	end
end

class UserPrompt
	attr_reader :file_name, :file_offset, :cipher

	def initialize
		@file_name   = getfile
		@file_offset = get_offset
		@cipher      = Cipher.new(file_name, file_offset)
		export
	end

	def getfile
		print "Please enter the filename of the file you want to cipher: > "
		file = gets.chomp
		File.exist?(file) ? file : failure
	end

	def get_offset
		print "Please enter the numerical offset you would like to apply to your text file: > "
		gets.chomp.to_i
	end

	def failure
		puts "I'm sorry, that file could not be found"
		getfile
	end

	def export
		File.open("#{file_name}_ciphered.txt", "w") { |f| f.write(cipher.text) }
		puts "Your ciphered file has been exported!"
	end
end

UserPrompt.new










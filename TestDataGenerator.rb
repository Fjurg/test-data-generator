# Create testdata files of a certain size
# TODO:
#	Build simple GUI to simplify

class TestDataGenerator

	def initialize
		@desired_file_size = 0
		@format = ''
		@is_valid_format = false
	end
	
	def decide_format_and_size(desired_file_size, format)
	
		kib = 1024
		kb = 1000	
		formats = {
					:kib => kib,
					:mib => kib * kib,
					:kb => kb,
					:mb => kb * kb
					}
		
		
		formats.each { |key, val|
			if key.to_sym.eql? format.to_sym
				@desired_file_size = desired_file_size * val
				@is_valid_format = true unless @is_valid_format
			end
		}


	end

	def write_to_file()
		
		some = 5

		file_name = Time.now.strftime('%h_%d_%Y_%s') + '_testDataFile.txt'
		file = File.new(file_name, 'a')
		current_file_size = File.stat(file_name).size
		
		while current_file_size <= @desired_file_size
			file.write('O') unless current_file_size == @desired_file_size
			current_file_size += 1
		end
		if @is_valid_format
			puts 'SUCCESS!'
			puts "File created in folder: #{Dir.pwd}"
			sleep some
		else
			puts 'Something went wrong'
			sleep some
		end
	end
	
end

size = ARGV[0]
format = ARGV[1]

abort 'Sample usage: ruby TestDataGenerator.rb 50 kib' if ARGV[0] == nil
puts 'Trying to create file...'

test_gen = TestDataGenerator.new
test_gen.decide_format_and_size(size.to_i, format)
test_gen.write_to_file
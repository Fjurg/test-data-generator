# Create testdata files of a certain size
# TODO:
#	Build simple GUI to simplify

class TestDataGenerator

	def initialize()
		@file_name = Time.now.strftime("%h_%d_%Y_%s") + "_testDataFile.txt"
		@desired_file_size = 0
		@format = ""
		@is_valid_format = false
	end
	
	def decide_format_and_size(desired_file_size, format)
	
		kib = 1024
		kb = 1000	
		formats = {
					"kib" => kib,
					"mib" => kib * kib,
					"kb" => kb,
					"mb" => kb * kb
					}
		
		
		formats.each do |key, val|
			if key.eql? format
				@desired_file_size = desired_file_size * val
				puts @desired_file_size
			end
		end
		
		@is_valid_format = true
		
	end
	
	def write_to_file()
		
		some = 5
		
		file = File.new(@file_name, "a")
		current_file_size = File.stat(@file_name).size
		
		while current_file_size <= @desired_file_size
			file.write("O") unless current_file_size == @desired_file_size
			current_file_size += 1
		end
		if @is_valid_format
			puts "SUCCESS!"
			puts "File created in folder: #{Dir.pwd}"
			sleep some
		else
			"Something went wrong"
			sleep some
		end
	end
	
end

size = ARGV[0]
format = ARGV[1]
if ARGV[0] == nil
	abort "Sample usage: ruby TestDataGenerator.rb 50 kib"
end
test_gen = TestDataGenerator.new
puts "Trying to create file..."
test_gen.decide_format_and_size(size.to_i, format)
test_gen.write_to_file
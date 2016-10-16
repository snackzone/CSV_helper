require('CSV')

class CSVParser
  attr_accessor :filepath

  def initialize(filepath)
    @filepath = filepath
    @errors = []
  end

  def errors
    validate!
    @errors
  end

  def print_errors
    errors.each do |message, line_number|
      puts "#{message} on line #{line_number}"
    end
  end

  def is_valid?
    validate!
    print_errors
    errors.empty?
  end

  private

  def validate!
    @errors = []
    File.readlines(filepath).each_with_index do |line, index|
      begin
        line.strip.split ','
      rescue ArgumentError => e
        @errors << [e.message, index + 1]
      end
    end
  end
end

#
# Crazy class to play with some shizzle
#

# Conversion of Coordinates
module GPS

  # class methods
  def self.get_longitude lng, d
    lng = -lng if d == 'W'
    degrees = (lng/100).to_i
    minutes = lng - (degrees*100)
    degrees + (minutes/60)
  end

  def self.get_latitude lat, d
    lat = -lat if d == 'S'
    degrees = (lat/100).to_i
    minutes = lat - (degrees*100)
    degrees + (minutes/60)
  end

  # Record model
  class Record

    attr_accessor :time, :longitude, :latitude, :satellites, :altitude

    def initialize *args
      args.first.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

  end

  # Main GPS Parsing class
  class Parser

    attr_accessor :records

    def initialize
      @records = []
    end

    # pull in the raw GPS data file
    def load_gps_strings file
      @f = File.open(file, 'r')
      # return self so that we can chain
      self
    end

    # parse NMEA sentences to nice looking records
    def parse_gps
      # raise exception if we haven't opened the file yet
      raise Exception, 'You need to open the GPS file first' unless @f
      # iterate over each line, split the sentence by comma
      # create a new Record
      # append to @records array
      @f.readlines.each do |l|
        a = l.split(',')
        @records << GPS::Record.new(
          :time =>       a[1],
          :longitude =>  GPS::get_longitude(a[2].to_f,a[3]),
          :latitude =>   GPS::get_latitude(a[4].to_f,a[5]),
          :satellites => a[7].to_i,
          :altitude =>   a[9].to_f
        )
      end
    end

  end
  
end
require 'rspec'
require 'gps_parser.rb'

describe 'GPS Parser' do

  describe 'Longitude Parser' do
    it 'should convert a longitude to a decimal' do
      result = GPS::parse_longitude '00021.9653'.to_f, 'W'
      result.should be_a Float
    end
  end

  describe 'Latitude Parser' do
    it 'should convert a latitude to a decimal' do
      result = GPS::parse_latitude '00021.9653'.to_f, 'N'
      result.should be_a Float
    end
  end

  describe 'Time Parser' do

    it 'should convert a GPS time into a proper Ruby time object' do
      File.open 'spec/lib/test_gps_data.txt' do |f|
        result = GPS::parse_time f.ctime, '175055.354'
        result.should be_an_instance_of Time
      end
    end

  end

  describe GPS::Record do

    # stub out a new instance of GPS::Record
    let(:record) do
      GPS::Record.new(
        :time       => Time.now,
        :longitude  => 2.23,
        :latitude   => 3.12,
        :satelites  => 3,
        :altitude   => 10.1
      )
    end

    it 'should raise ArgumentError if no arguments are provided' do
      lambda { GPS::Record.new.should raise_error ArgumentError }
    end

    it { record.should be_an_instance_of GPS::Record }

    it { record.time.should be_an_instance_of Time }

  end

  describe GPS::Parser do

    let(:parser) { GPS::Parser.new }
    let(:load_gps_strings) { parser.load_gps_strings 'spec/lib/test_gps_data.txt' }

    it 'should initialize with a bare array of GPS records' do
      parser.records.should be_an Array
    end

    it 'should be able to load GPS data from a text file' do
      load_gps_strings
      parser.instance_variable_get(:@f).should be_a File
    end

    it 'should be able to parse the GPS strings into something useful' do
      load_gps_strings
      parser.parse_gps
      parser.records.first.should be_an_instance_of GPS::Record
    end

  end

end

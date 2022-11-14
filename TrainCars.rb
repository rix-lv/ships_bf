require 'json'

class TrainCars
  attr_accessor :car_number
  @@all_cars = []
  def initialize(prev_car_nmbr)
    @prev_car_number = prev_car_nmbr
    @car_number = prev_car_nmbr + 5
    @@all_cars << self
    store_to_file
  end

  def store_to_file
    file = File.open("train cars.txt", "a")
    data = {@car_number => @prev_car_number}
    file.write("#{data.to_json}\n")
    file.close
  end

  def self.clear
    File.open("train cars.txt", "w").close
  end

  def self.find_prev(nmbr)
    h = {}
    prev = nil
    File.foreach("train cars.txt") do |line|
      h.merge! JSON.parse(line)
    end
    h.each {|k, v| prev = v if k == nmbr.to_s}
    prev
  end

end

TrainCars.clear
10.times {|i| TrainCars.new(i*10)}
p TrainCars.find_prev(55)
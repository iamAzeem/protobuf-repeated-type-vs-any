#!/usr/bin/env ruby

require_relative "person_pb"
require 'google/protobuf/well_known_types'

persons_data = [
    { first_name: "abc", last_name: "def", age: 20 },
    { first_name: "def", last_name: "ghi", age: 21 },
    { first_name: "jkl", last_name: "mno", age: 22 },
    { first_name: "pqr", last_name: "stu", age: 23 },
].freeze

# any

any = Test::PersonAny.new
persons_data.each do |data|
    person = Test::Person.new( data )
    message = Google::Protobuf::Any.pack( person )
    any.persons.push( message )
end

any_encoded_binary = Test::PersonAny.encode( any )
any_encoded_json = Test::PersonAny.encode_json( any )

puts "Any:"
puts "- Binary : #{any_encoded_binary.length}"
puts "- JSON   : #{any_encoded_json.length}"

# array

array = Test::PersonArray.new
persons_data.each do |data|
    person = Test::Person.new( data )
    array.persons.push( person )
end

array_encoded_binary = Test::PersonArray.encode( array )
array_encoded_json = Test::PersonArray.encode_json( array )

puts "Array:"
puts "- Binary : #{array_encoded_binary.length}"
puts "- JSON   : #{array_encoded_json.length}"

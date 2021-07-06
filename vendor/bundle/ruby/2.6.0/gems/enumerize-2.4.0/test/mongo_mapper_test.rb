# frozen_string_literal: true

require 'test_helper'

begin

silence_warnings do
  require 'mongo_mapper'
end

MongoMapper.connection = Mongo::Client.new(['localhost:27017'], database: 'enumerize-test-suite-of-mongomapper')

describe Enumerize do
  class MongoMapperUser
    include MongoMapper::Document
    extend Enumerize

    key :sex
    key :role
    key :foo

    enumerize :sex,  :in => %w[male female]
    enumerize :role, :in => %w[admin user], :default => 'user'
    enumerize :foo,  :in => %w[bar baz], :skip_validations => true
  end

  before { $VERBOSE = nil }
  after  { $VERBOSE = true }

  let(:model) { MongoMapperUser }

  it 'sets nil if invalid value is passed' do
    user = model.new
    user.sex = :invalid
    user.sex.must_be_nil
  end

  it 'saves value' do
    model.delete_all
    user = model.new
    user.sex = :female
    user.save!
    user.sex.must_equal 'female'
  end

  it 'loads value' do
    model.delete_all
    model.create!(:sex => :male)
    store_translations(:en, :enumerize => {:sex => {:male => 'Male'}}) do
      user = model.first
      user.sex.must_equal 'male'
      user.sex_text.must_equal 'Male'
    end
  end

  it 'has default value' do
    model.new.role.must_equal 'user'
  end

  it 'validates inclusion' do
    user = model.new
    user.role = 'wrong'
    user.wont_be :valid?
  end

  it 'does not validate inclusion when :skip_validations option passed' do
    user = model.new
    user.foo = 'wrong'
    user.must_be :valid?
  end

  it 'assigns value on loaded record' do
    model.delete_all
    model.create!(:sex => :male)
    user = model.first
    user.sex = :female
    user.sex.must_equal 'female'
  end
end

rescue LoadError
  # Skip
end

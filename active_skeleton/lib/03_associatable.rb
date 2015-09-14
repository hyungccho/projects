require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.to_s.constantize
  end

  def table_name
    (@class_name.constantize.to_s + "s").downcase
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    options.each do |key, value|
      if key == :class_name
        @class_name = value
      else
        self.send("#{key}=", value)
      end
    end

    self.foreign_key = "#{name}_id".to_sym if options[:foreign_key].nil?
    self.primary_key = :id if options[:primary_key].nil?
    self.class_name = name.capitalize if options[:class_name].nil?
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options.each do |key, value|
      if key == :class_name
        @class_name = value
      else
        self.send("#{key}=", value)
      end
    end

    self.foreign_key = "#{self_class_name}_id".downcase.to_sym if options[:foreign_key].nil?
    self.primary_key = :id if options[:primary_key].nil?
    self.class_name = name.singularize.capitalize if options[:class_name].nil?
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    define_method("#{name}") do
      model = options.model_class
      f_key = self.send(options.foreign_key)

      model.where({ options.primary_key => f_key }).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, "#{self}", options)
    assoc_options[name] = options

    define_method("#{name}") do
      model = options.model_class
      p_key = self.send(options.primary_key)

      model.where({ options.foreign_key => p_key })
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end

class SQLObject
  extend Associatable
end

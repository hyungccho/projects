require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}

    SQL

    columns[0].map { |col| col.to_sym }
  end

  def self.finalize!
    columns.each do |col|
      define_method("#{col}=") do |col_name|
        attributes[col.to_sym] = col_name
      end

      define_method("#{col}") do
        attributes[col.to_sym]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    all_hashes = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    parse_all(all_hashes)
  end

  def self.parse_all(results)
    results.map do |instance|
      self.new(instance)
    end
  end

  def self.find(id)
    idx = self.all.map { |instance| instance.id }.index(id)
    result = self.all

    if idx.nil?
      nil
    else
      result[idx]
    end
  end

  def initialize(params = {})
    params.each do |key, value|
      key = key.to_sym
      raise "unknown attribute '#{key}'" unless self.class.columns.include?(key)
      self.send("#{key}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| self.send("#{col}")}
  end

  def insert
    col_names = self.class.columns.join(", ")
    question_marks = (["?"] * self.class.columns.length).join(", ")

    last_insert = DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.send("id=", DBConnection.last_insert_row_id)
  end

  def update
    updating_cols = self.class.columns.drop(1).map { |col| "#{col} = ?"}.join(", ")
    p attribute_values

    DBConnection.execute(<<-SQL, *attribute_values.rotate(1))
      UPDATE
        #{self.class.table_name}
      SET
        #{updating_cols}
      WHERE
        id = ?
    SQL
  end

  def save
    id = self.send("id")

    if id.nil?
      insert
    else
      update
    end
  end
end

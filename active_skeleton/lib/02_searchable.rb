require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    keys = params.keys.map { |key| "#{key} = ?" }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{keys}
    SQL

    objects = self.parse_all(results)
  end
end

class SQLObject
  extend Searchable
end

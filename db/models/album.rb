require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

 attr_reader :id, :genre, :artist_id

  def initialize(album)
    @id = album['id'].to_i if album['id']
    @genre = album['genre']
    @artist_id = album['artist_id']
  end

def save()
  sql = "INSERT INTO albums(genre, artist_id)
  VALUES ($1, $2) RETURNING id"
  values = [@genre, @artist_id]
  @id = SqlRunner.run(sql, values)[0]["id"].to_i
end


  def self.delete_all
    sql = "DELETE FROM albums"
    result = SqlRunner.run(sql)
  end

end

require('pg')

class Album

 attr_reader :id, :genre
 attr_accessor :artist_id

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

  def self.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def get_artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values).first()
    return Artist.new(artist)
  end

  def update
    sql = "UPDATE albums SET (genre,artist_id) = ($1,$2) WHERE id = $3"
    values = [@genre,@artist_id,@id]
    SqlRunner.run(sql,values)
  end

end

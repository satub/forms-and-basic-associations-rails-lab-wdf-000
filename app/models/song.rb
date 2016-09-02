
class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes


  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre.name
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    if !self.artist.nil?
      self.artist.name
    end
  end

  def note_contents=(notes)
    notes.each do |note|
      new_note = Note.create(content: note)
      if new_note.valid?
        self.notes << new_note
      end
      self.save
    end
  end

  def note_contents
    self.notes.collect do |note|
      note.content
    end
  end


end

class Pokemon
  attr_accessor :id ,:name, :type, :db
  
  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name 
    @type = type
    @db = db
  end
  
  def save(name, type, db)
    if self.id
      db.execute("UPDATE pokemon SET name = ? SET type = ? WHERE id = ? ",name,type,self.id)
      self.name = name 
      self.type = type
      poke = self
    else
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?)",name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    poke = self
    end
    poke
  end
  
  def self.find(id, db)
    poke = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    if poke[0]
    name = poke[1]
    type = poke[2]
    pokef = self.new(id: id, name: name, type: type, db: db)
    else
      pokef = nil
    end
    pokef
 end

end

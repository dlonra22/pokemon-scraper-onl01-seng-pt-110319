class Pokemon
  attr_accessor :id ,:name, :type, :db
  
  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name 
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?)",name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
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

require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  # refactor pls
  def get(key)
    value = nil
    
    if @map.include?(key)
      value = @map.get(key)
      update_link!(key, value)
    else
      if count > @max
        eject!
      end
      value = @prc.call(key)
      calc!(key, value)
    end
    value
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key, value)
    @map.set(key, value)
    @store.insert(key, value)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(key, value)
    # suggested helper method; move a link to the end of the list
    @store.remove(key)
    @store.insert(key, value)
  end

  def eject!
    oldest = @store.first
    @map.delete(oldest)
    @store.remove(oldest)
  end
end

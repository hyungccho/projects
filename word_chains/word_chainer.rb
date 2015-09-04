require "set"

class WordChainer

  attr_reader :dictionary, :current_words, :all_seen_words
  attr_accessor :current_words

  def initialize(dictionary_file_name)
    @dictionary = Set.new
    @current_words = Hash.new
    @all_seen_words = Hash.new
    load_dictionary(dictionary_file_name)
  end

  def load_dictionary(file)
    File.open(file).each do |line|
      dictionary << line.chomp
    end
  end

  def adjacent_words(word)
    @short_dictionary.select do |dictionary_word|
      adjacent?(word, dictionary_word)
    end
  end

  def adjacent?(word1, word2)
    return false unless word1.length == word2.length
    difference = 0
    word1.length.times do |index|
      difference += 1 unless word1[index] == word2[index]
    end
    difference == 1
  end

  def run(src, target)
    current_words[src] = nil
    all_seen_words[src] = nil
    @short_dictionary = dictionary.reject { |word| word.length != src.length }
    until current_words.empty? || all_seen_words.has_key?(target)
      new_current_words = Hash.new
      current_words.each do |current_word, _|
        new_current_words.merge!(explore_current_words(current_word))
      end
      self.current_words = new_current_words
      all_seen_words.merge!(current_words)
    end
    render(target)

  end

  def explore_current_words(current_word)
    new_current_words = Hash.new
    adjacent_words(current_word).each do |adjacent_word|
      new_current_words[adjacent_word] = current_word unless all_seen_words.has_key?(adjacent_word)
    end
    new_current_words
  end

  def render(target)
    result = "#{target}"
    until all_seen_words[target].nil?
      result = all_seen_words[target] + " => " + result
      target = all_seen_words[target]
    end
    result
  end
end

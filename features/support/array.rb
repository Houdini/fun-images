class Array
  def each_pair_index
    (0..(length - 1)).each do |i|
      ((i+1)..(length - 1)).each do |j|
        yield i, j
      end
    end
  end

  def each_pair
    each_pair_index do |i, j|
      yield self[i], self[j]
    end
  end
end

class Date
  def to_i
    to_s.gsub('-', '').to_i
  end
end
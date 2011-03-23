class Fixnum
  def to_date
    s = to_s
    Date.parse s[0..s.size-5] + '-' +  s[-4..-3] + '-' + s[-2..-1]
  end

  def to_string_date
    s = to_s
    s[0..s.size-5] + '-' +  s[-4..-3] + '-' + s[-2..-1]
  end
end
class Object
  def self.const_missing(c)
    return nil if @calling_const_missing

    @calling_const_missing = true
    require c.to_s.underscore
    klass = Object.const_get(c)
    @calling_const_missing = false

    klass
  end
end

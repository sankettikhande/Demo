ThinkingSphinx::Index.define :freight, :with => :active_record do
  indexes source
  indexes destination
  indexes freight_type

  has width, length, height, min_weight, max_weight, start_date, end_date, price
end
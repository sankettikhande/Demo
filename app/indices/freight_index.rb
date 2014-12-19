ThinkingSphinx::Index.define :freight, :with => :active_record do
  indexes source
  indexes destination
  indexes cut_off_date
  indexes freight_type

  has cbm, min_weight, max_weight, price
end
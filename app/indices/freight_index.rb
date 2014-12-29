ThinkingSphinx::Index.define :freight, :with => :active_record do
  indexes source_id
  indexes destination_id
  indexes freight_type

  has width, length, height, min_weight, max_weight, start_date, end_date, price, seller_id
end
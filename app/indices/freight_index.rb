ThinkingSphinx::Index.define :freight, :with => :active_record do
  indexes source
  indexes destination
  indexes min_weight
  indexes max_weight
  indexes cbm
end
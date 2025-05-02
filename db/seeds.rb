Plan.find_or_create_by!(name: '松') do |p|
  p.price            = 3000
  p.meal_sets_count  = 1
end

Plan.find_or_create_by!(name: '竹') do |p|
  p.price            = 5500
  p.meal_sets_count  = 2
end

Plan.find_or_create_by!(name: '梅') do |p|
  p.price            = 8000
  p.meal_sets_count  = 3
end

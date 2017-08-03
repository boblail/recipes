# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Recipe.delete_all
Rating.delete_all

john = User.create!(
  name: "John",
  email: "john@example.com",
  password: "password")
anne = User.create!(
  name: "Anne",
  email: "anne@example.com",
  password: "password")

salad = Recipe.create!(
  created_by: john,
  name: "Steak Salad",
  ingredients: <<~TEXT,
    2 7oz New York Strip steaks
    Spring Mix
    Cherry Tomatoes, quartered
    Green Onions, sliced
    Blue Cheese crumbles
    Balsamic vinegrette
  TEXT
  instructions: <<~TEXT,
    Grill the steaks over very hot coals: 90 seconds on each side, and then another 45-60 seconds on each side, slice thinly.
  TEXT
  tags: %w{salad grill},
  cost: 3,
  effort: 2)

salad.ratings.create!(user: john, name: john.name, value: 3)
salad.ratings.create!(user: anne, name: anne.name, value: 2)

Recipe.create!(
  created_by: anne,
  name: "Almond Chutney Chicken Lettuce Wraps",
  ingredients: <<~TEXT,
    1 3lb roasted chicken
    1 med. red onion, diced
    Grated zest & juice of 1 lg lemon
    2 jalapeños, seeded and diced
    1 9oz jar of Major Grey Chutney (cut up large pieces, if necessary)
    1/4 c mayo
    salt and ground pepper
    3 large celery stalks, diced
    1 c coarsely chopped or sliced almonds
    1+ large head Bibb lettuce, washed, dried, and leaves separated
    bunch of basil
    bunch of coriander
    8 radishes, thinly sliced
    1 large cucumber, peeled and thinly sliced
  TEXT
  instructions: <<~TEXT,
    Clean chicken, and cut meat into bite-sized pieces. In a large bowl, combine onion, lemon zes and juice, jalapeños, chutney, mayo, and salt and pepper. Fold in chicken. Taste and add more lemon, mayo, and herbs as needed. Let stand for aprox. 20 minutes for the flavors to blend (can also refrigerate overnight). Add celery and nuts when ready to serve. Take lettuce leaf, add a few sliced veggies and herbs, and top with chicken salad.
  TEXT
  tags: %w{},
  cost: 2,
  effort: 2)

Recipe.create!(
  created_by: anne,
  name: "Quinoa Cajun Jumbalaya",
  ingredients: <<~TEXT,
    2 tablespoons olive oil, approximately
    1 medium onion, chopped
    3 celery stalk with leaves, chopped
    1 large green pepper, chopped
    2 garlic cloves, minced
    1 14 ounce can petite diced tomatoes with garlic and onion
    ¾ cup rinsed quinoa
    1 ½ cups chicken stock, plus more if needed
    ½ teaspoon garlic powder
    ½ teaspoon oregano
    ½ pound chicken breast cut into bite-sized pieces
    ¼ pound shrimp, peeled and deveined
    2 tsp Cajun seasoning
    3 andoille sausage link
  TEXT
  instructions: <<~TEXT,
    Put chicken pieces and shrimp in two bowls, and toss with approximately 1tsp each of cajun seasoning. Set aside.
    In a large skillet, heat 1 Tbsp of olive oil over a medium heat. Add onion, celery and green pepper. Saute for 2-3 minutes until softened. Add garlic, saute another minute.
    Add tomatoes, quinoa, remaining 1/2 tsp cayenne, 1 tsp paprika, 1/2 tsp garlic powder, 1/2 tsp oregano and chicken stock. Bring mixture to a boil and reduce to a low simmer, cover until quinoa is cooked, about 15 minutes.
    While veggie and quinoa are cooking, add sliced sausage to a separate pan, sear until brown on both sides, about 1-2 minutes. Remove from pan, set aside. Cook chicken next, set aside, and then shrimp.
    When quinoa mixture is done, add the sausage, chicken, and shrimp.
    Season to taste with salt, pepper and cayenne. Serve with sliced green onion.
  TEXT
  tags: %w{},
  cost: 2,
  effort: 2)

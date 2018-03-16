if Rails.env.development?

  users = [
    {
      first_name: "Sally",
      last_name: "Bones",
      email: "sallybones@test.com",
      password: "password",
      admin: false
    }, {
      first_name: "Johnny",
      last_name: "Axle",
      email: "jaxle@test.com",
      password: "password",
      admin: false
    }, {
      first_name: "Phil",
      last_name: "Keeper",
      email: "philkeeper@test.com",
      password: "password",

      encrypted_password: "password",
      admin: false
    }, {
      first_name: "Jake",
      last_name: "Fruci",
      email: "jakefruci@test.com",
      password: "password",
      admin: true
    }
  ]

  users.each do |user_params|
    User.create!(user_params)
  end

  albums = [
    {
      title: "Innerspeaker",
      artist: "Tame Impala",
      summary: "Sounding a bit like Lennon, rocking a bit like Pink Floyd. It's a mix, and you don't want to forget it.",
      release_year: '2012',
      genre: "psych-rock",
      user: User.first,
      tracks: ['It is Not Meant To Be', 'Desire Be Desire Go', 'Alter Ego', 'Lucidity', 'Why Wont You Make Up Your Mind?', 'Solitude Is Bliss', 'Jeremys Storm', 'Expectation', 'Bold Narrow Of Time', 'Runway Houses, Cities, And Clouds','I Dont Really Mind']
    }, {
      title: "Little Dark Age",
      artist: "MGMT",
      summary: "I'm so glad these guys came back with a new album. It's a mixture of something in older taste & more social themes",
      release_year: '2018',
      genre: "alternative-rock",
      user: User.second,
      tracks: ['She Works Out Too Much', 'Little Dark Age', 'When You Die', 'Me And Michael', 'TSLAMP', 'James', 'Days That Got Away', 'One Thing Left To Try', 'When Youre Small', 'Hand It Over']
    }, {
      title: "DAMN.",
      artist: "Kendrick Lamar",
      summary: "My favorite rapper coming out with possibly my favorite album. I didnt have time to put down the songs. Will do later.",
      release_year: '2017',
      genre: "rap",
      user: User.third
    }
  ]

  albums.each do |album_params|
    Album.create!(album_params)
    end

  reviews = [
    {
      body: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.",
      user: User.second,
      album: Album.first
    }, {
      body: "THIS IS THE FIRST REVIEWLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.",
      user: User.fourth,
      album: Album.second
    }, {
      body: "THIS IS THE SECOND REVIEWLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium.",
      user: User.fourth,
      album: Album.second
    }
  ]

  reviews.each do |review_params|
    Review.create!(review_params)
  end
end

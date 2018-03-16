FactoryBot.define do
  factory :album do
    sequence :title do |n|
      "Summer 0#{n}"
    end
    artist "Metronomy"
    release_year '2016'
    summary "A mix of indie & 80s. This veteran album from Metronomy brings a mix of dancers while still finding a way to make you feel something."
    genre "Nu-disco"
    tracks = ["Back Together", "Miami Logic", "Old Skool (feat. Mix Master Mike)", "16 Beat", "Hang Me Out To Dry", "Mick Slow", "My House", "Night Owl", "Love's not an obstacle", "Summer Jam"]
   end
end

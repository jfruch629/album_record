require 'rails_helper'

RSpec.describe Album, type: :model do
     it { should have_valid(:title).when('John', 'Sally') }
     it { should_not have_valid(:title).when(nil, '') }

     it { should have_valid(:summary).when('John', 'Sally') }
     it { should_not have_valid(:summary).when(nil, '') }

     it { should have_valid(:artist).when('Smith' ,'Swason') }
     it { should_not have_valid(:artist).when(nil, '')}

     it { should have_valid(:release_year).when('1234', '0000')}
     it { should_not have_valid(:release_year).when(nil, '')}
end
